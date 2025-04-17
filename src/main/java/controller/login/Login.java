package controller.login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import service.MemberService;
import service.MemberServiceImpl;

@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Login() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/JSP/Login/login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String type = request.getParameter("type");
		
		System.out.println(type);
		
		MemberService service = new MemberServiceImpl();
		try {
			Member member = service.login(id, password);
			member.setPassword("");
			HttpSession session = request.getSession();
			session.setAttribute("member", member);
			
			//자동로그인 체크에 따른 쿠키 설정
			Cookie cookie1 = null;
			Cookie cookie2 = null;
			Cookie cookie3 = null;
			
			if(type==null || type.equals("")) {
				cookie1 = new Cookie("type", type);
				cookie2 = new Cookie("id", id);
				cookie3 = new Cookie("password", password);
			}
			
			response.addCookie(cookie1);
			response.addCookie(cookie2);
			response.addCookie(cookie3);
		
			//로그인 성공하면 이동할 홈페이지~
			response.sendRedirect("list");
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "로그인에 실패했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}
}
