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
import service.MemberService;
import service.MemberServiceImpl;


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
		
		Map<String, Object> params = new HashMap<>();
		params.put("gradeId", request.getParameter("gradeId") != null ? Integer.parseInt(request.getParameter("gradeId")) : 0);
		params.put("name", request.getParameter("name"));
		params.put("id", request.getParameter("id"));
		params.put("password", request.getParameter("password"));
		params.put("nickname", request.getParameter("nickname"));
		params.put("phone", request.getParameter("phone"));
		params.put("address1", request.getParameter("address1"));
		params.put("region1", request.getParameter("region1"));
		
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
