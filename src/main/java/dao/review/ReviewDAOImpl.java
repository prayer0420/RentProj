package dao.review;

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

}
