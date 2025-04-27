package service.FAQ;

import java.util.List;

import dto.Faq;
import dto.FaqCategory;

public interface FaqService {
    // FAQ 카테고리 목록 조회
    List<FaqCategory> getFaqCategoryList();

    // FAQ 카테고리 등록
    FaqCategory insertFaqCategory(String name);

    List<Faq> selectAllFaq() throws Exception;
    
    Faq faqSelectOne(Integer no) throws Exception;
}
