package dao.product;

import org.apache.ibatis.session.SqlSession;

import dto.Product;
import utils.MybatisSqlSessionFactory;

public class ProductDAOImpl implements ProductDAO {
	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	
	@Override
	public Product insertProductRent(Product product) throws Exception {
		sqlSession.insert("mapper.product.insertProductRent",product);
		sqlSession.commit();
		
		return product;
	}

	@Override
	public Product insertProductSell(Product product) throws Exception {
		sqlSession.insert("mapper.product.insertProductSell",product);
		sqlSession.commit();
		return product;
	}

	@Override
	public Product insertProductRentSell(Product product) throws Exception {
		sqlSession.insert("mapper.product.insertProductRentSell",product);
		sqlSession.commit();
		return product;
	}

}
