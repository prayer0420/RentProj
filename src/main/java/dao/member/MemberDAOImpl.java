package dao.member;

import java.util.HashMap;
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

	//관리자 리스트 조회용 - 회원 검색 + 페이징된 리스트  
	@Override
	public List<Member> searchMembersWithPaging(Map<String, Object> params) throws Exception {
		 return sqlSession.selectList("mapper.member.searchMembersWithPaging", params);
	}
	@Override
	public Integer selectMembersCountWithFilter(Map<String, Object> params) throws Exception {
		return sqlSession.selectOne("mapper.member.selectMembersCountWithFilter", params);
	}

	
    //관리자회원정보 조회용 - 관리자 정보 화면 진입 시 사용
	@Override
	public Member selectAdmin() {
	    return sqlSession.selectOne("mapper.member.selectAdmin");
	}
    //관리자 기본 정보 (비밀번호, 이름, 닉네임) 수정 
	@Override
	public void updateAdminInfo(Member member) throws Exception {
	    sqlSession.update("mapper.member.updateAdminBasicInfo", member);
	    sqlSession.commit();
		
	}

	//위치 업데이트
    @Override
    public void updateLocation(int memberNo, double lat, double lng, String address) {
        Map<String, Object> map = new HashMap<>();
        map.put("no", memberNo);
        map.put("lat", lat);
        map.put("lng", lng);
        map.put("location", address);
        sqlSession.update("mapper.member.updateLocation", map);
        sqlSession.commit();
      }
}
