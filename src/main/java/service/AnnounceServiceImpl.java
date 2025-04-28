package service;

import java.util.List;

import dao.AnnounceDAO;
import dao.AnnounceDAOImpl;
import dto.Announce;

	public class AnnounceServiceImpl implements AnnounceService {

	    // DAO 객체 생성 (MyBatis를 통해 DB와 연결)
	    private AnnounceDAO dao = new AnnounceDAOImpl();

	    //새로운 공지사항을 생성하는 메서드
	    @Override
	    public boolean createAnnounce(Announce announce)  throws Exception {
	        return dao.insert(announce) > 0;  // 삽입 성공 시 1 이상의 값 반환
	    }

	    //기존 공지사항을 수정하는 메서드
	    @Override
	    public boolean updateAnnounce(Announce announce) throws Exception  {
	        return dao.update(announce) > 0;  // 수정 성공 시 1 이상의 값 반환
	    }

	    //공지사항을 삭제하는 메서드
	    @Override
	    public boolean deleteAnnounces(List<Integer> noList) throws Exception  {
	        return dao.delete(noList) > 0;  // 삭제 성공 시 1 이상의 값 반환
	    }

	    //특정 공지사항 번호에 해당하는 공지사항을 조회하는 메서드

	    @Override
	    public Announce getAnnounceByNo(int no) throws Exception  {
	        return dao.selectOne(no);  // 공지사항 번호를 기준으로 하나의 공지사항 조회
	    }

	    //모든 공지사항 목록을 조회하는 메서드
	    @Override
	    public List<Announce> getAllAnnounces() throws Exception {
	        return dao.selectAll();  // 모든 공지사항을 조회하여 리스트 반환
	    }
	}

