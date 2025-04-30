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
	    if (order == null) {
	        throw new Exception("주문 정보를 찾을 수 없습니다. orderNo = " + orderNo);
	    }

	    // 2. 회원 정보 가져오기
	    Member member = settlementDAO.selectMemberInfo(order.getMemberNo());
	    if (member == null) {
	        throw new Exception("회원 정보를 찾을 수 없습니다. memberNo = " + order.getMemberNo());
	    }

	    // 3. gradeRate (수수료율) 가져오기
	    double gradeRate = settlementDAO.selectGradeRate(member.getGradeId());

	    // 4. 수수료(feeAmount) 계산
	    int feeAmount = (int) (order.getPrice() * gradeRate);

	    // 5. 최종 정산 금액(finalSettleAmount) 계산
	    int finalSettleAmount = 0;
	    if ("판매".equals(order.getRevenueType())) {
	        finalSettleAmount = order.getPrice() + order.getDeliveryPrice() - feeAmount;
	    } else if ("대여".equals(order.getRevenueType())) {
	        finalSettleAmount = order.getSecPrice() + order.getPrice() + order.getDeliveryPrice() - feeAmount;
	    }

	    // 6. Settlement DTO 세팅
	    Settlement settlement = new Settlement();
	    settlement.setOrderNo(order.getOrderNo());
	    settlement.setMemberNo(order.getMemberNo());
	    settlement.setProductNo(order.getProductNo());
	    settlement.setRevenueType(order.getRevenueType());
	    settlement.setPrice(order.getPrice());
	    settlement.setDeliveryPrice(order.getDeliveryPrice());
	    settlement.setSecPrice(order.getSecPrice());
	    settlement.setGradeRate(gradeRate);
	    settlement.setFeeAmount(feeAmount);
	    settlement.setFinalSettleAmount(finalSettleAmount);
	    settlement.setFeeStatus("PENDING"); // 초기에는 대기 상태

	    // 7. settlement insert
	    settlementDAO.insertSettlement(settlement);
	}
	
}