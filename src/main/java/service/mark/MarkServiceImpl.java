package service.mark;

import dao.mark.MarkDAO;
import dao.mark.MarkDAOImpl;
import dto.Mark;

public class MarkServiceImpl implements MarkService {
	MarkDAO markDAO;
	
	public MarkServiceImpl(){
		markDAO = new MarkDAOImpl();
	}

	@Override
	public boolean existsMark(Integer memberNo, Integer productNo) throws Exception {
		if(markDAO.existsMark(memberNo, productNo)) {
			deleteMark(memberNo, productNo);
			return false;
		}else {
			insertMark(memberNo, productNo);
			return true;
		}
	}

	@Override
	public void insertMark(Integer memberNo, Integer productNo) throws Exception {
		markDAO.insertMark(memberNo, productNo);
	}

	@Override
	public void deleteMark(Integer memberNo, Integer productNo) throws Exception {
		markDAO.deleteMark(memberNo, productNo);
		
	}
	
	
	



}
