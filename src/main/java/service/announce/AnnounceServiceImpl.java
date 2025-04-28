package service.announce;

import java.util.List;

import dao.announce.AnnounceDAO;
import dao.announce.AnnounceDAOImpl;
import dto.Announce;

public class AnnounceServiceImpl implements AnnounceService{
	AnnounceDAO announceDAO;

	public AnnounceServiceImpl(){
		announceDAO = new AnnounceDAOImpl();
	}
	
	@Override
	public List<Announce> announceSelectAll() throws Exception {
		return announceDAO.selectAll();
	}

	@Override
	public Announce announceSelectOne(Integer no) throws Exception {
		return announceDAO.selectOne(no);
	}
	

}
