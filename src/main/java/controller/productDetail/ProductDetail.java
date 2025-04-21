package controller.productDetail;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import dto.Product;
import service.product.ProductService;
import service.product.ProductServiceImpl;

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
		System.out.println(no);
		
		ProductService service = new ProductServiceImpl();
		try {
			Product product = service.selectProductOne(no);
			request.setAttribute("product", product);
			System.out.println("product : "+product);	
			System.out.println("no : "+no);	
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
