package controller.mypage;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.mypage.MypageService;
import service.mypage.MypageServiceImpl;

/**
 * Servlet implementation class DeleteProduct
 */
@WebServlet("/deleteProduct")
public class DeleteProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteProduct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		try {
            int productNo = Integer.parseInt(request.getParameter("productNo"));

            MypageService service = new MypageServiceImpl();
            boolean result = service.deleteProduct(productNo);
            
            response.setContentType("application/json; charset=UTF-8");
            if (result) {
                response.getWriter().write("{\"success\": true}");
            } else {
                response.getWriter().write("{\"success\": false}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json; charset=UTF-8");
            response.getWriter().write("{\"success\": false}");
        }
	}

}
