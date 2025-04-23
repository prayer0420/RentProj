package controller.order;



import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Order;
import service.order.OrderService;
import service.order.OrderServiceImpl;
import utils.PageInfo;

/**
 * Servlet implementation class OrderList
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/orderList" })
public class OrderList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderList() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    
	// 처음 진입 시 검색 조건만 보여주고 결과는 없음
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("orderList", null);
		request.getRequestDispatcher("JSP/Admin/orderList.jsp").forward(request, response);

	}


	// 검색 조건을 받아 주문 목록 + 페이징 처리 수행
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8");

		// 1. 검색 조건 추출
	    String type = request.getParameter("type");              // 검색 기준 (orderNo or memberNo)
	    String keyword = request.getParameter("keyword");        // 검색어
	    String orderType = request.getParameter("order_type");   // 주문 유형 (판매, 나눔, 대여)
	    String startDate = request.getParameter("start_date");   // 시작일
	    String endDate = request.getParameter("end_date");       // 종료일

	    // 2. 페이지 번호 처리
	    String pageStr = request.getParameter("page");
	    int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
	    PageInfo pageInfo = new PageInfo(page);

	    // 3. 검색 파라미터들을 Map으로 정리
	    Map<String, Object> params = new HashMap<>();
	    params.put("type", type);
	    params.put("keyword", keyword);
	    params.put("order_type", orderType);
	    params.put("start_date", startDate);
	    params.put("end_date", endDate);

	    // 4. 서비스 호출
	    OrderService orderService = new OrderServiceImpl();
	    List<Order> orderList = orderService.searchOrders(params, pageInfo);

	    // 5. JSP로 데이터 전달
	    request.setAttribute("orderList", orderList);
	    request.setAttribute("pageInfo", pageInfo);
	    request.getRequestDispatcher("JSP/Admin/orderList.jsp").forward(request, response);
	}
	
}
	