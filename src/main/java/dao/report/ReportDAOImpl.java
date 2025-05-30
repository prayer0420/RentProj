package dao.report;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.ReportQueryParams;
import dto.ReportedProduct;
import utils.MybatisSqlSessionFactory;
import utils.PageInfo;

public class ReportDAOImpl implements ReportDAO {

    // 공통 SqlSession
	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	

	//신고 상품 목록 조회 (신고유형 + 날짜범위)
	@Override
	public List<ReportedProduct> getReportedProductList(String type, String start, String end) {
		try {
			
			System.out.println("📦 getReportedProductList 실행됨");
			System.out.println("type: " + type + ", start: " + start + ", end: " + end);
			
			return sqlSession.selectList("mapper.report.selectReportedProductList",
					new ReportQueryParams(type, start, end));
			
		} catch (Exception e) {
            e.printStackTrace();
            return null;
        }
	}

	// 신고 삭제 (신고번호 배열)
	@Override
	public boolean deleteReport(String[] reportNo) {
        try {
            for (String no : reportNo) {
                sqlSession.delete("mapper.report.deleteReport", Integer.parseInt(no));
            }
            sqlSession.commit();
            return true;
        } catch (Exception e) {
            sqlSession.rollback();
            e.printStackTrace();
            return false;
        }
    }
	
	// 상품 활성화 (상품번호 배열)
	@Override
	public boolean activeReport(String[] productNo) {
		  try {
	            for (String no : productNo) {
	                // 상품 활성화
	                sqlSession.update("mapper.report.activateProduct", Integer.parseInt(no));
	                
	                // 신고 상태 업데이트
	                updateReportStatus(Integer.parseInt(no));  // 상태 업데이트 호출
	            }
	            sqlSession.commit();
	            return true;
	        } catch (Exception e) {
	            sqlSession.rollback();
	            e.printStackTrace();
	            return false;
	        }
	    }

	// 상품 숨김 처리 (상품번호 배열)
	@Override
	public boolean hideReport(String[] productNo) {
		 try {
	            for (String no : productNo) {
	                // 상품 숨김
	                sqlSession.update("mapper.report.hideProduct", Integer.parseInt(no));
	                
	                // 신고 상태 업데이트
	                updateReportStatus(Integer.parseInt(no));  // 상태 업데이트 호출
	            }
	            sqlSession.commit();
	            return true;
	        } catch (Exception e) {
	            sqlSession.rollback();
	            e.printStackTrace();
	            return false;
	        }
	    }

	
    @Override
	public int getNewReportsCount() {
        int count = 0;

        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            count = session.selectOne("mapper.report.getNewReportsCount");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    
    }

	@Override
	public boolean updateReportStatus(int productNo) {
	    try {
	        // 신고 상품의 상태를 'processed'로 업데이트
	        sqlSession.update("mapper.report.updateReportStatus", productNo);
	        sqlSession.commit();
	        return true;
	    } catch (Exception e) {
	        sqlSession.rollback();
	        e.printStackTrace();
	        return false;
	    }
	}

	@Override
	public void insertReport(ReportedProduct report) throws Exception {
		sqlSession.insert("mapper.report.insertReport",report);
		sqlSession.commit();
		
	}
	
    // 내 신고함 목록
	@Override
	public List<ReportedProduct> getMyReportList(Integer memberNo, PageInfo pageInfo) throws Exception {
	    Map<String, Object> param = new HashMap<>();
	    param.put("memberNo", memberNo);
	    param.put("startRow", (pageInfo.getCurPage()-1)*pageInfo.getPageSize());
	    param.put("pageSize", pageInfo.getPageSize());
	    return sqlSession.selectList("mapper.report.selectMyReportList", param);
	}

	@Override
	public int getMyReportCount(Integer memberNo) throws Exception {
	    return sqlSession.selectOne("mapper.report.selectMyReportCount", memberNo);
	}
}