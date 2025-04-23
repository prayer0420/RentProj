package controller.order;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ProfitList
 */
@WebServlet("/profitList")
public class ProfitList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfitList() {
        super();
        // TODO Auto-generated constructor stub
    }

	// 처음 진입 시 검색 조건만 보여주고 결과는 없음
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/JSP/Admin/profitList.jsp").forward(request, response);
	}

	// 검색 조건을 받아 주문 목록 + 페이징 처리 수행
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/* request.setCharacterEncoding("UTF-8"); 
	    
        profitService = new ProfitServiceImpl(); // 서비스 구현체 초기화
	    
     // 1. 파라미터 수집
        String type = request.getParameter("type");
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");

        // 2. 검색 조건을 맵에 저장
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("type", type);
        paramMap.put("start_date", startDate);
        paramMap.put("end_date", endDate);

        // 3. 수익 데이터 조회
        List<Profit> profitList = profitService.searchProfitList(paramMap);

        // 4. 결과를 request 영역에 저장
        request.setAttribute("profitList", profitList);
        request.setAttribute("param", paramMap); // 파라미터도 유지할 경우

        // 5. JSP로 포워딩
        request.getRequestDispatcher("/JSP/Admin/profitList.jsp").forward(request, response);
	  */  
	} 

}
