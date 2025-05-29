package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.ReportedProduct;
import service.report.ReportService;
import service.report.ReportServiceImpl;

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
	     ReportService service = new ReportServiceImpl();
	     request.setAttribute("newReportsCount", service.getNewReportsCount());
		 request.getRequestDispatcher("JSP/Admin/reportedProductList.jsp").forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String type = request.getParameter("report_type");
		String start = request.getParameter("startdate");
		String end = request.getParameter("enddate");
		
		if (start != null && start.trim().isEmpty()) start = null;
		if (end != null && end.trim().isEmpty()) end = null;
	
		System.out.println("신고유형: " + type);
		System.out.println("시작일: " + start);
		System.out.println("종료일: " + end);

	    List<ReportedProduct> list = null;
	    int newReportsCount = 0;  // 새로운 신고 카운트 초기화

	    // DAO 객체 생성
	    ReportService service = new ReportServiceImpl();

	    if (type != null && !type.trim().isEmpty()) {
	        // 검색이 있을 경우
	        list = service.getReportedProductList(type, start, end);

	    } else {
	        // 검색 없이 페이지 진입시 (전체 리스트 조회 없이 뱃지만 계산)
	        // 뱃지만 계산해서 표시 (검색 조건이 없다면 리스트는 비워둠)
	        list = service.getReportedProductList("", "", ""); // 전체 데이터 조회
	    }

        // 새로운 신고 카운트 (상태가 '새로운 신고'인 신고만 카운트)
        for (ReportedProduct item : list) {
            if ("new".equals(item.getStatus())) {
                newReportsCount++;
            }
        }
	    // 뱃지 카운트 설정
	    request.setAttribute("newReportsCount", newReportsCount);
	    request.setAttribute("list", list); // 검색된 리스트를 JSP로 전달

	    // JSP로 포워딩
	    request.getRequestDispatcher("JSP/Admin/reportedProductList.jsp").forward(request, response);
	}
	

}
