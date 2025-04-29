package dao.settlement;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import dto.Member;
import dto.Settlement;

public interface SettlementDAO {
	// 검색 조건에 따른 정산 리스트 조회
    List<Settlement> selectSettlementList(Map<String, Object> searchMap) throws Exception;
    // 정산 상태를 'COMPLETE'로 업데이트
    int updateSettlementStatus(int settlementNo) throws Exception;
    // 회원번호 조회 (정산번호로)
    int selectMemberNoBySettlementNo(int settlementNo) throws Exception;
    // 회원 settlementCount 1 증가
    int updateMemberSettlementCount(int memberNo) throws Exception;
    
    // 회원 정보 조회
    Member selectMemberInfo(int memberNo) throws Exception;
    // 등급 기준 settlementCount 조회
    int selectGradeCount(int gradeNo) throws Exception;
    // 회원 등급 승급
    int updateMemberGradeNo(int memberNo, int gradeNo) throws Exception;
    // 정산 상세
    Settlement selectSettlementInfo(int settlementNo) throws Exception;
    // 최종 정산 금액 업데이트
    int updateFinalSettleAmount(int settlementNo, BigDecimal finalAmount) throws Exception;
    
}