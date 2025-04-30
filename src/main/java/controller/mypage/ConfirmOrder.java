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
 * Servlet implementation class ConfirmOrder
 */
@WebServlet("/confirmOrder")
public class ConfirmOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConfirmOrder() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String orderNoStr =  request.getParameter("orderNo");
        boolean success = false;

        if (orderNoStr != null) {
            try {
                Integer orderNo = Integer.parseInt(orderNoStr);
                MypageService service = new MypageServiceImpl();
                success = service.confirmOrder(orderNo);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().write(success ? "success" : "fail");
		
	}

}
