package service;

import dao.ProductDAO;
import dao.ProductDAOImpl;
import dto.Product;

public class ProductServiceImpl implements ProductService {
	private ProductDAO productDao;
	
	public ProductServiceImpl() {
		productDao = new ProductDAOImpl();
	}
	@Override
	public void registRent(Product product) throws Exception {
		productDao.insertProduct(product);
	}

}
