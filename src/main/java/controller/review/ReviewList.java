package controller.review;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Review;
import service.review.ReviewService;
import service.review.ReviewServiceImpl;

/**
 * Servlet implementation class ReviewList
 */
@WebServlet("/reviewList")
public class ReviewList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int productNo = Integer.parseInt(request.getParameter("productNo"));
		String memberNickname = (String) request.getSession().getAttribute("nickname");
		Integer memberNo = (Integer) request.getSession().getAttribute("no");
		ReviewService service = new ReviewServiceImpl();
		
		
		try {
			List<Review> reviewList = service.selectedByProductNo(productNo);
			Double avgScore = service.selectAvgScore(productNo);
			request.setAttribute("reviewList", reviewList);
			request.setAttribute("avgScore", avgScore);
			request.setAttribute("memberNickname",memberNickname);
			request.setAttribute("memberNo",memberNo);
			request.getRequestDispatcher("/JSP/ProductDetail/reviewList.jsp").forward(request, response);			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
