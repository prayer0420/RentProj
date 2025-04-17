package controller.join;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Member;
import service.member.MemberService;
import service.member.MemberServiceImpl;

@WebServlet("/join")
public class Join extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Join() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/JSP/Login/join.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.setCharacterEncoding("utf-8");
		
		//member의 필수값 파라미터 가져오기
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String nickname = request.getParameter("nickname");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String addrAlias = request.getParameter("addrAlias");
		String address = request.getParameter("address");
		String postcode = request.getParameter("postcode");
		String detailAddress = request.getParameter("detailAddress");
		String totalAddress = addrAlias+"@@"+address+"@@"+postcode+"@@"+detailAddress;
		String region1 = request.getParameter("region1");
		
		//builder시작(필수값 전달)
		Member member= new Member(id, password, name,nickname, phone, totalAddress, region1);
		
		//선택값 있으면 추가
		member.setAdminNo(0);
		
		
		String region2 = request.getParameter("region2");
		if(region2 != null && !region2.isEmpty()) {
			member.setRegion2(region2);
		}
		
		String region3 = request.getParameter("region3");
		if(region3 != null && !region3.isEmpty()) {
			member.setRegion3(region3);
		}
		
		//서비스 로직
		MemberService service = new MemberServiceImpl();
		
		try {
			service.join(member);
			//response.sendRedirect("login"); //servlet의 login호출, doGet으로 호출
		}catch(Exception e) {
			e.printStackTrace();
			if(e instanceof Exception) {
				request.setAttribute("err", "회원가입에 실패했습니다.");
				request.getRequestDispatcher("error.jsp").forward(request, response);
			}
		}
	}
}
