package service.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import dao.mypage.MypageDAO;
import dao.mypage.MypageDAOImpl;
import dto.Member;
import dto.Product;
import utils.PageInfo;

public class MypageServiceImpl implements MypageService {
	private MypageDAO mypageDao;
	
	public MypageServiceImpl() {
		mypageDao = new MypageDAOImpl();
	}

	@Override
	public List<Product> productListByPage(PageInfo pageInfo, String id) throws Exception {
		Integer productCnt = mypageDao.selectProductCountById(id);
		
		Integer allPage = (int)Math.ceil((double)productCnt/5);
		// startPage : 1~5 -> 1, 6~10 -> 6
		Integer startPage = (pageInfo.getCurPage()-1)/5*5+1;
		Integer endPage = startPage+5-1;
		if(endPage > allPage) endPage = allPage;
		
		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		
		Integer row = (pageInfo.getCurPage()-1)*5;
		
		Map<String,Object> paramMap = new HashMap<>();
		paramMap.put("id", id);
		paramMap.put("row", row);
		
		System.out.println(id);
		List<Product> productList = mypageDao.selectProductListByPage(paramMap);
		
		return productList;
	}

//	@Override
//	public List<Order> orderListByPage(PageInfo pageInfo) {
//		
//		return null;
//	}

}
