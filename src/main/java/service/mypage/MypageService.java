package service.mypage;

import java.util.List;
import java.util.Map;

import dto.Order;
import dto.Product;
import utils.PageInfo;

public interface MypageService {

	List<Map<String,Object>> productListByPage(PageInfo pageInfo, String id) throws Exception;
	
	Map<String, Object> mySellDetail(Integer orderNo, String id) throws Exception;
	
	// 송장번호 입력
	boolean updateInvoiceInfo(Integer orderNo, String deliveryComp, String invoiceNo) throws Exception;
	
	List<Map<String, Object>> orderListByPage(PageInfo pageInfo,String id) throws Exception;
	
	Map<String, Object> myOrderDetail(Integer orderNo, String id) throws Exception;
	
	List<Map<String, Object>> rentListByPage(PageInfo pageInfo, String id) throws Exception;	
	
	Map<String, Object> myRentDetail(Integer orderNo, String id) throws Exception;
	
	List<Map<String, Object>> lendListByPage(PageInfo pageInfo, String id) throws Exception;
	
	Map<String, Object> myLendDetail(Integer orderNo, String id) throws Exception;
	
	Map<String, Object> getLendDetailByOrderNo(String id, Integer orderNo) throws Exception;
	
	// 대여이력 리스트 불러오기
	List<Order> getLendHistoryByProductNo(Integer productNo) throws Exception;

	// 나의 판매상품 리스트(mySell)에서 게시중인 상품 삭제
	boolean deleteProduct(Integer productNo) throws Exception;

	// 내가 구매한 상품의 '구매확정' 버튼 AJAX
	boolean confirmOrder(Integer orderNo) throws Exception;

}
