package service.order;

import java.util.List;
import java.util.Map;

import dto.Order;
import utils.PageInfo;

public interface OrderService {
	void insertOrder(Order order) throws Exception;
	
	// 관리자 전체 주문 조회용
    List<Order> searchOrders(Map<String, Object> params, PageInfo pageInfo);
    // 지연 주문 목록 조회
    List<Order> getDelayedOrders(String type, String keyword);
    boolean hasMemberOrderProduct(Integer memberNo,Integer productNO) throws Exception;
    boolean checkOrder(Integer productNo) throws Exception;
    void updateOrderStatus(int orderNo, String orderStatus) throws Exception;

}
