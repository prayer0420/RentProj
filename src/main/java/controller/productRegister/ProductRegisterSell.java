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
 * Servlet implementation class ProductRegisterSell
 */
@WebServlet("/sell")
public class ProductRegisterSell extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductRegisterSell() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/JSP/ProductRegister/ProductRegisterSell.jsp").forward(request, response);
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
//		Integer deliveryPrice = Integer.parseInt(multi.getParameter("deliveryPrice"));
		String tradeType = multi.getParameter("tradeType");
//		Integer memberNo = Integer.parseInt(multi.getParameter("memberNo"));
		Integer memberNo = 1;
		Integer salePrice = Integer.parseInt(multi.getParameter("salePrice"));
		String deliveryStatus = multi.getParameter("deliveryStatus");
		
		Product product = new Product(categoryNo, title, content, state, img, deliveryAddr, deliveryPrice, tradeType, memberNo, salePrice, deliveryStatus);
		ProductService service = new ProductServiceImpl();
		
		try {
			service.registSell(product);
			request.setAttribute("Product", product);
			response.sendRedirect(request.getContextPath()+"/main");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
