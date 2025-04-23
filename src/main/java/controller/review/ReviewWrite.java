package controller.review;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import dto.Review;
import service.review.ReviewService;
import service.review.ReviewServiceImpl;

/**
 * Servlet implementation class ReviewWrite
 */
@WebServlet("/reviewWrite")
public class ReviewWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReviewWrite() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int productNo = Integer.parseInt(request.getParameter("productNo"));
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("member");
		Integer memberNo = member.getNo();
		String content = request.getParameter("content");
		Integer score = Integer.parseInt(request.getParameter("score"));

		Review review = new Review(memberNo, content, score, productNo);
		ReviewService service = new ReviewServiceImpl();
		
		try {
			service.insertReview(review);
			request.setAttribute("review",review);
			// ✅ 응답만 보내기 (forward 없이!)
			response.setStatus(HttpServletResponse.SC_OK);
			
		}catch(Exception e) {
			e.printStackTrace();
		}


	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

}
