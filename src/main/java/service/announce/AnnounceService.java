package service.announce;

import java.util.List;

import dto.Announce;

public interface AnnounceService {
	List<Announce> announceSelectAll() throws Exception;
	Announce announceSelectOne(Integer no) throws Exception;
	
	// 관리자
    boolean createAnnounce(Announce announce) throws Exception ;
    boolean updateAnnounce(Announce announce) throws Exception ;
    boolean deleteAnnounces(List<Integer> noList) throws Exception ;
    Announce getAnnounceByNo(int no) throws Exception ;
    List<Announce> getAllAnnounces() throws Exception ;

}
