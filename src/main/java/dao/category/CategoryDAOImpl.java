package dao.category;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.Category;
import utils.MybatisSqlSessionFactory;

public class CategoryDAOImpl implements CategoryDAO {

	private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	
	@Override
	public List<Category> selectCategoryList() throws Exception {
        List<Category> category = sqlSession.selectList("mapper.category.selectCategoryList");
        return category;
	}



	@Override
	public void updateCategory(Category category) throws Exception {
		sqlSession.update("mapper.category.updateCategory", category);
		sqlSession.commit();
	}



	@Override
	public void insertCategory(Category category) throws Exception {
		sqlSession.insert("mapper.category.insertCategory", category);
		sqlSession.commit();
	}



	@Override
	public Integer categoryMaxNo() throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            Integer result = session.selectOne("mapper.category.categoryMaxNo");
            return (result != null) ? result : 0; // null이면 0으로 대체
        }
		
	}
}
