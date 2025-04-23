package service.order;

import java.util.List;
import java.util.Map;

import dto.Order;
import utils.PageInfo;

public interface OrderService {
	void insertOrder(Order order) throws Exception;
	
	// 관리자 전체 주문 조회용
    List<Order> searchOrders(Map<String, Object> params, PageInfo pageInfo);

}
