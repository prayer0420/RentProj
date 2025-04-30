package controller.productDetail;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Product;
import service.order.OrderService;
import service.order.OrderServiceImpl;
import service.product.ProductService;
import service.product.ProductServiceImpl;
import service.review.ReviewService;
import service.review.ReviewServiceImpl;

@WebServlet("/productDetail")
public class ProductDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ProductDetail() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		Integer no = Integer.parseInt(request.getParameter("no"));
		Integer memberNo = (Integer)request.getSession().getAttribute("no");
		
		System.out.println("memberNo:"+memberNo);
		
		ProductService service = new ProductServiceImpl();
		ReviewService reviewService = new ReviewServiceImpl();
		OrderService orderService = new OrderServiceImpl();
		try {
			Product product = service.selectProductOne(no);
			double avgScore = reviewService.selectAvgScore(no);
			boolean hasOrder = orderService.hasMemberOrderProduct(memberNo, no);
			boolean checkOrder = orderService.checkOrder(no);
			boolean checkMyReview = reviewService.checkMyReview(no, memberNo);
			
			request.setAttribute("product", product);
			request.setAttribute("productNo", no);
			request.setAttribute("avgScore", avgScore);
			request.setAttribute("hasOrder", hasOrder);
			request.setAttribute("checkOrder",checkOrder);
			request.setAttribute("memberNo", memberNo);
			request.setAttribute("checkMyReview",checkMyReview);
			request.setAttribute("startDate", product.getStartDate());
			request.setAttribute("endDate", product.getEndDate());
			System.out.println("product : "+product);	
			System.out.println("no : "+no);	
			System.out.println("startDate"+product.getStartDate());
			System.out.println("startDate"+product.getEndDate());
		}catch (Exception e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("/JSP/ProductDetail/productDetail.jsp").forward(request, response);


	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
