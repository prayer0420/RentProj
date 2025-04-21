package controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.report.ReportDAO;
import dao.report.ReportDAOImpl;
import dto.ReportedProduct;

/**
 * Servlet implementation class ReportedProductList
 */
@WebServlet("/reportedProductList")
public class ReportedProductList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportedProductList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("report_type");
		String start = request.getParameter("startdate");
		String end = request.getParameter("enddate");
		if (start != null && start.trim().isEmpty()) start = null;
		if (end != null && end.trim().isEmpty()) end = null;
	
		System.out.println("신고유형: " + type);
		System.out.println("시작일: " + start);
		System.out.println("종료일: " + end);

		List<ReportedProduct> list = new ArrayList<>();
		if (type != null) {
		    ReportDAO dao = new ReportDAOImpl();
		    list = dao.getReportedProductList(type, start, end);
			
		}
		
	
		request.setAttribute("list", list);
		request.getRequestDispatcher("JSP/Admin/reportedProductList.jsp").forward(request, response);
		
	}	
	

}
