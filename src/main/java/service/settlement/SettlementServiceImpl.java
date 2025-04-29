package service.settlement;


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
            upgradeMemberGradeIfNeeded(memberNo); // 3. orderCount 기준 등급 승급 처리
        }
        return result > 0;
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
}

	
