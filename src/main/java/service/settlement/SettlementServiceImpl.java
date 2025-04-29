package service.settlement;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import dao.settlement.SettlementDAO;
import dao.settlement.SettlementDAOImpl;
import dto.Member;
import dto.Settlement;

public class SettlementServiceImpl implements SettlementService {
	
    private SettlementDAO settlementDAO = new SettlementDAOImpl();

    // 검색 조건에 따른 정산 리스트 조회
	@Override
	public List<Settlement> getSettlementList(Map<String, Object> searchMap) throws Exception {
        return settlementDAO.selectSettlementList(searchMap);
    }

    // 정산번호에 해당하는 데이터 정산 완료로 업데이트
	@Override
	public boolean processSettlement(int settlementNo) throws Exception {
	    int result = settlementDAO.updateSettlementStatus(settlementNo); // 1. 정산 완료 처리

	    if (result > 0) {
	        int memberNo = settlementDAO.selectMemberNoBySettlementNo(settlementNo); // 2. 회원번호 조회
	        settlementDAO.updateMemberSettlementCount(memberNo); // 3. settlementCount +1

	        // 4. settlementCount 증가 후 등급 승급 필요하면 업그레이드
	        upgradeMemberGradeIfNeeded(memberNo);
	        
	        // 5. finalSettleAmount 계산 및 업데이트
	        Settlement settlementInfo = settlementDAO.selectSettlementInfo(settlementNo);
	        BigDecimal finalAmount = calculateFinalSettleAmount(settlementInfo);
	        settlementDAO.updateFinalSettleAmount(settlementNo, finalAmount);
	    }
	    return result > 0;
	}
	
	private void upgradeMemberGradeIfNeeded(int memberNo) throws Exception {
	    // 1. 현재 회원 settlementCount, gradeNo 가져오기
	    Member member = settlementDAO.selectMemberInfo(memberNo); 

	    // 2. 최고등급이면 승급 불가
	    if (member.getGradeId() >= 6) {
	        return; // Re:NT 등급이면 종료
	    }

	    // 3. 다음 등급의 기준 settlementCount 가져오기
	    int nextGradeNo = member.getGradeId() + 1;
	    int nextGradeCount = settlementDAO.selectGradeCount(nextGradeNo);

	    // 4. settlementCount가 기준 이상이면 등급 승급
	    if (member.getSettlementCount() >= nextGradeCount) {
	        settlementDAO.updateMemberGradeNo(memberNo, nextGradeNo);
	    }
	}

	
		private BigDecimal calculateFinalSettleAmount(Settlement settlement) {
		    BigDecimal price = BigDecimal.valueOf(settlement.getPrice());
		    BigDecimal secPrice = BigDecimal.valueOf(settlement.getSecPrice());
		    BigDecimal deliveryPrice = BigDecimal.valueOf(settlement.getDeliveryPrice());
		    BigDecimal feeAmount = BigDecimal.valueOf(settlement.getFeeAmount());
	
		    if ("판매".equals(settlement.getOrderType())) {
		        return price.add(deliveryPrice).subtract(feeAmount);
		    } else if ("대여".equals(settlement.getOrderType())) {
		        return secPrice.add(price).add(deliveryPrice).subtract(feeAmount);
		    } else {
		        return BigDecimal.ZERO;
		    }
		}
}