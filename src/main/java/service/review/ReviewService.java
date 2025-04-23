package service.review;

import java.util.List;

import dto.Review;

public interface ReviewService {
	void insertReview(Review review) throws Exception;
	List<Review> selectedByProductNo(int productNo) throws Exception;
	double selectAvgScore(int productNo) throws Exception;
}
