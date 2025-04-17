<<<<<<<< HEAD:src/main/java/controller/admin/Logout.java
package controller.admin;
========
package controller.login;
>>>>>>>> dev:src/main/java/controller/login/Logout.java

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
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		//세션 삭제
		session.removeAttribute("member");
		response.sendRedirect("list");
	}
}
