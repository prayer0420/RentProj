package dao.review;

import java.util.List;

import dto.Review;

public interface ReviewDAO {
	Review insertReview(Review review) throws Exception;
	List<Review> selectedByProductNo(int productNo) throws Exception;
	double selectAvgScore(int productNo) throws Exception;
	void deleteReview(Integer memberNo) throws Exception;
	void updateReview(Review review) throws Exception;
}
