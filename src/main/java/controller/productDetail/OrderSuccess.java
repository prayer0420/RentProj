package controller.productDetail;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Product;

/**
 * Servlet implementation class OrderSuccess
 */
@WebServlet("/success")
public class OrderSuccess extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderSuccess() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  // GET으로 넘어온 paymentKey, orderId, amount 파라미터를 받음
	    String paymentKey = request.getParameter("paymentKey");
	    String orderId = request.getParameter("orderId");
	    String amount = request.getParameter("amount");
	    Product product =(Product) request.getAttribute("product");
	    
	    String orderType = (String)request.getParameter("orderType");
	    
	    String deliveryAddr = request.getParameter("deliveryAddr");
	    

	    
	    // 여기서 orderId로부터 productNo 추출 (예: ORDER_123_1710000000)
	    String[] parts = orderId.split("_");
	    String productNo = parts[1]; // "123"
	    
	    // request에 담아서 JSP로 넘김
	    request.setAttribute("paymentKey", paymentKey);
	    request.setAttribute("orderId", orderId);
	    request.setAttribute("amount", amount);
	    request.setAttribute("productNo",productNo);
	    request.setAttribute("product",product);
	    request.setAttribute("deliveryAddr", deliveryAddr);
	    request.setAttribute("orderType",orderType);
	    
	    //confirm서블릿으로 넘기기
		request.getRequestDispatcher("/confirm").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
