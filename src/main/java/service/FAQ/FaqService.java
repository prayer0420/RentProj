package service.FAQ;

import java.util.List;

import dto.Faq;

public interface FaqService {
   //FAQ 등록
   boolean registerFaq(Faq faq);
   // FAQ 수정
   boolean modifyFaq(Faq faq);
   // FAQ 다건 삭제
   boolean deleteFaqList(int[] faqNos);
   // FAQ 전체 조회
   List<Faq> getFaqList();
}
