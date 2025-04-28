package dao.announce;

import java.util.List;

import dto.Announce;

public interface AnnounceDAO {
	List<Announce> selectAll() throws Exception;
	Announce selectOne(Integer no) throws Exception;

}
