package dao.order;

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

}
