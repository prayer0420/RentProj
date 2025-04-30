package dao.rental;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Rental;
import utils.MybatisSqlSessionFactory;

public class RentalDAOImpl implements RentalDAO {
	private SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public List<Rental> selectByProductNo(int productNo) throws Exception {
		return session.selectList("mapper.rental.selectByProductNo",productNo);
	}

	@Override
	public int countRentalDate(int productNo, String startDate, String endDate) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("productNo", productNo);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		return session.selectOne("mapper.rental.countRentalDate",map);
	}

	@Override
	public void insertRental(Rental rental) throws Exception {
		session.insert("mapper.rental.insertRental",rental);
		session.commit();
	}
	
	
	

}
