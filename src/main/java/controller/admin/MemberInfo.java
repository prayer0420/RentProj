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
import utils.PageInfo;


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
			request.setAttribute("memberList", null);

	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    int page = 1;
	    try {
	        page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
	    } catch (NumberFormatException e) {
	        page = 1; // 기본값 fallback
	    }

	    int pageSize = 10;
	    int start = (page - 1) * pageSize;
	    
	    // 검색 조건 
		Map<String, Object> params = new HashMap<>();
		params.put("type", request.getParameter("type"));
		params.put("gradeId", request.getParameter("gradeId"));
		params.put("word", request.getParameter("word"));
	    params.put("start", start);
	    params.put("pageSize", pageSize);

	    
		try {
			MemberService memberService = new MemberServiceImpl();
		    List<Member> memberList = memberService.searchMembersPaging(params);
			int totalCount = memberService.countMembers(params);

		    // 페이지 정보 계산
		    int allPage = (int) Math.ceil((double) totalCount / pageSize);
		    int block = 10; // 페이지네이션 한 화면에 보여줄 블럭 수
		    int startPage = ((page - 1) / block) * block + 1;
		    int endPage = Math.min(startPage + block - 1, allPage);

		    PageInfo pageInfo = new PageInfo();
		    pageInfo.setCurPage(page);
		    pageInfo.setAllPage(allPage);
		    pageInfo.setStartPage(startPage);
		    pageInfo.setEndPage(endPage);
		    
			request.setAttribute("memberList", memberList);
		    request.setAttribute("pageInfo", pageInfo);
			request.getRequestDispatcher("/JSP/Admin/memberInfo.jsp").forward(request, response);
		}catch (Exception e) {
			e.printStackTrace();
		}		
	}

}
