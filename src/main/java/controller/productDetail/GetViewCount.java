package controller.productDetail;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import service.product.ProductService;
import service.product.ProductServiceImpl;

/**
 * Servlet implementation class GetViewCount
 */
@WebServlet("/getViewCount")
public class GetViewCount extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetViewCount() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String noParam = request.getParameter("no");

		if (noParam == null) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			response.getWriter().write("{\"error\": \"Missing product number\"}");
			return;
		}

		try {
			int productNo = Integer.parseInt(noParam);
			ProductService service = new ProductServiceImpl();
			int viewCnt = service.selectViewCount(productNo);

			response.setContentType("application/json; charset=UTF-8");
			response.getWriter().write("{\"viewCnt\": " + viewCnt + "}");
			response.getWriter().flush();
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.getWriter().write("{\"error\": \"Internal server error\"}");
			response.getWriter().flush();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
