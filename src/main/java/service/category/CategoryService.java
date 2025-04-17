package service.category;

import java.util.List;

import dto.Category;

public interface CategoryService {
    List<Category> getAllCategories() throws Exception;
    void categoryUpdate(List<Category> categoryList) throws Exception;
    void registerCategory(Category category) throws Exception;
}
