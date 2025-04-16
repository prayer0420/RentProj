package dao;

import org.apache.ibatis.session.SqlSession;

import dto.Product;
import utils.mybatisSqlSessionFactory;

public class ProductDAOImple implements ProductDAO {
	SqlSession sqlSession = mybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	@Override
	public Product insertProduct(Product product) throws Exception {
		
		
		return null;
	}

}
