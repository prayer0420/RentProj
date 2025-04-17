package controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Member;
import service.member.MemberService;
import service.member.MemberServiceImpl;


/**
 * Servlet implementation class MemberInfo
 */
@WebServlet("/memberInfo")
public class MemberInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberInfo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

			request.getRequestDispatcher("JSP/Admin/memberInfo.jsp").forward(request, response);

	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Map<String, Object> params = new HashMap<>();
		params.put("type", request.getParameter("type"));
		params.put("gradeId", request.getParameter("gradeId"));
		params.put("word", request.getParameter("word"));

		System.out.println(params);
		try {
			MemberService memberSevice = new MemberServiceImpl();
			List<Member> memberList = memberSevice.searchMembers(params);
			request.setAttribute("memberList", memberList);
			request.getRequestDispatcher("JSP/Admin/memberInfo.jsp").forward(request, response);
		}catch (Exception e) {
			e.printStackTrace();
		}		
	}

}
