package dao.category;

import java.util.List;

import dto.Category;

public interface CategoryDAO {
    List<Category> selectCategoryList() throws Exception;
    void updateCategory(Category category) throws Exception;
    void insertCategory(Category category)  throws Exception;
    Integer categoryMaxNo() throws Exception;

}
