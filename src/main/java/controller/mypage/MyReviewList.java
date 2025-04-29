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

        try {
            // 🛠️ 탭별 페이지 파라미터 받기
            int writablePage = parsePageParam(request.getParameter("writablePage"));
            int writtenPage = parsePageParam(request.getParameter("writtenPage"));
            int myProductPage = parsePageParam(request.getParameter("myProductPage"));

            // 🛠️ 파라미터 객체 생성
            ReviewQueryParams writableParams = new ReviewQueryParams(memberNo, "writable", writablePage);
            ReviewQueryParams writtenParams = new ReviewQueryParams(memberNo, "written", writtenPage);
            ReviewQueryParams myProductParams = new ReviewQueryParams(memberNo, "myproduct", myProductPage);

            // 🛠️ 리스트 불러오기
            List<Review> writableList = reviewService.getReviewList(writableParams);
            List<Review> writtenList = reviewService.getReviewList(writtenParams);
            List<Review> myProductList = reviewService.getReviewList(myProductParams);

            // 🛠️ PageInfo 불러오기
            PageInfo writablePageInfo = reviewService.getReviewPageInfo(writableParams);
            PageInfo writtenPageInfo = reviewService.getReviewPageInfo(writtenParams);
            PageInfo myProductPageInfo = reviewService.getReviewPageInfo(myProductParams);

            // 🛠️ JSP로 넘기기
            request.setAttribute("writableList", writableList);
            request.setAttribute("writtenList", writtenList);
            request.setAttribute("myProductList", myProductList);

            request.setAttribute("writablePageInfo", writablePageInfo);
            request.setAttribute("writtenPageInfo", writtenPageInfo);
            request.setAttribute("myProductPageInfo", myProductPageInfo);

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
            return 1; // 이상한 값 들어오면 기본 1페이지
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
