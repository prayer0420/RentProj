package controller.login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import service.member.MemberService;
import service.member.MemberServiceImpl;

@WebServlet("/naver")
public class NaverLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public NaverLogin() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String code = request.getParameter("code");

		MemberService service = new MemberServiceImpl();
		try {
			Member member = service.NaverLogin(code);
			HttpSession session = request.getSession();
			session.setAttribute("id", member.getId());

			response.sendRedirect("main");

		} catch (Exception e) {

			e.printStackTrace();
			request.setAttribute("err", "로그인에 실패했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}

}
