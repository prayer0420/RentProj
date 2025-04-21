package service.report;

import java.util.List;

import dto.ReportedProduct;

public interface ReportService {

	// 신고상품 목록 조회
    List<ReportedProduct> getReportedProductList(String type, String start, String end);
	// 신고 삭제
    boolean deleteReport(String[] reportNo);
    // 상품 활성화 (isHide = false)
    boolean activeReport(String[] productNo);
    // 상품 숨김 처리 (isHide = true)
    boolean hideReport(String[] productNo);
}
