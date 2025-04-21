package dao.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Order;
import dto.Product;
import utils.MybatisSqlSessionFactory;

public class MypageDAOImpl implements MypageDAO {
	private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public Integer selectProductCountById(String id) throws Exception {
		return sqlSession.selectOne("mapper.mypage.selectProductCnt",id);
	}

	@Override
	public List<Product> selectProductListByPage(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList("mapper.mypage.selectProductListByPage", paramMap);
	}

	@Override
	public Map<String, Object> selectMySellDetail(Integer orderNo, String id) {
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("orderNo",orderNo);
		param.put("id",id);
		return sqlSession.selectOne("mapper.mypage.selectMySellDetail",param);
	}

	

}
