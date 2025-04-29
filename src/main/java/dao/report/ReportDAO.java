package dao.report;

import java.util.List;

import dto.ReportedProduct;
import utils.PageInfo;

public interface ReportDAO {
	// 검색 조건에 따라 신고된 상품 목록 조회
    List<ReportedProduct> getReportedProductList(String type, String start, String end);
    //신고삭제
    boolean deleteReport(String[] reportNo);
    //상품활성화
    boolean activeReport(String[] productNo);
    //상품 숨김
    boolean hideReport(String[] productNo);
    // 새로운 신고 건 수 조회
    int getNewReportsCount(); 
    // 신고 상태 업데이트 (처리된 상태로)
    boolean updateReportStatus(int productNo);
    
    void insertReport(ReportedProduct report) throws Exception;
    
    //신고내역 보기
    List<ReportedProduct> getMyReportList(Integer memberNo, PageInfo pageInfo) throws Exception;
    int getMyReportCount(Integer memberNo) throws Exception;

	
}
