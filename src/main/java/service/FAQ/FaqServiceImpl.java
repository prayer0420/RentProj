package service.FAQ;

import java.util.List;

import dao.FAQ.FaqDAO;
import dao.FAQ.FaqDAOImpl;
import dto.Faq;

public class FaqServiceImpl implements FaqService {
	
    private FaqDAO faqDAO = new FaqDAOImpl();

	@Override
	public boolean registerFaq(Faq faq) {
        return faqDAO.insertFaq(faq) > 0;
	}

	@Override
	public boolean modifyFaq(Faq faq) {
        return faqDAO.updateFaq(faq) > 0;
    }

	@Override
	public boolean deleteFaqList(int[] faqNos) {
        return faqDAO.deleteFaqList(faqNos) > 0;
    }

	@Override
	public List<Faq> getFaqList() {
	    List<Faq> faqList = faqDAO.selectFaqList();
	    return faqList;
    }

}
