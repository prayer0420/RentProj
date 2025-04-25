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
    Product selectProductOne(Integer no) throws Exception;
    
    //상품 가져오기
    List<Product> getProducts(String searchText, Integer categoryNo, String tradeType, String sort,
            PageInfo pageInfo, Double latitude, Double longitude);

    
	//페이징
    PageInfo getPageInfo(String searchText, String categoryNo, String tradeType, String sort, int page);
    //상품 목록 불러오기
    List<Category> getAllCategories();
    //메인페이지
	List<Product> getPopularProducts(int limit);
}
