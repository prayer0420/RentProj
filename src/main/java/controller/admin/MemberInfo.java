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
		// JSP로 진입만, 검색 결과는 초기에는 없음
		request.getRequestDispatcher("JSP/Admin/memberInfo.jsp").forward(request, response);
		request.setAttribute("memberList", null);

	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 회원 검색 및 페이징 처리 요청 (검색어, 필터 등 포함)
		
	    request.setCharacterEncoding("UTF-8");

		// 1. 검색 조건 추출
	    String type = request.getParameter("type");        // 검색 대상 (id, name, phone)
	    String word = request.getParameter("word");        // 검색어
	    String gradeIdParam = request.getParameter("gradeId"); // 회원등급 문자열 (bronze, silver 등)
		// 2. 등급 문자열 → 숫자 ID로 변환    
	    Integer gradeId = null;
	    if (gradeIdParam != null && !"all".equals(gradeIdParam)) {
	        switch (gradeIdParam) {
	            case "bronze": gradeId = 1; break;
	            case "silver": gradeId = 2; break;
	            case "gold": gradeId = 3; break;
	            case "platinum": gradeId = 4; break;
	            case "dia": gradeId = 5; break;
	            case "rent": gradeId = 6; break;
	        }
	    }
		// 3. 페이지 번호 처리
	    String pageStr = request.getParameter("page");
	    int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;

	    PageInfo pageInfo = new PageInfo(page);
	    
		// 4. 검색 파라미터들을 Map에 담기
	    Map<String, Object> params = new HashMap<>();
	    params.put("type", type);
	    params.put("word", word);
	    params.put("gradeId", gradeId);

	    try {
			// 5. 서비스 호출하여 검색 결과 + 페이징 처리
	        MemberService memberService = new MemberServiceImpl();
	        List<Member> memberList = memberService.searchMembersWithPaging(params, pageInfo);

			// 6. 검색 결과 JSP에 전달
	        request.setAttribute("memberList", memberList);
	        request.setAttribute("pageInfo", pageInfo);
	        request.getRequestDispatcher("/JSP/Admin/memberInfo.jsp").forward(request, response);

	    } catch (Exception e) {
	        e.printStackTrace(); // 예외 디버깅용
		}		
	}

}
