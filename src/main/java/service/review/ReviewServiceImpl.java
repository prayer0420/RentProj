package service.review;

import dao.review.ReviewDAO;
import dao.review.ReviewDAOImpl;
import dto.Review;

public class ReviewServiceImpl implements ReviewService {
	ReviewDAO reviewDAO;
	
	public ReviewServiceImpl(){
		reviewDAO = new ReviewDAOImpl();
	}
	
	@Override
	public void insertReview(Review review) throws Exception {
		reviewDAO.insertReview(review);
	}

}
