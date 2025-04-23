package service.mypage;

import java.util.List;
import java.util.Map;

import dto.Order;
import dto.Product;
import utils.PageInfo;

public interface MypageService {

	List<Map<String,Object>> productListByPage(PageInfo pageInfo, String id) throws Exception;
	Map<String, Object> mySellDetail(Integer orderNo, String id) throws Exception;
	boolean updateInvoiceInfo(Integer orderNo, String deliveryComp, String invoiceNo) throws Exception;
	List<Map<String, Object>> orderListByPage(PageInfo pageInfo,String id) throws Exception;
	Map<String, Object> myOrderDetail(Integer orderNo, String id) throws Exception;
	List<Map<String, Object>> rentListByPage(PageInfo pageInfo, String id) throws Exception;

}
