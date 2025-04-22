package service.report;
import java.util.List;
import dto.ReportedProduct;
public interface ReportService {
 
 // 신고상품 목록 조회 
	List<ReportedProduct> getReportedProductList(String type, String start, String end); // 신고 삭제 
	boolean deleteReport(String[] reportNo);// 상품 활성화 (isHide = false) 
	boolean activeReport(String[] productNo);
	boolean hideReport(String[] productNo); // 새로운 신고 건 수 조회(새로운 신고가 처리되지 않은 건) 
	int getNewReportsCount(); // 신고 상태 업데이트 (처리된 상태로) 
	boolean updateReportStatus(int productNo); 
}
 