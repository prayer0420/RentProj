package dao.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Product;
import utils.MybatisSqlSessionFactory;

public class ProductDAOImpl implements ProductDAO {
	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	//상품등록
	@Override
	public Product insertProductRent(Product product) throws Exception {
		sqlSession.insert("mapper.product.insertProductRent", product);
		sqlSession.commit();

		return product;
	}
	@Override
	public Product insertProductSell(Product product) throws Exception {
		sqlSession.insert("mapper.product.insertProductSell", product);
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
	
	
	//전체 상품 조회
	 @Override
	    public List<Product> selectAll() {
	        return sqlSession.selectList("mapper.product.selectAll");
	    }
	
	//상품 가져오기
	@Override
	public List<Product> selectProducts(Map<String, Object> params) {
		return sqlSession.selectList("mapper.product.selectProducts", params);
	}
	
	//상품수에 따른 페이징 정보
	@Override
	public int countAll(String tradeType) {
		Map<String, Object> params = new HashMap<>();
		params.put("tradeType", tradeType);
		return sqlSession.selectOne("mapper.product.countAll", params);
	}

	@Override

	public Product SelectProductOne(Integer no) throws Exception {
		return sqlSession.selectOne("mapper.product.selectProductOne",no);
		
	}


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
	
	//메인페이지(추천상품,내동네상품)
	@Override
	public List<Product> selectPopularProducts(int limit) {
		return sqlSession.selectList("mapper.product.selectPopularProducts", limit);
	}
}
