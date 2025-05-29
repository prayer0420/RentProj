package service.settlement;


import java.util.List;
import java.util.Map;

import dao.settlement.SettlementDAO;
import dao.settlement.SettlementDAOImpl;
import dto.Member;
import dto.Order;
import dto.Product;
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
	    try {
	        // 1. 정산 상태 COMPLETE 처리
	        settlementDAO.updateSettlementStatus(settlementNo);

	        // 2. 정산 완료 시간 기록
	        settlementDAO.updateSettlementCompletedAt(settlementNo);

            // 3. 주문/상품 정보 가져오기
	        Settlement settlementInfo = settlementDAO.selectSettlementInfo(settlementNo);
	        if (settlementInfo == null) throw new Exception("정산 정보 없음 settlementNo=" + settlementNo);

	        Order order = settlementDAO.selectOrderInfo(settlementInfo.getOrderNo());
	        if (order == null) throw new Exception("주문 정보 없음 orderNo=" + settlementInfo.getOrderNo());

	        Product product = settlementDAO.selectProductInfo(order.getProductNo());
	        if (product == null) throw new Exception("상품 정보 없음 productNo=" + order.getProductNo());

            int buyerMemberNo = order.getMemberNo(); // 구매자
            int sellerMemberNo = product.getMemberNo(); // 판매자

            // 4. 각 회원의 orderCount +1
            settlementDAO.updateOrderCountPlusOne(buyerMemberNo);
            settlementDAO.updateOrderCountPlusOne(sellerMemberNo);

            // 5. 각 회원 등급 승급 체크
            upgradeMemberGradeIfNeeded(buyerMemberNo);
            upgradeMemberGradeIfNeeded(sellerMemberNo);
	        
	    } catch (Exception e) {
	        System.err.println("[정산 처리 실패] settlementNo=" + settlementNo);
	        e.printStackTrace();
	    }
	    return true; // 항상 성공으로 반환
	}

    // 회원의 orderCount를 기준으로 등급 승급 처리
    private void upgradeMemberGradeIfNeeded(int memberNo) throws Exception {
        // 1. 현재 회원 orderCount, gradeId 가져오기
        Member member = settlementDAO.selectMemberInfo(memberNo);

        // 2. 최고등급(6번, Re:NT)이면 승급 불가
        if (member.getGradeId() >= 6) {
            return; // Re:NT 등급이면 종료
        }

        // 3. 다음 등급 기준 orderCount 가져오기
        int nextGradeNo = member.getGradeId() + 1;
        int nextGradeCount = settlementDAO.selectGradeCount(nextGradeNo);

        // 4. orderCount가 기준 이상이면 등급 승급
        if (member.getOrderCount() >= nextGradeCount) {
            settlementDAO.updateMemberGradeNo(memberNo, nextGradeNo);
        }
    }
    // 주문번호로 정산 데이터 생성
	@Override
	public void insertSettlementByOrderNo(int orderNo) throws Exception {
		 // 1. 주문 정보 가져오기
	    Order order = settlementDAO.selectOrderInfo(orderNo);
	    Product product = settlementDAO.selectProductInfo(order.getProductNo());
	    Member seller = settlementDAO.selectMemberInfo(product.getMemberNo());  // 판매자 기준
	
	    // 2. 판매자 등급 수수료율 가져오기
	    double gradeRate = settlementDAO.selectGradeRate(seller.getGradeId());
	    
	    // 3. 수수료(feeAmount) 계산
	    int feeAmount = (int) (order.getPrice() * (gradeRate / 100.0));

	    // 4. 최종 정산 금액(finalSettleAmount) 계산
	    String revenueType = order.getRevenueType();
	    int finalSettleAmount = 0;
	    if ("판매".equals(revenueType)) {
	        finalSettleAmount = safeInt(order.getPrice()) + safeInt(order.getDeliveryPrice()) - feeAmount;
	    } else if ("대여".equals(revenueType)) {
	        finalSettleAmount = safeInt(order.getSecPrice()) + safeInt(order.getPrice()) + safeInt(order.getDeliveryPrice()) - feeAmount;
	    }
	    

	    // 5. Settlement DTO 세팅
	    Settlement settlement = new Settlement();
	    settlement.setOrderNo(order.getOrderNo());
	    settlement.setMemberNo(product.getMemberNo());  
	    settlement.setProductNo(order.getProductNo());
	    settlement.setRevenueType(safeString(order.getRevenueType()));
	    settlement.setPrice(safeInt(order.getPrice()));
	    settlement.setDeliveryPrice(safeInt(order.getDeliveryPrice()));
	    settlement.setSecPrice(safeInt(order.getSecPrice()));
	    settlement.setGradeRate(gradeRate);
	    settlement.setFeeAmount(feeAmount);
	    settlement.setFinalSettleAmount(finalSettleAmount);
	    settlement.setFeeStatus("PENDING");
	    

	    // 6. 정산 데이터 DB에 insert
	    settlementDAO.insertSettlement(settlement);
	}
	// null 안전 처리 (Integer)
    private int safeInt(Integer value) {
        return value != null ? value : 0;
    }
    // null 안전 처리 (String)
    private String safeString(String value) {
        return value != null ? value : "";
    }

	@Override
	public String getCompletedAt(int settlementNo) throws Exception {
	    return settlementDAO.selectCompletedAt(settlementNo);
	}

	@Override
	public int getSettlementCount(Map<String, Object> searchMap) throws Exception {
		return settlementDAO.selectSettlementCount(searchMap);
	}

	@Override
	public int getTotalFeeAmount(Map<String, Object> searchMap) throws Exception {
		return settlementDAO.selectTotalFeeAmount(searchMap);
	}
}

