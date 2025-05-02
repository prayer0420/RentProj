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
	
	// MyLendDetail 페이지 하단에 출력할, 상품의 대여이력 리스트 불러오기
	List<Order> selectLendHistoryByProductNo(Integer productNo);
	
	// MyLendDetail 페이지에서 대여이력 중 한 행 선택시 orderNo로 해당 행의 대여상세내역 불러오기(MyLendHistoryDetail)
	Map<String, Object> selectLendDetailByOrderNo(String id, Integer orderNo) throws Exception;
	
	// 상품삭제 버튼 누르면 삭제(삭제 상태로 업데이트)
	Integer deleteProduct(Integer productNo);
	
	// 상품 숨기기 버튼 누르면 숨기기
	Integer hideProduct(Integer productNo);
	
	// 구매확정 버튼 누르면 orderStatus 업데이트 ('구매완료')
	Integer updateOrderStatusToCompleted(Integer orderNo);
	
	// 빌리기시작 버튼 누르면 orderStatus 업데이트 ('대여중')
	Integer updateRentStart(Integer orderNo);
	
	// 반납송장번호 입력 업데이트
	boolean updateReturnInvoiceInfo(Integer orderNo, String reDeliveryComp, String reInvoiceNo);
	
	// 상품반납완료 버튼 누르면 orderStatus 업데이트('거래완료')
	Integer updateRentCompleted(Integer orderNo);
	
	
	

}
