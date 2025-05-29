package service.member;

import java.util.List;
import java.util.Map;

import dto.LoginResult;
import dto.Member;
import utils.PageInfo;

public interface MemberService {
	void join(Member member) throws Exception;
	Member login(String id, String password) throws Exception;
	boolean checkDoubleId(String id) throws Exception;
	LoginResult KakaoLogin(String code) throws Exception;
	LoginResult NaverLogin(String code) throws Exception;
	
	//관리자 회원 목록 조회 (검색 조건 + 페이징 처리)
	List<Member> searchMembersWithPaging(Map<String, Object> params, PageInfo pageInfo) throws Exception;

    //관리자 정보 조회 및 업데이트
    Member selectAdmin();
    void updateAdminInfo(Member member) throws Exception;
    
    //위치
    public String updateLocationAndGetAddress(int memberNo, double lat, double lng);

    //회원정보 업데이트
    void updateMember(Member member) throws Exception;
    
    //회원정보 조회(ID로)
    public Member getMemberById(String id) throws Exception;
}
