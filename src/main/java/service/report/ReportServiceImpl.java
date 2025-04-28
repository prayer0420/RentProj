package service.report;

import java.util.List;

import dao.report.ReportDAO;
import dao.report.ReportDAOImpl;
import dto.ReportedProduct;
import utils.PageInfo;

public class ReportServiceImpl implements ReportService {
	private ReportDAO reportDAO;
	public  ReportServiceImpl() {
		reportDAO = new ReportDAOImpl();
	}

	@Override
	public List<ReportedProduct> getReportedProductList(String type, String start, String end) {
		return reportDAO.getReportedProductList(type, start, end);
	}

	@Override
	public boolean deleteReport(String[] reportNo) {
		return reportDAO.deleteReport(reportNo);
	}

	@Override
	public boolean activeReport(String[] productNo) {
		return reportDAO.activeReport(productNo);
	}

	@Override
	public boolean hideReport(String[] productNo) {
		return reportDAO.hideReport(productNo);
	}

	@Override
	public int getNewReportsCount() {
		return reportDAO.getNewReportsCount(); // 새로운 신고 건 수 조회
	}

	@Override
	public boolean updateReportStatus(int productNo) {
		return reportDAO.updateReportStatus(productNo);
	}

	@Override
	public void insertReport(ReportedProduct report) throws Exception {
		reportDAO.insertReport(report);
	}
	
	//신고내역 조회
	@Override
	public List<ReportedProduct> getMyReportList(Integer memberNo, PageInfo pageInfo) throws Exception {
	    return reportDAO.getMyReportList(memberNo, pageInfo);
	}

	@Override
	public PageInfo getMyReportPageInfo(Integer memberNo, int curPage) throws Exception {
	    int totalCount = reportDAO.getMyReportCount(memberNo);
	    int pageSize = 12;
	    int allPage = (int)Math.ceil((double)totalCount/pageSize);
	    int startPage = ((curPage-1)/5)*5+1;
	    int endPage = Math.min(startPage+4, allPage);

	    PageInfo pageInfo = new PageInfo();
	    pageInfo.setCurPage(curPage);
	    pageInfo.setAllPage(allPage);
	    pageInfo.setStartPage(startPage);
	    pageInfo.setEndPage(endPage);
	    pageInfo.setPageSize(pageSize);
	    pageInfo.setTotalCount(totalCount);

	    return pageInfo;
	}

}
