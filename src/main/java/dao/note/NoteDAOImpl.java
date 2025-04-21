package dao.note;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import dto.Note;
import utils.MybatisSqlSessionFactory;

public class NoteDAOImpl implements NoteDAO {
	SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	@Override
	public Note noteInsert(Note note) throws Exception {
		session.insert("mapper.note.insertNote",note);
		session.commit();
		return note;
	}

}
