package controller.mypage;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.mypage.MypageService;
import service.mypage.MypageServiceImpl;

/**
 * Servlet implementation class InvoiceSetting
 */
@WebServlet("/invoiceSetting")
public class InvoiceSetting extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InvoiceSetting() {
        super();
        // TODO Auto-generated constructor stub
    }

    
    
    
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		Integer orderNo = Integer.parseInt(request.getParameter("orderNo"));
	    String deliveryComp = request.getParameter("deliveryComp");
	    String invoiceNo = request.getParameter("invoiceNo");

	    MypageService service = new MypageServiceImpl();
	    try {
			boolean result = service.updateInvoiceInfo(orderNo,deliveryComp,invoiceNo);
			
			response.setContentType("application/json");
			request.setAttribute("orderNo", orderNo);
	        PrintWriter out = response.getWriter();
	        out.print("{\"success\":" + result + "}");
	        out.flush();
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "송장번호 입력에 실패했습니다.");
			request.getRequestDispatcher("/JSP/MyPage/error.jsp").forward(request, response);
		}

	}

}
