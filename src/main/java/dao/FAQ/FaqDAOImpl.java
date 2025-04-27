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
            return session.update("mapper.faq.updateFaq", faq);
        }
    }
	// FAQ 다건 삭제
	@Override
	public int deleteFaqList(int[] faqNos) {
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
}
