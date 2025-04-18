package service.product;

import dto.Product;

public interface ProductService {
	void registRent(Product product) throws Exception;
	void registSell(Product product) throws Exception;
	void registRentSell(Product product) throws Exception;
	void registFree(Product product) throws Exception;

}
