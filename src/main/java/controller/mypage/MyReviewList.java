package controller.mypage;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dto.Review;
import dto.Order;
import service.review.ReviewService;
import service.review.ReviewServiceImpl;

@WebServlet("/myReviewList")
public class MyReviewList extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ReviewService reviewService = new ReviewServiceImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession(false);
        Integer memberNo = (Integer) session.getAttribute("no");

        try {
            List<Order> writableList = reviewService.getWritableReviewList(memberNo);
            List<Review> myReviewList = reviewService.getMyReviewList(memberNo);
            List<Review> myProductReviewList = reviewService.getMyProductReviewList(memberNo);

            request.setAttribute("writableList", writableList);
            request.setAttribute("myReviewList", myReviewList);
            request.setAttribute("myProductReviewList", myProductReviewList);

            request.getRequestDispatcher("/JSP/MyPage/myReviewList.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
