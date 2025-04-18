package dao.member;

import java.util.List;
import java.util.Map;

import dto.Member;

public interface MemberDAO {
	void insertMember(Member member) throws Exception;
	Member SelectMember(String id) throws Exception;
	void updateMember(Member member)throws Exception;
	
	//관리자 리스트 조회용	
	List<Member> searchMembers(Map<String, Object> params) throws Exception;
    List<Member> searchMembersPaging(Map<String, Object> params);
    int countMembers(Map<String, Object> params); // 전체 개수용
    
    //관리자회원정보 조회용
    Member selectAdmin();

}
