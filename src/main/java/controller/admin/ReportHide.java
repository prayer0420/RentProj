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
        response.getWriter().write(String.valueOf(success));
	
	}

}
