package dao.order;

import java.util.HashMap;
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

	@Override    
	public int hasMemberOrderProduct(Integer memberNo, Integer productNo) throws Exception {
		Map<String,Object> params = new HashMap<>();
		params.put("memberNo", memberNo);
		params.put("productNo", productNo);
		return session.selectOne("mapper.order.hasMemberOrderProduct",params);
	
	}

	@Override
	public int checkOrder(Integer productNo) throws Exception {
		return session.selectOne("mapper.order.checkOrder",productNo);
	}

	@Override
	public void updateOrderStatus(Integer orderNo,String orderStatus) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("orderNo", orderNo);
		map.put("orderStatus",orderStatus);
		session.update("mapper.order.updateOrderStatus",map);
		session.commit();
	}

}
