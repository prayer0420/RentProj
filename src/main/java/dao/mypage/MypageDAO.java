package dao.mypage;

import java.util.List;
import java.util.Map;

import dto.Order;
import dto.Product;

public interface MypageDAO {

	// 나의 판매상품 리스트 불러오기(MySell)
	Integer selectProductCountById(String id) throws Exception;
	List<Map<String, Object>> selectProductListByPage(Map<String, Object> paramMap) throws Exception;
	
	// 나의 판매내역 상세 불러오기(MySellDetail)
	Map<String, Object> selectMySellDetail(Integer orderNo, String id) throws Exception;

	public void updateLocation(String memberId, double latitude, double longitude) ;

	// 송장번호, 택배사 업데이트
	boolean updateInvoiceInfo(Integer orderNo, String deliveryComp, String invoiceNo) throws Exception;
	
	// 나의 구매내역 리스트 불러오기(MyOrder) 
	Integer selectOrderCountById(String id) throws Exception;
	List<Map<String,Object>> selectOrderListByPage(Map<String, Object> paramMap) throws Exception;

}
