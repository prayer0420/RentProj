package dao.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	//검색 관련
	 @Override
	    public List<Product> selectAll(String tradeType, String orderBy, int offset, int limit) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("tradeType", tradeType);
	        params.put("orderBy", orderBy);
	        params.put("offset", offset);
	        params.put("limit", limit);
	        return sqlSession.selectList("mapper.product.selectAll", params);
	    }

	    @Override
	    public List<Product> selectByName(String name, String tradeType, String orderBy, int offset, int limit) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("name", name);
	        params.put("tradeType", tradeType);
	        params.put("orderBy", orderBy);
	        params.put("offset", offset);
	        params.put("limit", limit);
	        return sqlSession.selectList("mapper.product.selectByName", params);
	    }

	    @Override
	    public List<Product> selectByCategory(int categoryNo, String tradeType, String orderBy, int offset, int limit) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("categoryNo", categoryNo);
	        params.put("tradeType", tradeType);
	        params.put("orderBy", orderBy);
	        params.put("offset", offset);
	        params.put("limit", limit);
	        return sqlSession.selectList("mapper.product.selectByCategory", params);
	    }

	    @Override
	    public int countAll(String tradeType) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("tradeType", tradeType);
	        return sqlSession.selectOne("mapper.product.countAll", params);
	    }

	    @Override
	    public int countByName(String name, String tradeType) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("name", name);
	        params.put("tradeType", tradeType);
	        return sqlSession.selectOne("mapper.product.countByName", params);
	    }

	    @Override
	    public int countByCategory(int categoryNo, String tradeType) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("categoryNo", categoryNo);
	        params.put("tradeType", tradeType);
	        return sqlSession.selectOne("mapper.product.countByCategory", params);
	    }
	    
	    @Override
	    public List<Product> selectProducts(Map<String, Object> params) {
	        return sqlSession.selectList("mapper.product.selectProducts", params);
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

	@Override
	public Product insertProductFree(Product product) throws Exception {
		sqlSession.insert("mapper.product.insertProductFree",product);
		sqlSession.commit();
		return product;
	}

}
