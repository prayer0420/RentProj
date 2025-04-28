package service.review;

import java.util.List;

import dto.Order;
import dto.Review;

public interface ReviewService {
	void insertReview(Review review) throws Exception;
	List<Review> selectedByProductNo(int productNo) throws Exception;
	double selectAvgScore(int productNo) throws Exception;
	void deleteReview(Integer memberNo) throws Exception;
	
	
	//myReviewList
    List<Order> getWritableReviewList(Integer memberNo) throws Exception;
    List<Review> getMyReviewList(Integer memberNo) throws Exception;
    List<Review> getMyProductReviewList(Integer memberNo) throws Exception;
}
