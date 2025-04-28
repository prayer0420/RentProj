package service.review;

import java.util.List;

import dao.review.ReviewDAO;
import dao.review.ReviewDAOImpl;
import dto.Order;
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

	@Override
	public List<Review> selectedByProductNo(int productNo) throws Exception {
		return reviewDAO.selectedByProductNo(productNo);
	}

	@Override
	public double selectAvgScore(int productNo) throws Exception {
		return reviewDAO.selectAvgScore(productNo);
	}

	@Override
	public void deleteReview(Integer memberNo) throws Exception {
		reviewDAO.deleteReview(memberNo);
	}
	
	
	//myReviewList
	 @Override
	    public List<Order> getWritableReviewList(Integer memberNo) throws Exception {
	        return reviewDAO.getWritableReviewList(memberNo);
	    }

	    @Override
	    public List<Review> getMyReviewList(Integer memberNo) throws Exception {
	        return reviewDAO.getMyReviewList(memberNo);
	    }

	    @Override
	    public List<Review> getMyProductReviewList(Integer memberNo) throws Exception {
	        return reviewDAO.getMyProductReviewList(memberNo);
	    }

	@Override
	public void updateReview(Review review) throws Exception {
		reviewDAO.updateReview(review);
	}

}
