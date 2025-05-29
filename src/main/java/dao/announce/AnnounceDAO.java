package dao.announce;

import java.util.List;

import dto.Announce;

public interface AnnounceDAO {
	List<Announce> selectAll() throws Exception;
	Announce selectOne(Integer no) throws Exception;
	
	
    // 공지사항 추가
    int insert(Announce announce) throws Exception ;
    // 공지사항을 DB에서 수정하는 메서드
    int update(Announce announce) throws Exception ;
    // 공지사항을 삭제
    int delete(List<Integer> noList) throws Exception ;
    // 하나의 공지사항을 조회 (팝업)
    Announce selectOne(int no) throws Exception ;

}
