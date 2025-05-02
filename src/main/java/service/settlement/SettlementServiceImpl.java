package service.settlement;


import java.util.List;
import java.util.Map;

import dao.settlement.SettlementDAO;
import dao.settlement.SettlementDAOImpl;
import dto.Member;
import dto.Order;
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

	        // 3. 회원번호 조회 및 등급 승급 시도
	        int memberNo = settlementDAO.selectMemberNoBySettlementNo(settlementNo);
	        upgradeMemberGradeIfNeeded(memberNo); // 등급 조건 충족 시 승급
	    } catch (Exception e) {
	        // 실패해도 무조건 성공으로 처리
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

	@Override
	public void insertSettlementByOrderNo(int orderNo) throws Exception {
		 // 1. 주문 정보 가져오기
	    Order order = settlementDAO.selectOrderInfo(orderNo);
	    System.out.println("=== order 조회 결과 === " + order);
	    if (order == null) {
	        throw new Exception("주문 정보를 찾을 수 없습니다. orderNo = " + orderNo);
	    }

	    // 2. 회원 정보 가져오기
	    Member member = settlementDAO.selectMemberInfo(order.getMemberNo());
	    System.out.println("=== member 조회 결과 === " + member);
	    if (member == null) {
	        throw new Exception("회원 정보를 찾을 수 없습니다. memberNo = " + order.getMemberNo());
	    }

	    // 3. gradeRate (수수료율) 가져오기
	    Double gradeRateObj = settlementDAO.selectGradeRate(member.getGradeId());
	    System.out.println("=== gradeRate 조회 결과 === " + gradeRateObj);
	    if (gradeRateObj == null) {
	        throw new Exception("등급 수수료율을 찾을 수 없습니다. gradeId = " + member.getGradeId());
	    }
	    double gradeRate = gradeRateObj;

	    System.out.println("=== order 상세 값 ===");
	    System.out.println("order.getOrderNo() = " + order.getOrderNo());
	    System.out.println("order.getMemberNo() = " + order.getMemberNo());
	    System.out.println("order.getProductNo() = " + order.getProductNo());
	    System.out.println("order.getRevenueType() = " + order.getRevenueType());
	    System.out.println("order.getPrice() = " + order.getPrice());
	    System.out.println("order.getDeliveryPrice() = " + order.getDeliveryPrice());
	    System.out.println("order.getSecPrice() = " + order.getSecPrice());

	    System.out.println("=== member 상세 값 ===");
	    System.out.println("member.getMemberNo() = " + member.getNo());
	    System.out.println("member.getGradeId() = " + member.getGradeId());
	    System.out.println("member.getOrderCount() = " + member.getOrderCount());

	    System.out.println("=== gradeRate 최종 값 === " + gradeRate);
	    
	    
	    // 4. 수수료(feeAmount) 계산
	    if (order.getPrice() == null) {
	        throw new Exception("주문 금액(price)이 null입니다. orderNo = " + orderNo);
	    }
	    int feeAmount = (int) (order.getPrice() * (gradeRate / 100.0));

	    // 5. 최종 정산 금액(finalSettleAmount) 계산
	    String revenueType = order.getRevenueType();
	    if (revenueType == null) {
	        throw new Exception("revenueType 값이 null입니다. orderNo = " + orderNo);
	    }

	    int finalSettleAmount = 0;
	    if ("판매".equals(revenueType)) {
	        finalSettleAmount = safeInt(order.getPrice()) + safeInt(order.getDeliveryPrice()) - feeAmount;
	    } else if ("대여".equals(revenueType)) {
	        finalSettleAmount = safeInt(order.getSecPrice()) + safeInt(order.getPrice()) + safeInt(order.getDeliveryPrice()) - feeAmount;
	    } else {
	        throw new Exception("알 수 없는 revenueType입니다: " + revenueType);
	    }
	    
	    

	    // 6. Settlement DTO 세팅
	    Settlement settlement = new Settlement();
	    settlement.setOrderNo(order.getOrderNo());
	    settlement.setMemberNo(order.getMemberNo());
	    settlement.setProductNo(order.getProductNo());
	    settlement.setRevenueType(safeString(order.getRevenueType()));
	    settlement.setPrice(safeInt(order.getPrice()));
	    settlement.setDeliveryPrice(safeInt(order.getDeliveryPrice()));
	    settlement.setSecPrice(safeInt(order.getSecPrice()));
	    settlement.setGradeRate(gradeRate);
	    settlement.setFeeAmount(feeAmount);
	    settlement.setFinalSettleAmount(finalSettleAmount);
	    settlement.setFeeStatus("PENDING");
	    
	 // 🔶 여기서 출력 추가
	    System.out.println("=== Settlement DTO 값 점검 ===");
	    System.out.println("orderNo = " + settlement.getOrderNo());
	    System.out.println("memberNo = " + settlement.getMemberNo());
	    System.out.println("productNo = " + settlement.getProductNo());
	    System.out.println("revenueType = " + settlement.getRevenueType());
	    System.out.println("price = " + settlement.getPrice());
	    System.out.println("deliveryPrice = " + settlement.getDeliveryPrice());
	    System.out.println("secPrice = " + settlement.getSecPrice());
	    System.out.println("gradeRate = " + settlement.getGradeRate());
	    System.out.println("feeAmount = " + settlement.getFeeAmount());
	    System.out.println("finalSettleAmount = " + settlement.getFinalSettleAmount());
	    System.out.println("feeStatus = " + settlement.getFeeStatus());


	    // 7. settlement insert
	    settlementDAO.insertSettlement(settlement);
	}

    private int safeInt(Integer value) {
        return value != null ? value : 0;
    }

    private String safeString(String value) {
        return value != null ? value : "";
    }

	@Override
	public String getCompletedAt(int settlementNo) throws Exception {
	    return settlementDAO.selectCompletedAt(settlementNo);
	}
}

