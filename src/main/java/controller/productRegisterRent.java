package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Product;
import service.ProductService;
import service.ProductServiceImpl;

/**
 * Servlet implementation class productRegisterRent
 */
@WebServlet("/rent")
public class productRegisterRent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public productRegisterRent() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/productRegisterRent.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
//		Integer no = Integer.parseInt(request.getParameter("no"));
		Integer no = 1;
		Integer categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String state = request.getParameter("state");
//		String img = request.getParameter("img");
		String img = "123.jpg";
//		String deliveryAddr = request.getParameter("deliveryAddr");
		String deliveryAddr = "장곡동";
//		Integer deliveryPrice = Integer.parseInt(request.getParameter("deliveryPrice"));
		Integer deliveryPrice = 1000;
		String tradeType = request.getParameter("tradeType");
//		Integer secPrice = Integer.parseInt(request.getParameter("secPrice"));
		Integer secPrice = 10000;
//		Integer memberNo = Integer.parseInt(request.getParameter("memberNo"));
		Integer memberNo = 1;
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
//		Integer salePrice = Integer.parseInt(request.getParameter("salePrice"));
		Integer salePrice = 1000;
//		Integer rentPrice = Integer.parseInt(request.getParameter("rentPrice"));
		Integer rentPrice = 1000;
		String deliveryStatus = request.getParameter("deliveryStatus");
		
		Product product = new Product(no, categoryNo, title, content, state, img, deliveryAddr, deliveryPrice, tradeType, secPrice,
				memberNo, startDate, endDate, salePrice, rentPrice, deliveryStatus);
		
		System.out.println(product);
		ProductService service = new ProductServiceImpl();
		try{
			service.registRent(product);
			request.setAttribute("product", product);
			request.getRequestDispatcher("/productRegisterRent.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
		
		
		
	}

}
