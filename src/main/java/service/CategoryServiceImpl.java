package service;

import java.util.List;

import dao.CategoryDAO;
import dao.CategoryDAOImpl;
import dto.Category;

public class CategoryServiceImpl implements CategoryService {
	private CategoryDAO categoryDAO;
	
	public CategoryServiceImpl() {
		categoryDAO = new CategoryDAOImpl();
	}

	@Override
	public List<Category> getAllCategories() throws Exception {
		
		return categoryDAO.selectCategoryList();
	}

	@Override
	public void registerCategory(Category category) throws Exception {
		category.setSortOrder(categoryDAO.categoryMaxNo()+1);
		categoryDAO.insertCategory(category);
		
	}

	@Override
	public void categoryUpdate(List<Category> categoryList) throws Exception {
		for(Category category : categoryList) {
			categoryDAO.updateCategory(category);
		}
	}

}
