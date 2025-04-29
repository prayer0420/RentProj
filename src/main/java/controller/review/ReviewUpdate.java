package controller.review;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Review;
import service.review.ReviewService;
import service.review.ReviewServiceImpl;

/**
 * Servlet implementation class ReviewUpdate
 */
@WebServlet("/reviewUpdate")
public class ReviewUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		 Integer no = Integer.parseInt(request.getParameter("no"));
         String contents = request.getParameter("content");
         Integer score = Integer.parseInt(request.getParameter("score"));

         String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

         Review review = new Review(no, contents, score, score, date);
         ReviewService service = new ReviewServiceImpl();
         try {
        	 service.updateReview(review);
        	 
        	 response.setStatus(HttpServletResponse.SC_OK);
             response.getWriter().write("success");
         }catch(Exception e) {
        	 e.printStackTrace();
        	 response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
         }
	
	
	}

}
