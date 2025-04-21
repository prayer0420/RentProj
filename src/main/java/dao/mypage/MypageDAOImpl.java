package dao.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

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
	
	//위치 업데이트
	@Override
	public void updateLocation(String memberId, double latitude, double longitude) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("memberId", memberId);
	    params.put("latitude", latitude);
	    params.put("longitude", longitude);
	    sqlSession.update("mapper.member.updateLocation", params);
	    sqlSession.commit();
	}

}
