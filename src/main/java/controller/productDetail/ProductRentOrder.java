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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
request.setCharacterEncoding("utf-8");
		
		int productNo = Integer.parseInt(request.getParameter("productNo"));
		ProductService service = new ProductServiceImpl();
		
		try {
			Product product = service.selectProductOne(productNo);			
			HttpSession session = request.getSession(false);
			if(session == null || session.getAttribute("member")==null) {
				response.sendRedirect(request.getContextPath()+"/login");
				return;
			}
			request.setAttribute("product", product);
			request.getRequestDispatcher("/JSP/ProductDetail/orderRent.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}


}
