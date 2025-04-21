package dao.grade;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.Grade;
import utils.MybatisSqlSessionFactory;

public class GradeDAOImpl implements GradeDAO {

	private SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	
	@Override
	public List<Grade> selectAllGrades() throws Exception {
		return sqlSession.selectList("mapper.grade.selectAllGrades");
	}

	@Override
	public void updateGrade(Grade grade) throws Exception {
		sqlSession.update("mapper.grade.updateGrade", grade);
		sqlSession.commit();

	}

}
