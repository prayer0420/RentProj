package service.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.mypage.MypageDAO;
import dao.mypage.MypageDAOImpl;
import dto.Order;
import dto.Product;
import utils.PageInfo;

public class MypageServiceImpl implements MypageService {
	private MypageDAO mypageDao;
	
	public MypageServiceImpl() {
		mypageDao = new MypageDAOImpl();
	}

	@Override
	public List<Map<String,Object>> productListByPage(PageInfo pageInfo, String id) throws Exception {
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
		
		return mypageDao.selectProductListByPage(paramMap);
	}

	@Override
	public Map<String, Object> mySellDetail(Integer orderNo, String id) throws Exception {
		
		return mypageDao.selectMySellDetail(orderNo,id);
	}

	@Override
	public boolean updateInvoiceInfo(Integer orderNo, String deliveryComp, String invoiceNo) throws Exception {
		
		return mypageDao.updateInvoiceInfo(orderNo, deliveryComp, invoiceNo);
	}

	@Override
	public List<Map<String,Object>> orderListByPage(PageInfo pageInfo,String id) throws Exception {
		Integer orderCnt = mypageDao.selectOrderCountById(id);
		
		Integer allPage = (int)Math.ceil((double)orderCnt/5);
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
		
		return mypageDao.selectOrderListByPage(paramMap);
	}

	@Override
	public Map<String, Object> myOrderDetail(Integer orderNo, String id) throws Exception {
		
		return mypageDao.selectMyOrderDetail(orderNo,id);
	}


}
