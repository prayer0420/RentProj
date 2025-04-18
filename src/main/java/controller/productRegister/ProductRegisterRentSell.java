package controller.productRegister;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.Product;
import service.product.ProductService;
import service.product.ProductServiceImpl;

/**
 * Servlet implementation class ProductRegisterRentSell
 */
@WebServlet("/rentSell")
public class ProductRegisterRentSell extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductRegisterRentSell() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
request.setCharacterEncoding("utf-8");
		
		String path = request.getServletContext().getRealPath("upload");
		int size = 10*1024*1024;
		
		MultipartRequest multi = new MultipartRequest(request, path,size,"utf-8",new DefaultFileRenamePolicy());
		
		Integer categoryNo = Integer.parseInt(multi.getParameter("categoryNo"));
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String state = multi.getParameter("state");
		String img = multi.getFilesystemName("img");
//		String deliveryAddr = multi.getParameter("deliveryAddr");
		String deliveryAddr = "장곡동";
		
		Integer deliveryPrice = 0;
		if((multi.getParameter("deliveryPrice")) != null) {
			deliveryPrice = Integer.parseInt(multi.getParameter("deliveryPrice"));
		}
//		deliveryPrice = Integer.parseInt(multi.getParameter("deliveryPrice"));
		String tradeType = multi.getParameter("tradeType");
		Integer secPrice = Integer.parseInt(multi.getParameter("secPrice"));
		Integer salePrice = Integer.parseInt(multi.getParameter("salePrice"));
//		Integer memberNo = Integer.parseInt(multi.getParameter("memberNo"));
		Integer memberNo = 1;
		String startDate = multi.getParameter("startDate");
		String endDate = multi.getParameter("endDate");
		Integer rentPrice = Integer.parseInt(multi.getParameter("rentPrice"));
		String deliveryStatus = multi.getParameter("deliveryStatus");
		
		Product product = new Product(categoryNo, title, content, state, img, deliveryAddr, deliveryPrice, tradeType, secPrice, memberNo, startDate, endDate, rentPrice, salePrice, deliveryStatus);
		ProductService service = new ProductServiceImpl();
		try {
			service.registRentSell(product);
			request.setAttribute("product", product);
			response.sendRedirect(request.getContextPath()+"/main");
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
