	package dao.mark;
	
	import org.apache.ibatis.session.SqlSession;
	
	import dto.Mark;
	import utils.MybatisSqlSessionFactory;
	
	public class MarkDAOImpl implements MarkDAO {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		@Override
		public boolean existsMark(Integer memberNo,Integer productNo) throws Exception {
			Mark mark = new Mark();
			mark.setMemberNo(memberNo);
			mark.setProductNo(productNo);
			boolean existsMark = session.selectOne("mapper.mark.existsMark",mark);
			return existsMark != false ? existsMark : false;
		}
	
		@Override
		public void insertMark(Integer memberNo,Integer productNo) throws Exception {
			Mark mark = new Mark();
			mark.setMemberNo(memberNo);
			mark.setProductNo(productNo);
			session.insert("mapper.mark.insertMark",mark);
			session.commit();
		}
	
		@Override
		public void deleteMark(Integer memberNo,Integer productNo) throws Exception {
			Mark mark = new Mark();
			mark.setMemberNo(memberNo);
			mark.setProductNo(productNo);
			session.delete("mapper.mark.deleteMark",mark);
			session.commit();
		}
	
	}
