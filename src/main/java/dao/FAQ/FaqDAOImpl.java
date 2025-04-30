package dao.FAQ;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import dto.Faq;
import dto.FaqCategory;
import utils.MybatisSqlSessionFactory;

public class FaqDAOImpl implements FaqDAO {
    // SqlSessionFactory 생성
	private SqlSessionFactory factory = MybatisSqlSessionFactory.getSqlSessionFactory(); 
	private SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

    // FAQ 카테고리 하나를 DB에 추가하는 메서드
    @Override
    public FaqCategory insertFaqCategory(FaqCategory category) {
        // auto-commit 설정된 SqlSession 사용
        try (SqlSession session = factory.openSession(true)) {
            int result = session.insert("mapper.faq.insertFaqCategory", category);
            if (result > 0) {
                return category; // keyProperty="no" 때문에 no 값 자동 세팅됨
            } else {
                return null;
            }
        } catch (Exception e) {
            System.out.println("카테고리 삽입 실패: " + e.getMessage());
            return null;
        }
    }
	@Override
	public List<Faq> selectAllFaq() {
		return session.selectList("mapper.faq.selectAllFaq");
	}
	@Override
	public Faq selectOne(Integer no) throws Exception {
		return session.selectOne("mapper.faq.faqSelectOne",no);
	}
	// FAQ 등록
	@Override
	public int insertFaq(Faq faq) {
        try (SqlSession session = factory.openSession(true)) {
            return session.insert("mapper.faq.insertFaq", faq);
        }
    }
	// FAQ 수정
	@Override
	public int updateFaq(Faq faq) {
		    try (SqlSession session = factory.openSession(true)) {
		        int result = session.update("mapper.faq.updateFaq", faq);
		        return result;
		    }
		}

	// FAQ 다건 삭제
	@Override
	public int deleteFaqList(List<Integer> faqNos) {
        try (SqlSession session = factory.openSession(true)) {
            Map<String, Object> params = new HashMap<>();
            params.put("faqNos", faqNos);
            return session.delete("mapper.faq.deleteFaqList", params);
        }
    }
	// FAQ 전체 조회
	@Override
	public List<Faq> selectFaqList() {
        try (SqlSession session = factory.openSession()) {
            return session.selectList("mapper.faq.selectFaqList");
        }
    }
	
	// FAQ 카테고리 전체 조회 (modal 전달 용도)
	@Override
	public List<FaqCategory> selectFaqCategoryList() {
        try (SqlSession session = factory.openSession()) {
            return session.selectList("mapper.faq.selectFaqCategoryList");
        }
	}
	
	@Override
	public Faq selectFaqByNo(int no) {
        try (SqlSession session = factory.openSession()) {
            return session.selectOne("mapper.faq.selectFaqByNo", no);
        }
    }
}
