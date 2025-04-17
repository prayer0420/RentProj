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
	
	//관리자 조회용
	List<Member> searchMembers(Map<String, Object> params) throws Exception;
}
