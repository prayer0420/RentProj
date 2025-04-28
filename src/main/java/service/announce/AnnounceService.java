package service.announce;

import java.util.List;

import dto.Announce;

public interface AnnounceService {
	List<Announce> announceSelectAll() throws Exception;
	Announce announceSelectOne(Integer no) throws Exception;

}
