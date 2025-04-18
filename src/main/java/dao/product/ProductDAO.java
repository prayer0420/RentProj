package dao.product;

import dto.Product;

public interface ProductDAO {
	Product insertProductRent(Product product) throws Exception;
	Product insertProductSell(Product product) throws Exception;
	Product insertProductRentSell(Product product) throws Exception;
	Product insertProductFree(Product product) throws Exception;

}
