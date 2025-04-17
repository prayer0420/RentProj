package service.member;

import dao.member.MemberDAO;
import dao.member.MemberDAOImpl;
import dto.Member;

public class MemberServiceImpl implements MemberService {

	private MemberDAO memberDao;
	
	public MemberServiceImpl() {
		memberDao = new MemberDAOImpl();
	}
	
	@Override
	public void join(Member member) throws Exception {
		//DB로부터 아이디 중복 체크
		Member smember = memberDao.SelectMember(member.getId());
		if(smember!=null) throw new Exception("회원가입 오류");
		
		//멤버 등록(DB)
		memberDao.insertMember(member);
	}

	@Override
	public Member login(String id, String password) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean checkDoubleId(String id) throws Exception {
		Member member = memberDao.SelectMember(id);
		if(member!=null) return false;
		return true;
	}

	@Override
	public Member KakaoLogin(String code) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Member NaverLogin(String code) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
