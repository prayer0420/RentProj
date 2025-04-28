package service.report;

import java.util.List;

import controller.report.Report;
import dao.report.ReportDAO;
import dao.report.ReportDAOImpl;
import dto.ReportedProduct;

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
}
