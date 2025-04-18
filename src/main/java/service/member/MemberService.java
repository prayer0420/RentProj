package service.member;

import java.util.List;
import java.util.Map;

import dto.Member;

public interface MemberService {
	void join(Member member) throws Exception;
	Member login(String id, String password) throws Exception;
	boolean checkDoubleId(String id) throws Exception;
	Member KakaoLogin(String code) throws Exception;
	Member NaverLogin(String code) throws Exception;
	
	//관리자 회원리스트 조회용
	List<Member> searchMembers(Map<String, Object> params) throws Exception;
    List<Member> searchMembersPaging(Map<String, Object> params);
    int countMembers(Map<String, Object> params);
    //관리자 정보 조회용
    Member selectAdmin();
}
