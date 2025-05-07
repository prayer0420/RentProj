package controller.login;



import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout")
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Logout() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		//세션 삭제
        session.removeAttribute("adminNo");  // 관리자 정보 제거
		session.removeAttribute("no");
		session.removeAttribute("id");
		session.removeAttribute("location");
		session.removeAttribute("latitude");
		session.removeAttribute("longitude");
		session.removeAttribute("nickname");
		session.removeAttribute("alarms");
		
		response.sendRedirect("main");

	}
}
