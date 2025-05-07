package service.settlement;

import java.util.List;
import java.util.Map;

import dto.Settlement;

public interface SettlementService {
	// 정산 리스트 조회
    List<Settlement> getSettlementList(Map<String, Object> searchMap) throws Exception;
    // 개별 정산 처리 (feeStatus 완료로 변경)
    boolean processSettlement(int settlementNo) throws Exception;
    // 수수료율 가져와 수수료 및 정산 금액 계산
    void insertSettlementByOrderNo(int orderNo) throws Exception;
    // /정산 완료 시간 조회
    String getCompletedAt(int settlementNo) throws Exception;
    // 총 개수 조회 추가 (페이징)
    int getSettlementCount(Map<String, Object> searchMap) throws Exception;
    // 검색 조건에 맞는 모든 정산건의 총 수수료 금액
    int getTotalFeeAmount(Map<String, Object> searchMap) throws Exception;
    
}
