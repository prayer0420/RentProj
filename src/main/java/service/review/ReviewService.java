package service.review;

import java.util.List;
import dto.Review;
import dto.ReviewQueryParams;
import utils.PageInfo;

public interface ReviewService {
    void insertReview(Review review) throws Exception;
    List<Review> selectedByProductNo(int productNo) throws Exception;
    double selectAvgScore(int productNo) throws Exception;
    void deleteReview(Integer no) throws Exception;
    
    // 페이징용 추가
    int getReviewCount(ReviewQueryParams params) throws Exception;
    List<Review> getReviewList(ReviewQueryParams params) throws Exception;
    PageInfo getReviewPageInfo(ReviewQueryParams params) throws Exception;


	boolean checkMyReview(Integer productNo,Integer memberNo)throws Exception;

}
