package dao.mypage;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.Product;
import utils.MybatisSqlSessionFactory;

public class MypageDAOImpl implements MypageDAO {
	private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public Integer selectProductCount() throws Exception {
		
		return sqlSession.selectOne("mapper.mypage.selectProductCnt");
	}

	@Override
	public List<Product> selectProductListByPage(Integer row) throws Exception {
		
		return sqlSession.selectList("mapper.mypage.selectProductListByPage", row);
	}

}
