package controller.report;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.ReportedProduct;
import service.report.ReportService;
import service.report.ReportServiceImpl;

@WebServlet("/report")
public class Report extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Report() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		Integer productNo = Integer.parseInt(request.getParameter("productNo"));
		Integer memberNo = (Integer)request.getSession().getAttribute("no");
		String type = request.getParameter("type");
		String contents = request.getParameter("contents");
		String title = request.getParameter("title");
		
		ReportedProduct report = new ReportedProduct(memberNo, contents, type, title, productNo);
		ReportService service = new ReportServiceImpl();
		try {
			service.insertReport(report);
			response.setStatus(HttpServletResponse.SC_OK);
		}catch(Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "신고 등록 실패");
		}
		
		
	}

}
