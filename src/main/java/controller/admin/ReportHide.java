package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.report.ReportDAO;
import dao.report.ReportDAOImpl;

/**
 * Servlet implementation class ReportHide
 */
@WebServlet("/reportHide")
public class ReportHide extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportHide() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] productNo = request.getParameterValues("productNo[]");
        ReportDAO dao = new ReportDAOImpl();

        boolean success = dao.hideReport(productNo); 
        
        // 상품 숨김 성공 시 → 신고 상태를 'processed'로 변경 (뱃지용)
        if (success) {
            for (String no : productNo) {
                dao.updateReportStatus(Integer.parseInt(no));
            }
            
        response.getWriter().write(String.valueOf(success));
	
        }

	}
}
