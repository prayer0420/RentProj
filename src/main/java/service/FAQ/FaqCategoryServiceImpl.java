package service.FAQ;

import java.util.List;

import dao.FAQ.FaqCategoryDAO;
import dao.FAQ.FaqCategoryDAOImpl;
import dto.FaqCategory;

public class FaqCategoryServiceImpl implements FaqCategoryService {
	
    private FaqCategoryDAO faqDAO;

    // 기본 생성자에서 DAO 객체 생성
    public FaqCategoryServiceImpl() {
        this.faqDAO = new FaqCategoryDAOImpl();
    }

    // FAQ 카테고리 전체 목록 반환
	@Override
	public List<FaqCategory> getFaqCategoryList() {
        return faqDAO.selectFaqCategoryList();
    }

    // FAQ 카테고리 삽입
	@Override
	public FaqCategory insertFaqCategory(String name) {
        FaqCategory category = new FaqCategory(); // DTO 생성
        category.setName(name);                   // 사용자 입력값 세팅
        return faqDAO.insertFaqCategory(category);
	}

}
