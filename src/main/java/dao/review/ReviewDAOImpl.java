package dao.review;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.Review;
import utils.MybatisSqlSessionFactory;

public class ReviewDAOImpl implements ReviewDAO {
	SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public Review insertReview(Review review) throws Exception {
		session.insert("mapper.review.insertReview",review);
		session.commit();
		return review;
	}

	@Override
	public List<Review> selectedByProductNo(int productNo) throws Exception {
		return session.selectList("mapper.review.selectByProductNo",productNo);
	}

	@Override
	public double selectAvgScore(int productNo) throws Exception {
		Double result = session.selectOne("mapper.review.selectAvgScore",productNo);
		return result != null ? result : 0.0;
	}

	@Override
	public void deleteReview(Integer memberNo) throws Exception {
		session.delete("mapper.review.deleteReview",memberNo);
		session.commit();
	}

	@Override
	public void updateReview(Review review) throws Exception {
		session.update("mapper.review.updateReview",review);
		session.commit();
		
	}

}
