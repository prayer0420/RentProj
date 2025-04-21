package dao.product;

import java.util.List;
import java.util.Map;

import dto.Product;

public interface ProductDAO {
	Product insertProductRent(Product product) throws Exception;
	Product insertProductSell(Product product) throws Exception;
	Product insertProductRentSell(Product product) throws Exception;
	Product insertProductFree(Product product) throws Exception;

	Product SelectProductOne(Integer no) throws Exception;
	
	
    List<Product> selectAll(String tradeType, String orderBy, int offset, int limit);
    List<Product> selectByName(String name, String tradeType, String orderBy, int offset, int limit);
    List<Product> selectByCategory(int categoryNo, String tradeType, String orderBy, int offset, int limit);

    int countAll(String tradeType);
    int countByName(String name, String tradeType);
    int countByCategory(int categoryNo, String tradeType);
    List<Product> selectProducts(Map<String, Object> params);
    

}
