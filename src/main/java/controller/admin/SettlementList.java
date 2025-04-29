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

import dto.Settlement;
import service.settlement.SettlementService;
import service.settlement.SettlementServiceImpl;

/**
 * Servlet implementation class SettlementList
 */
@WebServlet("/settlementList")
public class SettlementList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SettlementList() {
        super();
        // TODO Auto-generated constructor stub
    }


    private SettlementService settlementService = new SettlementServiceImpl();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		// 검색 조건 없이 JSP로만 이동 (처음 페이지 진입)
        request.getRequestDispatcher("/JSP/Admin//settlementList.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // [1] 검색 조건 받기
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String revenueType = request.getParameter("revenueType"); // 판매/대여 타입

        // [2] 검색 조건을 Map에 담기
        Map<String, Object> searchMap = new HashMap<>();
        searchMap.put("searchStartDate", startDate);
        searchMap.put("searchEndDate", endDate);
        searchMap.put("searchRevenueType", revenueType);
        searchMap.put("searchFeeStatus", "COMPLETE"); // 항상 정산완료만 검색
        
        try {
        // [3] Service 호출 (리스트 가져오기)
        List<Settlement> settlementList = settlementService.getSettlementList(searchMap);
        
        // [4] 총 수수료 합계 구하기 (feeAmount만)
        int totalFeeAmount = 0;
        for (Settlement s : settlementList) {
            totalFeeAmount += s.getFeeAmount();
        }

        // [5] 결과를 JSP에 전달
        request.setAttribute("settlementList", settlementList);
        request.setAttribute("totalFeeAmount", totalFeeAmount);
        request.getRequestDispatcher("/JSP/Admin/settlementList.jsp").forward(request, response);
        
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 발생 시 에러 페이지로 이동하거나 에러 메시지 전달
            request.setAttribute("error", "정산 리스트 조회 중 오류가 발생했습니다.");
            request.setAttribute("returnUrl", "/settlementList"); // 돌아갈 경로
            request.getRequestDispatcher("/JSP/Admin/error.jsp").forward(request, response);
        }
    }
	
}