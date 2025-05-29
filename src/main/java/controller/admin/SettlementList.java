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
import utils.PageInfo;

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
        String revenueType = request.getParameter("searchRevenueType");
        String searchFeeStatus = request.getParameter("searchFeeStatus");
        String completedStart = trimOrNull(request.getParameter("completedStart"));
        String completedEnd = trimOrNull(request.getParameter("completedEnd"));

        // [2] 페이징 관련
        int curPage = 1;
        int size = 12;
        if (request.getParameter("page") != null) {
            curPage = Integer.parseInt(request.getParameter("page"));
        }
        int row = (curPage - 1) * size;

        // [3] 검색 조건 + 페이징 정보 Map에 담기
        Map<String, Object> searchMap = new HashMap<>();
        searchMap.put("searchRevenueType", revenueType);
        if (searchFeeStatus != null && !searchFeeStatus.isEmpty()) {
            searchMap.put("searchFeeStatus", searchFeeStatus);
        }
        searchMap.put("completedStart", completedStart);
        searchMap.put("completedEnd", completedEnd);
        searchMap.put("row", row);
        searchMap.put("size", size);
        
        System.out.println("searchMap = " + searchMap); // 디버깅용

        try {
            // [4] 전체 개수 구하기
            int totalCount = settlementService.getSettlementCount(searchMap);
            int allPage = (int) Math.ceil((double) totalCount / size);
            if (allPage == 0) {
                allPage = 1;  // 최소 1페이지 보정
            }
            int startPage = ((curPage - 1) / 10) * 10 + 1;
            int endPage = Math.min(startPage + 9, allPage);

            // [5] PageInfo 객체에 값 채우기
            PageInfo pageInfo = new PageInfo();
            pageInfo.setCurPage(curPage);
            pageInfo.setAllPage(allPage);
            pageInfo.setStartPage(startPage);
            pageInfo.setEndPage(endPage);
            pageInfo.setPageSize(size);
            pageInfo.setTotalCount(totalCount);

            // [6] Service 호출 (리스트 가져오기)
            List<Settlement> settlementList = settlementService.getSettlementList(searchMap);

            // [7] 총 수수료 합계 구하기 (전체 기준)
            int totalFeeAmount = settlementService.getTotalFeeAmount(searchMap);

            // [8] 결과를 JSP로 전달
            request.setAttribute("settlementList", settlementList);
            request.setAttribute("totalFeeAmount", totalFeeAmount);
            request.setAttribute("searchMap", searchMap);
            request.setAttribute("pageInfo", pageInfo);

            request.getRequestDispatcher("/JSP/Admin/settlementList.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "정산 리스트 조회 중 오류가 발생했습니다.");
            request.setAttribute("returnUrl", "/settlementList");
            request.getRequestDispatcher("/JSP/Admin/error.jsp").forward(request, response);
        }
    }

    private String trimOrNull(String param) {
        return (param != null && !param.trim().isEmpty()) ? param.trim() : null;
    }
}