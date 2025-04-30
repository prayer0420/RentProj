package dao.review;

import java.util.List;
import dto.Review;
import dto.ReviewQueryParams;

public interface ReviewDAO {
    Review insertReview(Review review) throws Exception;
    List<Review> selectedByProductNo(int productNo) throws Exception;
    double selectAvgScore(int productNo) throws Exception;
    void deleteReview(Integer no) throws Exception;


    // 페이징용 추가
    int getReviewCount(ReviewQueryParams params) throws Exception;
    List<Review> getReviewList(ReviewQueryParams params) throws Exception;
	void updateReview(Review review) throws Exception;
	int checkMyReview(Integer productNo,Integer memberNo) throws Exception;
}