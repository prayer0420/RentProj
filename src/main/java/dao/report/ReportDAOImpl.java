package dao.report;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.ReportQueryParams;
import dto.ReportedProduct;
import utils.MybatisSqlSessionFactory;

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
	                sqlSession.update("mapper.report.activateProduct", Integer.parseInt(no));
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
	                sqlSession.update("mapper.report.hideProduct", Integer.parseInt(no));
	            }
	            sqlSession.commit();
	            return true;
	        } catch (Exception e) {
	            sqlSession.rollback();
	            e.printStackTrace();
	            return false;
	        }
	    }
	}
