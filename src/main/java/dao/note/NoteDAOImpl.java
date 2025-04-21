package dao.note;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import dto.Note;
import dto.Review;
import utils.MybatisSqlSessionFactory;

public class NoteDAOImpl implements NoteDAO {
	SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	@Override
	public Note noteInsert(Note note) throws Exception {
		session.insert("mapper.note.insertNote",note);
		session.commit();
		return note;
	}
	@Override
	public List<Review> selelctReview(int productNo) throws Exception {
		return session.selectList("mapper.review.selectReview",productNo);
	}

}
