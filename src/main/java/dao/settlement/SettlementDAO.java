package dao.settlement;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import dto.Member;
import dto.Order;
import dto.Product;
import dto.Settlement;

public interface SettlementDAO {
	// 검색 조건에 따른 정산 리스트 조회
    List<Settlement> selectSettlementList(Map<String, Object> searchMap) throws Exception;
    // 정산 상태를 'COMPLETE'로 업데이트
    int updateSettlementStatus(int settlementNo) throws Exception;

    
    // 회원 정보 조회
    Member selectMemberInfo(int memberNo) throws Exception;
    // 등급 기준 조회
    int selectGradeCount(int gradeNo) throws Exception;
    // 회원 등급 승급
    int updateMemberGradeNo(int memberNo, int gradeNo) throws Exception;
    // 정산 상세
    Settlement selectSettlementInfo(int settlementNo) throws Exception;
    // 최종 정산 금액 업데이트
    int updateFinalSettleAmount(int settlementNo, BigDecimal finalAmount) throws Exception;
    
    // 주문 상태 변경 시 settlement 자동 insert 
    int insertSettlement(Settlement settlement) throws Exception;
    
    // 주문 정보 조회 (orderNo 기준)
    Order selectOrderInfo(int orderNo) throws Exception;

   // 
    double selectGradeRate(int gradeId) throws Exception;
    // 정산완료 시간 업데이트
    int updateSettlementCompletedAt(int settlementNo) throws Exception;
    // 정산완료 시간 조회
    String selectCompletedAt(int settlementNo) throws Exception;
    // 정산완료 시, 주문카운트 업데이트
    int updateOrderCountPlusOne(int memberNo) throws Exception;
    
    Product selectProductInfo(int productNo) throws Exception;
    // 총 개수 조회 추가(페이징)
    int selectSettlementCount(Map<String, Object> searchMap) throws Exception;
    // 검색 조건에 맞는 모든 정산건의 총 수수료 금액
    int selectTotalFeeAmount(Map<String, Object> searchMap) throws Exception;

}