package service.mypage;

import java.util.List;

import dao.mypage.MypageDAO;
import dao.mypage.MypageDAOImpl;
import dto.Product;
import service.MypageService;
import utils.PageInfo;

public class MypageServiceImpl implements MypageService {
	MypageDAO mypageDao = new MypageDAOImpl();

	@Override
	public List<Product> productListByPage(PageInfo pageInfo) throws Exception {
		Integer productCnt = mypageDao.selectProductCount();
		Integer allPage = (int)Math.ceil((double)productCnt/5);
		// startPage : 1~5 -> 1, 6~10 -> 6
		Integer startPage = (pageInfo.getCurPage()-1)/5*5+1;
		
		
		return null;
	}

}
