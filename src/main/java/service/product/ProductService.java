package service.product;

import java.util.List;

import dto.Category;
import dto.Product;
import utils.PageInfo;

public interface ProductService {
	void registRent(Product product) throws Exception;
	void registSell(Product product) throws Exception;
	void registRentSell(Product product) throws Exception;
	void registFree(Product product) throws Exception;
	
	List<Product> getAll(String tradeType, String sort, int page);
    List<Product> searchByName(String name, String tradeType, String sort, int page);
    List<Product> searchByCategory(int categoryNo, String tradeType, String sort, int page);
    
    Product selectProductOne(Integer no) throws Exception;
    
	//페이징
    PageInfo getPageInfo(String searchText, String categoryNo, String tradeType, String sort, int page);
    //상품 목록 불러오기
    List<Category> getAllCategories();
    List<Product> getProducts(String searchText,Integer categoryNo,String tradeType,String sort,PageInfo pageInfo);
    //메인페이지
	List<Product> getPopularProducts(int limit);
	//근처상품
    public List<Product> getProductsNearby(double userLat, double userLng, double radiusKm);
}
