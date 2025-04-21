package service.report;

import java.util.List;

import dao.report.ReportDAO;
import dao.report.ReportDAOImpl;
import dto.ReportedProduct;

public class ReportServiceImpl implements ReportService {
	
    private ReportDAO reportDAO = new ReportDAOImpl();

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

}
