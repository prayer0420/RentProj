package controller.mypage;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.ReportedProduct;
import service.report.ReportService;
import service.report.ReportServiceImpl;
import utils.PageInfo;

@WebServlet("/myReportList")
public class MyReportList extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReportService reportService = new ReportServiceImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession(false);
        Integer memberNo = (Integer) session.getAttribute("no");

        String pageP = request.getParameter("page");
        int page = 1;
        try {
            page = (pageP != null && !pageP.isEmpty()) ? Integer.parseInt(pageP) : 1;
        } catch (Exception e) {}

        try {
            PageInfo pageInfo = reportService.getMyReportPageInfo(memberNo, page);
            List<ReportedProduct> reportList = reportService.getMyReportList(memberNo, pageInfo);

            request.setAttribute("reportList", reportList);
            request.setAttribute("pageInfo", pageInfo);

            request.getRequestDispatcher("/JSP/MyPage/myReportList.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}