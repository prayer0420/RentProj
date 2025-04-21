package dao.review;

import dto.Review;

public interface ReviewDAO {
	Review insertReview(Review review) throws Exception;
}
