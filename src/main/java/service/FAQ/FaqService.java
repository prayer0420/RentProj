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

   //FAQ 등록
   boolean registerFaq(Faq faq);
   // FAQ 수정
   boolean modifyFaq(Faq faq);
   // FAQ 다건 삭제
   boolean deleteFaqList(List<Integer> faqNos);
   // FAQ 전체 조회
   List<Faq> getFaqList();
   // 특정 FAQ 조회
   Faq getFaqByNo(int no);
}
