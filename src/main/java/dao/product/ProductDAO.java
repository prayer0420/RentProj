package dao.product;

import java.util.List;
import java.util.Map;

import dto.Product;

public interface ProductDAO {
	//상품등록
	Product insertProductRent(Product product) throws Exception;
	Product insertProductSell(Product product) throws Exception;
	Product insertProductRentSell(Product product) throws Exception;
	Product insertProductFree(Product product) throws Exception;

	Product SelectProductOne(Integer no) throws Exception;
	
	// 전체 상품 조회
    List<Product> selectAll(); 
	
	//상품 목록 불러오기
	List<Product> selectProducts(Map<String, Object> params);

	//페이징 정보
    int countAll(String tradeType);
    int countByName(String name, String tradeType);
    int countByCategory(int categoryNo, String tradeType);
    

    //메인페이지
    List<Product> selectPopularProducts(int limit);
    
    //거리에 따른 상품조회
    List<Product> selectNearbyProducts(double lat, double lng, int limit);
    
    void incrementViewCount(int no) throws Exception;
    
    int selectViewCount(int no) throws Exception;

    String selectSellerIdByProductNo(int productNo);

}
