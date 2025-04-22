package service.order;

import dao.order.OrderDAO;
import dao.order.OrderDAOImpl;
import dto.Order;

public class OrderServiceImpl implements OrderService {
	OrderDAO orderDAO;
	
	public OrderServiceImpl(){
		orderDAO = new OrderDAOImpl();
	}
	
	@Override
	public void insertOrder(Order order) throws Exception {
		orderDAO.insertOrder(order);
	}

}
