package service.FAQ;

import java.util.List;

import dao.FAQ.FaqDAO;
import dao.FAQ.FaqDAOImpl;
import dto.Faq;
import dto.FaqCategory;

public class FaqServiceImpl implements FaqService {
	
    private FaqDAO faqDAO = new FaqDAOImpl();

	@Override
	public boolean registerFaq(Faq faq) {
        return faqDAO.insertFaq(faq) > 0;
	}

	@Override
	public List<Faq> selectAllFaq() throws Exception {
		return faqDAO.selectAllFaq();
		
	}

	@Override
	public Faq faqSelectOne(Integer no) throws Exception {
		return faqDAO.selectOne(no);
	}
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

	@Override
	public List<FaqCategory> getFaqCategoryList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public FaqCategory insertFaqCategory(String name) {
		// TODO Auto-generated method stub
		return null;
	}

}
