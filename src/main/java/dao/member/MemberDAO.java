package dao.member;

import dto.Member;

public interface MemberDAO {
	void insertMember(Member member) throws Exception;
	Member SelectMember(String id) throws Exception;
	void updateMember(Member member)throws Exception;
}
