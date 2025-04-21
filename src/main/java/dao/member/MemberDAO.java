package dao.member;

import java.util.List;
import java.util.Map;

import dto.Member;

public interface MemberDAO {
	void insertMember(Member member) throws Exception;
	Member SelectMember(String id) throws Exception;
	void updateMember(Member member)throws Exception;
	
	//관리자 리스트 조회용 - 회원 검색 + 페이징된 리스트  
	List<Member> searchMembersWithPaging(Map<String, Object> params) throws Exception;
	Integer selectMembersCountWithFilter(Map<String, Object> params) throws Exception;
    //관리자회원정보 조회용 - 관리자 정보 화면 진입 시 사용
    Member selectAdmin();
    //관리자 기본 정보 (비밀번호, 이름, 닉네임) 수정 
    void updateAdminInfo(Member member) throws Exception;
    //위치
    public void updateLocation(int memberNo, double lat, double lng, String address);
}
