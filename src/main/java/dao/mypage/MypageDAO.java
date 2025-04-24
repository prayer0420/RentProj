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
	
	// 나의 구매내역 상세 불러오기(MyOrderDetail)
	Map<String, Object> selectMyOrderDetail(Integer orderNo, String id) throws Exception;
	
	// 나의 빌린상품 리스트 불러오기(MyRent)
	Integer selectRentCountById(String id) throws Exception;
	List<Map<String, Object>> selectRentListByPage(Map<String, Object> paramMap) throws Exception;
	
	// 나의 빌리기 내역 상세 불러오기(MyRentDetail)
	Map<String, Object> selectMyRentDetail(Integer orderNo, String id) throws Exception;
	
	// 나의 대여(빌려주는)상품 리스트 불러오기(MyLend)
	Integer selectLendCountById(String id);
	List<Map<String, Object>> selectLendListByPage(Map<String, Object> paramMap);
	
	// 나의 대여(빌려주는)내역 상세 불러오기(MyLendDetail)
	Map<String, Object> selectMyLendDetail(Integer orderNo, String id);
	
	// MyLendDetail 페이지에서 대여이력 중 한 행 선택시 orderNo로 해당 행의 대여상세내역 불러오기(MyLendHistoryDetail)
	Map<String, Object> selectLendDetailByOrderNo(String id, Integer orderNo) throws Exception;

}
