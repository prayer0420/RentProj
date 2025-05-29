package dao.settlement;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Member;
import dto.Order;
import dto.Product;
import dto.Settlement;
import utils.MybatisSqlSessionFactory;

public class SettlementDAOImpl implements SettlementDAO {
	

	@Override
    public List<Settlement> selectSettlementList(Map<String, Object> searchMap) throws Exception {
        // 검색조건으로 정산 리스트 조회
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sqlSession.selectList("mapper.settlement.selectSettlementList", searchMap);
        }
    }

	@Override
	public int updateSettlementStatus(int settlementNo) throws Exception {
        // 정산 상태를 COMPLETE로 업데이트
        try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true)) { // 오토커밋
            return sqlSession.update("mapper.settlement.updateSettlementStatus", settlementNo);
        }
    }
	

	@Override
	public Member selectMemberInfo(int memberNo) throws Exception {
	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	        return sqlSession.selectOne("mapper.settlement.selectMemberInfo", memberNo);
	    }
	}

	@Override
	public int selectGradeCount(int gradeNo) throws Exception {
	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	        return sqlSession.selectOne("mapper.settlement.selectGradeCount", gradeNo);
	    }
	}

	@Override
	public int updateMemberGradeNo(int memberNo, int gradeNo) throws Exception {
	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true)) {
	        Map<String, Object> param = new HashMap<>();
	        param.put("memberNo", memberNo);
	        param.put("gradeNo", gradeNo);
	        return sqlSession.update("mapper.settlement.updateMemberGradeNo", param);
	    }
	}

	@Override
	public Settlement selectSettlementInfo(int settlementNo) throws Exception {
	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	        return sqlSession.selectOne("mapper.settlement.selectSettlementInfo", settlementNo);
	    }
	}

	@Override
	public int updateFinalSettleAmount(int settlementNo, BigDecimal finalAmount) throws Exception {
	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true)) {
	        Map<String, Object> param = new HashMap<>();
	        param.put("settlementNo", settlementNo);
	        param.put("finalAmount", finalAmount);
	        return sqlSession.update("mapper.settlement.updateFinalSettleAmount", param);
	    }
	}

	@Override
	public int insertSettlement(Settlement settlement) throws Exception {
		// 주문 상태 변경 시 settlement 자동 insert 
	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true)) {
	        return sqlSession.insert("mapper.settlement.insertSettlement", settlement);
	    }
	}

	@Override
	public Order selectOrderInfo(int orderNo) throws Exception {
	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	    return sqlSession.selectOne("mapper.settlement.selectOrderInfo", orderNo);
	    }
	}

	@Override
	public double selectGradeRate(int gradeId) throws Exception {
	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
        return sqlSession.selectOne("mapper.settlement.selectGradeRate", gradeId);
	    }
	
	}

	@Override
	public int updateSettlementCompletedAt(int settlementNo) throws Exception {
	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true)) {
	        return sqlSession.update("mapper.settlement.updateSettlementCompletedAt", settlementNo);
	    }
	}

	@Override
	public String selectCompletedAt(int settlementNo) throws Exception {
	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true)) {
	        return sqlSession.selectOne("mapper.settlement.selectCompletedAt", settlementNo);
	    }
	}

	@Override
	public int updateOrderCountPlusOne(int memberNo) throws Exception {
	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true)) {
	        return sqlSession.update("mapper.member.updateOrderCountPlusOne", memberNo);
	    }
	}

	@Override
	public Product selectProductInfo(int productNo) throws Exception {
	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	        return sqlSession.selectOne("mapper.settlement.selectProductInfo", productNo);
	    }
	}

	@Override
	public int selectSettlementCount(Map<String, Object> searchMap) throws Exception {
	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	        return sqlSession.selectOne("mapper.settlement.selectSettlementCount", searchMap);
	    }
	}

	@Override
	public int selectTotalFeeAmount(Map<String, Object> searchMap) throws Exception {
	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	        return sqlSession.selectOne("mapper.settlement.selectTotalFeeAmount", searchMap);
	    }
	}
}