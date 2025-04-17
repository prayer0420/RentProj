package service.member;

import dto.Member;

public interface MemberService {
	void join(Member member) throws Exception;
	Member login(String id, String password) throws Exception;
	boolean checkDoubleId(String id) throws Exception;
	Member KakaoLogin(String code) throws Exception;
	Member NaverLogin(String code) throws Exception;
}
