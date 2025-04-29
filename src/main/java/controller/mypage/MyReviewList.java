package controller.mypage;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.Review;
import dto.ReviewQueryParams;
import service.review.ReviewService;
import service.review.ReviewServiceImpl;
import utils.PageInfo;

@WebServlet("/myReviewList")
public class MyReviewList extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReviewService reviewService = new ReviewServiceImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("no") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Integer memberNo = (Integer) session.getAttribute("no");
        String type = request.getParameter("type");
        if (type == null) type = "writable"; // 기본 writable

        int page = parsePageParam(request.getParameter("page"));

        try {
            ReviewQueryParams params = new ReviewQueryParams(memberNo, type, page);

            List<Review> list = reviewService.getReviewList(params);
            PageInfo pageInfo = reviewService.getReviewPageInfo(params);

            request.setAttribute("list", list);
            request.setAttribute("pageInfo", pageInfo);
            request.setAttribute("type", type);

            request.getRequestDispatcher("/JSP/MyPage/myReviewList.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    private int parsePageParam(String param) {
        if (param == null || param.isEmpty()) {
            return 1;
        }
        try {
            return Integer.parseInt(param);
        } catch (NumberFormatException e) {
            return 1;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
