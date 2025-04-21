package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Member;
import service.member.MemberService;
import service.member.MemberServiceImpl;

/**
 * Servlet implementation class AdminInfo
 */
@WebServlet("/adminInfo")
public class AdminInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminInfo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 서비스 생성 및 관리자 정보 조회
        MemberService memberService = new MemberServiceImpl();
        Member admin = memberService.selectAdmin();
		// 2. 조회한 관리자 정보를 request에 저장
        request.setAttribute("admin", admin);
		// 3. JSP로 포워딩
        request.getRequestDispatcher("JSP/Admin/adminInfo.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 인코딩 및 응답 타입 설정
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/plain; charset=UTF-8");
		// 2. 전달받은 파라미터 추출
	    String id = request.getParameter("id");
	    String password = request.getParameter("password");
	    String name = request.getParameter("name");
	    String nickname = request.getParameter("nickname");
		// 3. 수정할 관리자 정보 객체 생성
	    Member admin = new Member();
	    admin.setId(id);
	    admin.setPassword(password);
	    admin.setName(name);
	    admin.setNickname(nickname);

	    try {
		  // 4. 서비스 객체 생성 및 업데이트 실행
	      MemberService service = new MemberServiceImpl();
	      service.updateAdminInfo(admin);

	      // 5. 성공 응답 전송
	      response.getWriter().write("관리자 정보가 수정되었습니다.");
	    } catch (Exception e) {
	      // 6. 예외 발생 시 에러 응답 전송
	      e.printStackTrace();  
	      response.setStatus(500);
	      response.getWriter().write("수정 실패: " + e.getMessage());
	    }
	  }
	}
