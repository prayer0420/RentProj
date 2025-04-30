package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.settlement.SettlementService;
import service.settlement.SettlementServiceImpl;

/**
 * Servlet implementation class DoSettlement
 */
@WebServlet("/doSettlement")
public class DoSettlement extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DoSettlement() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SettlementService settlementService = new SettlementServiceImpl();
        
	    try {
	        String param = request.getParameter("settlementNo");
	        System.out.println("🔥 [정산요청 수신] settlementNo = " + param);

	        int settlementNo = Integer.parseInt(param);
	        boolean success = settlementService.processSettlement(settlementNo);

	        response.setContentType("application/json;charset=UTF-8");
	        response.getWriter().write("{\"success\": true}");
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	    }
	}
}