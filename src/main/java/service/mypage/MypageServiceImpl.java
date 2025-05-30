package service.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.mypage.MypageDAO;
import dao.mypage.MypageDAOImpl;
import dto.Order;
import service.settlement.SettlementService;
import service.settlement.SettlementServiceImpl;
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

	@Override
	public List<Map<String, Object>> rentListByPage(PageInfo pageInfo, String id) throws Exception {
		Integer orderCnt = mypageDao.selectRentCountById(id);
		
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
		
		return mypageDao.selectRentListByPage(paramMap);
	}

	@Override
	public Map<String, Object> myRentDetail(Integer orderNo, String id) throws Exception {
		
		return mypageDao.selectMyRentDetail(orderNo,id);
	}

	@Override
	public List<Map<String, Object>> lendListByPage(PageInfo pageInfo, String id) throws Exception {
		Integer lendCnt = mypageDao.selectLendCountById(id);
		
		Integer allPage = (int)Math.ceil((double)lendCnt/5);
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
		
		return mypageDao.selectLendListByPage(paramMap);
	}

	@Override
	public Map<String, Object> myLendDetail(Integer orderNo, String id) throws Exception {
		
		return mypageDao.selectMyLendDetail(orderNo,id);
	}

	@Override
	public Map<String, Object> getLendDetailByOrderNo(String id, Integer orderNo) throws Exception {
		
		return mypageDao.selectLendDetailByOrderNo(id, orderNo);
	}

	@Override
	public List<Order> getLendHistoryByProductNo(Integer productNo) throws Exception {
		
		return mypageDao.selectLendHistoryByProductNo(productNo);
	}

	@Override
	public boolean deleteProduct(Integer productNo) throws Exception {
		
		return mypageDao.deleteProduct(productNo) > 0;
	}

	@Override
	public boolean hideProduct(Integer productNo) throws Exception {
		
		return mypageDao.hideProduct(productNo) > 0;
	}
	
	@Override
	public boolean confirmOrder(Integer orderNo) throws Exception {
	    // Integer로 결과 받기
	    Integer updateCount = mypageDao.updateOrderStatusToCompleted(orderNo);
		// 구매확정 시, 거래완료로 상태 업데이트 
	    boolean result = updateCount != null && updateCount > 0;
	    // 상태 업데이트 성공 시, settlement insert
	    if (result) {
	        try {
	            SettlementService settlementService = new SettlementServiceImpl();
	            settlementService.insertSettlementByOrderNo(orderNo);
	        } catch (Exception e) {
	            System.err.println("[정산 데이터 생성 실패] orderNo=" + orderNo);
	            e.printStackTrace();
	        }
	    }

	    return result;
	}

	@Override
	public boolean rentStart(Integer orderNo) throws Exception {
		
		return mypageDao.updateRentStart(orderNo) >0;
	}

	@Override
	public boolean returnSetInvoiceInfo(Integer orderNo, String reDeliveryComp, String reInvoiceNo) throws Exception {
		
		return mypageDao.updateReturnInvoiceInfo(orderNo, reDeliveryComp, reInvoiceNo);
	}

	@Override
	public boolean confirmReturn(Integer orderNo) throws Exception {
		
	    Integer updateCount = mypageDao.updateRentCompleted(orderNo);
		// 상품반납확인 시, 거래완료로 상태 업데이트 
	    boolean result = updateCount != null && updateCount > 0;
	    // 상태 업데이트 성공 시, settlement insert
	    if (result) {
	        try {
	            SettlementService settlementService = new SettlementServiceImpl();
	            settlementService.insertSettlementByOrderNo(orderNo);
	        } catch (Exception e) {
	            System.err.println("[정산 데이터 생성 실패] orderNo=" + orderNo);
	            e.printStackTrace();
	        }
	    }

	    return result;
	}


}
