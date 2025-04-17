package dao;

import org.apache.ibatis.session.SqlSession;

import dto.Member;
import utils.mybatisSqlSessionFactory;

public class MemberDAOImpl implements MemberDAO {

	SqlSession sqlSession = mybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	
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

}
