package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Order;
import service.order.OrderServiceImpl;

/**
 * Servlet implementation class RentalDelayList
 */
@WebServlet("/rentalDelayList")
public class RentalDelayList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RentalDelayList() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 검색 안 하고 진입만 처리
        	request.getRequestDispatcher("/JSP/Admin/rentalDelayList.jsp").forward(request, response);
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			OrderServiceImpl orderService = new OrderServiceImpl();
			request.setCharacterEncoding("UTF-8");
		
			// 검색 조건 파라미터
			String type = request.getParameter("type");
	        String keyword = request.getParameter("keyword");
	        // Service를 통해 지연 주문 목록 조회
	        List<Order> list = orderService.getDelayedOrders(type, keyword);
	        // 결과를 JSP에 전달
	        request.setAttribute("orderList", list);
	        request.getRequestDispatcher("/JSP/Admin/rentalDelayList.jsp").forward(request, response);
	
	}

}
