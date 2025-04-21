package controller.mypage;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dto.Member;
import service.member.MemberService;
import service.member.MemberServiceImpl;

@WebServlet("/myInfoModify")
public class MyInfoModify extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MyInfoModify() {
        super();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Member member = (Member) session.getAttribute("member");
        
    	if (member == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
    	request.getRequestDispatcher("/JSP/MyPage/myInfoModify.jsp").forward(request, response);
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

	    HttpSession session = request.getSession();
	    Member sessionMember = (Member) session.getAttribute("member");

	    // 1. 사용자 입력 파라미터 수집
	    String id = request.getParameter("id");
	    String password = request.getParameter("password");
	    String confirmPassword = request.getParameter("confirmPassword");
	    String name = request.getParameter("name");
	    String nickname = request.getParameter("nickname");
	    String phone = request.getParameter("phone");
	    String region1 = request.getParameter("region1");
	    String region2 = request.getParameter("region2");
	    String region3 = request.getParameter("region3");

	    // 2. 비밀번호 확인
	    if (password != null && !password.equals(confirmPassword)) {
	    	request.setAttribute("error", "비밀번호가 일치하지 않습니다.");
	    	System.out.println("여기들어오나?");
	    	request.getRequestDispatcher("/JSP/MyPage/myInfoModify.jsp").forward(request, response);
	    	return;
	    }
	    // 3. 프로필 이미지 처리
	    Part profilePart = request.getPart("profileImage");
	    String profileImage = sessionMember.getProfileImage(); // 기본값

	    if (profilePart != null && profilePart.getSize() > 0) {
	      String fileName = UUID.randomUUID() + "_" + Paths.get(profilePart.getSubmittedFileName()).getFileName().toString();
	      String uploadDir = request.getServletContext().getRealPath("/upload/profile");
	      File saveDir = new File(uploadDir);
	      if (!saveDir.exists()) saveDir.mkdirs();
	      profilePart.write(uploadDir + "/" + fileName);
	      profileImage = "/upload/profile/" + fileName;
	    }

	    // 4. Member 객체 생성
	    Member updated = new Member();
	    updated.setId(id);
	    updated.setPassword(password);
	    updated.setNickname(nickname);
	    updated.setName(name);
	    updated.setPhone(phone);
	    updated.setRegion1(region1);
	    updated.setRegion2(region2);
	    updated.setRegion3(region3);
	    updated.setProfileImage(profileImage);

	    // 나머지는 기존 데이터 유지
	    updated.setAddress1(sessionMember.getAddress1());
	    updated.setAddress2(sessionMember.getAddress2());
	    updated.setAddress3(sessionMember.getAddress3());
	    updated.setGradeId(sessionMember.getGradeId());
	    updated.setAdminNo(sessionMember.getAdminNo());
	    updated.setOrderCount(sessionMember.getOrderCount());
	    updated.setLocation(sessionMember.getLocation());
	    updated.setFcmToken(sessionMember.getFcmToken());

	    try {
	      MemberService service = new MemberServiceImpl();
	      //서비스에게 업데이트 위임(비즈니스 로직)
	      System.out.println("새로운 정보 업데이트!");
	      service.updateMember(updated);
	      session.setAttribute("member", updated);
	      
	      response.sendRedirect(request.getContextPath() + "/myInfoModify");
	    } catch (Exception e) {
	      e.printStackTrace();
	      request.setAttribute("error", "회원 정보 수정에 실패했습니다.");
	      request.getRequestDispatcher("/JSP/MyPage/myInfoModify.jsp").forward(request, response);
	    }
	  }
}