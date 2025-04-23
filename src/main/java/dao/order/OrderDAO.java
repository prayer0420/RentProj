package dao.order;

import java.util.List;
import java.util.Map;

import dto.Order;

public interface OrderDAO {
	void insertOrder(Order order) throws Exception;
	// admin 조건에 따라 주문 목록을 조회 (페이징 포함)
    List<Order> searchOrders(Map<String, Object> paramMap);
    // admin 검색 조건에 따른 주문 총 개수 조회 (페이징 계산용)
    int getOrderCount(Map<String, Object> paramMap);

}
