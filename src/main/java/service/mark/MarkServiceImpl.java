package service.mark;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.mark.MarkDAO;
import dao.mark.MarkDAOImpl;
import dto.Mark;
import utils.PageInfo;

public class MarkServiceImpl implements MarkService {
	MarkDAO markDAO;
	
	public MarkServiceImpl(){
		markDAO = new MarkDAOImpl();
	}

	@Override
	public boolean existsMark(Integer memberNo, Integer productNo) throws Exception {
		return markDAO.existsMark(memberNo, productNo);
	}

	@Override
	public void insertMark(Mark mark) throws Exception {
		markDAO.insertMark(mark);
	}

	@Override
	public void deleteMark(Mark mark) throws Exception {
		markDAO.deleteMark(mark);
		
	}
	
    @Override
    public List<Map<String, Object>> selectMyMarkList(Integer memberNo, PageInfo pageInfo) throws Exception {
        Map<String, Object> param = new HashMap<>();
        param.put("memberNo", memberNo);
        System.out.println("memberNo"+memberNo);
        param.put("offset", (pageInfo.getCurPage() - 1) * pageInfo.getPageSize());
        param.put("limit", pageInfo.getPageSize()); // 페이지당 6개

        return markDAO.selectMyMarkList(param);
        }

    @Override
    public PageInfo getPageInfo(Integer memberNo, int curPage) throws Exception {
        int totalCount = markDAO.selectMarkCount(memberNo);  // 전체 찜 수 가져오기
        PageInfo pageInfo = new PageInfo(curPage);

        pageInfo.setPageSize(6); // 한 페이지 6개 고정
        pageInfo.setTotalCount(totalCount);

        int allPage = (int)Math.ceil((double)totalCount / pageInfo.getPageSize());
        pageInfo.setAllPage(allPage);

        int startPage = ((curPage - 1) / 10) * 10 + 1;
        int endPage = Math.min(startPage + 9, allPage);
        pageInfo.setStartPage(startPage);
        pageInfo.setEndPage(endPage);

        return pageInfo;
    }

	@Override
	public int countMarkProduct(Integer productNo) throws Exception {
		return markDAO.countMarkProduct(productNo);
		
	}
}
