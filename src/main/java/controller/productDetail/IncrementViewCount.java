package controller.productDetail;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.product.ProductService;
import service.product.ProductServiceImpl;

/**
 * Servlet implementation class IncrementViewCount
 */
@WebServlet("/incrementViewCount")
public class IncrementViewCount extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IncrementViewCount() {
        super();
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("utf-8");

		    String noParam = request.getParameter("no");
		    if (noParam == null) {
		        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		        response.getWriter().write("Missing product number");
		        return;
		    }

		    try {
		        int productNo = Integer.parseInt(noParam);
		        ProductService service = new ProductServiceImpl();
		        service.incrementViewCount(productNo);  // void이므로 리턴값 없음

		        response.setContentType("application/json; charset=UTF-8");
		        response.getWriter().write("{\"success\": true}");
		        response.getWriter().flush();
		    } catch (Exception e) {
		        e.printStackTrace();
		        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		        response.getWriter().write("{\"success\": false, \"error\": \"Internal server error\"}");
		        response.getWriter().flush();
		    }
	}

}
