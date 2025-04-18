package service.product;

import dao.product.ProductDAO;
import dao.product.ProductDAOImpl;
import dto.Product;

public class ProductServiceImpl implements ProductService {
	private ProductDAO productDao;
	
	public ProductServiceImpl() {
		productDao = new ProductDAOImpl();
	}
	@Override
	public void registRent(Product product) throws Exception {
		productDao.insertProductRent(product);
	}
	@Override
	public void registSell(Product product) throws Exception {
		productDao.insertProductSell(product);
	}
	@Override
	public void registRentSell(Product product) throws Exception {
		productDao.insertProductRentSell(product);
	}

}
