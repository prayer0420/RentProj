package service.mark;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.mark.MarkDAO;
import dao.mark.MarkDAOImpl;
import utils.PageInfo;

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
	
    @Override
    public List<Map<String, Object>> selectMyMarkList(Integer memberNo, PageInfo pageInfo) throws Exception {
        Map<String, Object> param = new HashMap<>();
        param.put("memberNo", memberNo);
        System.out.println("memberNo"+memberNo);
        param.put("startRow", (pageInfo.getCurPage() - 1) * pageInfo.getPageSize());
        param.put("pageSize", pageInfo.getPageSize()); // 페이지당 6개

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
}
