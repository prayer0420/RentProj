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
	public List<Map<String, Object>> selectProductListByPage(Map<String, Object> paramMap) throws Exception {
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

	// 마이페이지 판매상품 거래내역 상세 불러오기
	@Override
	public Map<String, Object> selectMySellDetail(Integer orderNo, String id) {
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("orderNo",orderNo);
		param.put("id",id);
		return sqlSession.selectOne("mapper.mypage.selectMySellDetail",param);
	}

	// 송장번호/택배사 업데이트
	@Override
	public boolean updateInvoiceInfo(Integer orderNo, String deliveryComp, String invoiceNo) throws Exception {
		Map<String,Object> param = new HashMap<>();
		param.put("orderNo", orderNo);
		param.put("deliveryComp", deliveryComp);
		param.put("invoiceNo", invoiceNo);
		Integer result = sqlSession.update("mapper.mypage.updateInvoiceNo",param);
		sqlSession.commit();
		return result == 1;
	}


	

}
