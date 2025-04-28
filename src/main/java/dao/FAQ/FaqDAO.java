package dao.FAQ;

import java.util.List;

import dto.Faq;
import dto.FaqCategory;

public interface FaqDAO {
    int insertFaq(Faq faq); // 등록
    int updateFaq(Faq faq); // 수정
    int deleteFaqList(List<Integer> faqNos);// 다건 삭제
    List<Faq> selectFaqList(); // 전체 조회
    List<FaqCategory> selectFaqCategoryList(); // FAQ 카테고리 전체 조회 (modal 전달 용도)
    Faq selectFaqByNo(int no); 
}
