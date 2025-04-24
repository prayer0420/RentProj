package dao.order;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Order;
import utils.MybatisSqlSessionFactory;

public class OrderDAOImpl implements OrderDAO {
	SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	

	@Override
	public void insertOrder(Order order) throws Exception {
		session.insert("mapper.order.insertOrder",order);
		session.commit();
	}

	@Override
	public List<Order> searchOrders(Map<String, Object> paramMap) {
		return session.selectList("mapper.order.searchOrders", paramMap);
	}

	@Override
	public int getOrderCount(Map<String, Object> paramMap) {
		return session.selectOne("mapper.order.getOrderCount", paramMap);
	}

	@Override
	public List<Order> selectDelayedOrders(Map<String, String> param) {
        return session.selectList("mapper.order.selectDelayedOrders", param);
	}

}
