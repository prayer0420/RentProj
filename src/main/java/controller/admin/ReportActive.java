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
 * Servlet implementation class ReportActive
 */
@WebServlet("/reportActive")
public class ReportActive extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportActive() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] productNo = request.getParameterValues("productNo[]");
        ReportDAO dao = new ReportDAOImpl();
		
        boolean success = dao.activeReport(productNo);
        
        // 추가: 상품 활성화가 성공했을 경우 status도 'processed'로 변경
        if (success && productNo != null) {
            for (String no : productNo) {
                try {
                    int productId = Integer.parseInt(no);
                    dao.updateReportStatus(productId);  // 신고 상태 처리 완료
                } catch (NumberFormatException e) {
                    e.printStackTrace(); // 숫자 변환 실패 대비
                }
            }
        }
		response.getWriter().write(String.valueOf(success));
	}

}
