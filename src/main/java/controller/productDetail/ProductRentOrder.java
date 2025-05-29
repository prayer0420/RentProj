package controller.productDetail;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Product;
import service.product.ProductService;
import service.product.ProductServiceImpl;

/**
 * Servlet implementation class ProductRentOrder
 */
@WebServlet("/productRentOrder")
public class ProductRentOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductRentOrder() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		int productNo = Integer.parseInt(request.getParameter("productNo"));
		String address1 = (String) request.getSession().getAttribute("address1");
		String phone = (String) request.getSession().getAttribute("phone");
		System.out.println("phone:" + phone);
		String nickname = (String) request.getSession().getAttribute("nickname");
		String orderType = request.getParameter("tradeType");
		String startDate = request.getParameter("startDate"); // 유저 선택 시작일
		String endDate = request.getParameter("endDate"); // 유저 선택 종료일
		String productStartDate = request.getParameter("productStartDate"); // 상품 예약 가능 시작일
		String productEndDate = request.getParameter("productEndDate"); // 상품 예약 가능 종료일
		System.out.println("💬 productStartDate: " + startDate);
		System.out.println("💬 productEndDate: " + endDate);
		ProductService service = new ProductServiceImpl();

		try {
			Product product = service.selectProductOne(productNo);
			HttpSession session = request.getSession(false);
			if (session == null || session.getAttribute("id") == null) {
				response.sendRedirect(request.getContextPath() + "/login");
				return;
			}
			request.setAttribute("product", product);
			request.setAttribute("phone", phone);
			request.setAttribute("nickname", nickname);
			request.setAttribute("orderType", orderType);
			request.setAttribute("startDate", productStartDate);
			request.setAttribute("endDate", productEndDate);
			request.setAttribute("mStartDate", startDate);
			request.setAttribute("mEndDate", endDate);
			request.getRequestDispatcher("/JSP/ProductDetail/orderRent.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
