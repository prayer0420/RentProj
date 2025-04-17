package service.mypage;

import java.util.List;

import dao.mypage.MypageDAO;
import dao.mypage.MypageDAOImpl;
import dto.Product;
import utils.PageInfo;

public class MypageServiceImpl implements MypageService {
	private MypageDAO mypageDao;
	
	public MypageServiceImpl() {
		mypageDao = new MypageDAOImpl();
	}

	@Override
	public List<Product> productListByPage(PageInfo pageInfo) throws Exception {
		Integer productCnt = mypageDao.selectProductCount();
		Integer allPage = (int)Math.ceil((double)productCnt/5);
		// startPage : 1~5 -> 1, 6~10 -> 6
		Integer startPage = (pageInfo.getCurPage()-1)/5*5+1;
		Integer endPage = startPage+5-1;
		if(endPage > allPage) endPage = allPage;
		
		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		
		Integer row = (pageInfo.getCurPage()-1)*5+1;
		List<Product> productList = mypageDao.selectProductListByPage(row);
		
		return productList;
	}

}
