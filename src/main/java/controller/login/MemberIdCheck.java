package controller.login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.MemberService;
import service.MemberServiceImpl;

@WebServlet("/memberDoubleId")
public class MemberIdCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberIdCheck() {
        super();
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		MemberService service = new MemberServiceImpl();
		try {
			boolean doubleId = service.checkDoubleId(id);
			response.getWriter().write(String.valueOf(doubleId));
		}catch(Exception e) {
			e.printStackTrace();
			response.getWriter().write(String.valueOf("아이디 중복 체크 실패"));
		}
	}
}