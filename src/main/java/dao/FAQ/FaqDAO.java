package dao.FAQ;

import java.util.List;

import dto.FaqCategory;

public interface FaqDAO {

    // FAQ 카테고리 전체 목록 조회
    List<FaqCategory> selectFaqCategoryList();

    // FAQ 카테고리 추가
    FaqCategory insertFaqCategory(FaqCategory category);
}
