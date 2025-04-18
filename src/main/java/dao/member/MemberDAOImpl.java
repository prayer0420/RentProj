package dao.member;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Member;
import utils.MybatisSqlSessionFactory;

public class MemberDAOImpl implements MemberDAO {

	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
			
	@Override
	public void insertMember(Member member) throws Exception {
		sqlSession.insert("mapper.member.insertMember",member);
		sqlSession.commit();
	}

	@Override
	public Member SelectMember(String id) throws Exception {
		return sqlSession.selectOne("mapper.member.selectMember",id);
	}

	@Override
	public void updateMember(Member member) throws Exception {
		sqlSession.update("mapper.member.updateMember",member);
		sqlSession.commit();
	}

	//관리자 리스트 조회용	
	@Override
	public List<Member> searchMembers(Map<String, Object> params) throws Exception {
		    return sqlSession.selectList("mapper.member.searchMembers", params);
	}

	//관리자 회원리스트 페이징
	@Override
	public List<Member> searchMembersPaging(Map<String, Object> params) {
		return sqlSession.selectList("mapper.member.searchMembersPaging", params);
	}
	@Override
	public int countMembers(Map<String, Object> params) {
		return sqlSession.selectOne("mapper.member.countMembers", params);
	}

	//관리자정보확인
	@Override
	public Member selectAdmin() {
	    return sqlSession.selectOne("mapper.member.selectAdmin");
	}


}
