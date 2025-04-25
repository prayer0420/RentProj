package service.FAQ;

import java.util.List;

import dto.FaqCategory;

public interface FaqService {
    // FAQ 카테고리 목록 조회
    List<FaqCategory> getFaqCategoryList();

    // FAQ 카테고리 등록
    FaqCategory insertFaqCategory(String name);
}
