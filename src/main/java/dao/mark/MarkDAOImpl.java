	package dao.mark;
	
	import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Mark;
import utils.MybatisSqlSessionFactory;
import utils.PageInfo;
	
	public class MarkDAOImpl implements MarkDAO {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		@Override
		public boolean existsMark(Integer memberNo,Integer productNo) throws Exception {
		    try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
		        Mark mark = new Mark();
		        mark.setMemberNo(memberNo);
		        mark.setProductNo(productNo);
		        return session.selectOne("mapper.mark.existsMark", mark);
		    }
		}
	
		@Override
		public void insertMark(Mark mark) throws Exception {
		    try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
		        session.insert("mapper.mark.insertMark", mark);
		        session.commit();
		    }
		}
	
		@Override
		public void deleteMark(Mark mark) throws Exception {
		    try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
		        session.delete("mapper.mark.deleteMark", mark);
		        session.commit();
		    }
		}
		
	    @Override
	    public List<Map<String, Object>> selectMyMarkList(Map<String, Object> param) throws Exception {
	        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	            return session.selectList("mapper.mark.selectMyMarkList", param);
	        }
	    }

	    @Override
	    public int selectMarkCount(Integer memberNo) throws Exception {
	        return session.selectOne("mapper.mark.selectMarkCount", memberNo);
	    }

		@Override
		public int countMarkProduct(Integer productNo) throws Exception {
			return session.selectOne("mapper.mark.countMarkProduct",productNo);
		}
	
	}
