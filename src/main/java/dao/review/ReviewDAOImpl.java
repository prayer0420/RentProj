package dao.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Review;
import dto.ReviewQueryParams;
import utils.MybatisSqlSessionFactory;

public class ReviewDAOImpl implements ReviewDAO {
    SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

    @Override
    public Review insertReview(Review review) throws Exception {
        session.insert("mapper.review.insertReview", review);
        session.commit();
        return review;
    }

    @Override
    public List<Review> selectedByProductNo(int productNo) throws Exception {
        return session.selectList("mapper.review.selectByProductNo", productNo);
    }

    @Override
    public double selectAvgScore(int productNo) throws Exception {
        Double result = session.selectOne("mapper.review.selectAvgScore", productNo);
        return result != null ? result : 0.0;
    }

    @Override
    public void deleteReview(Integer no) throws Exception {
        session.delete("mapper.review.deleteReview", no);
        session.commit();
    }

    @Override
    public int getReviewCount(ReviewQueryParams params) throws Exception {
        return session.selectOne("mapper.review.getReviewCount", params);
    }

    @Override
    public List<Review> getReviewList(ReviewQueryParams params) throws Exception {
        return session.selectList("mapper.review.getReviewList", params);
    }


	@Override
	public int checkMyReview(Integer productNo, Integer memberNo) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("productNo", productNo);
		map.put("memberNo", memberNo);
		return session.selectOne("mapper.review.checkMyReview",map);
	}
	
	@Override
	public void updateReview(Review review) throws Exception {
	    session.update("mapper.review.updateReview", review);
	}

}
