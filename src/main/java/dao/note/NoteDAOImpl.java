package dao.note;

import java.util.List;



import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import dto.Note;

import utils.MybatisSqlSessionFactory;

public class NoteDAOImpl implements NoteDAO {
    private final SqlSessionFactory sqlSessionFactory = MybatisSqlSessionFactory.getSqlSessionFactory();

    @Override
    public void insertNote(Note note) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            session.insert("note.insertNote", note);
            session.commit();
        }
    }

    @Override
    public List<Note> selectReceivedNotes(Integer memberNo) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectList("note.selectReceivedNotes", memberNo);
        }
    }

    @Override
    public List<Note> selectSentNotes(Integer memberNo) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectList("note.selectSentNotes", memberNo);
        }
    }

    @Override
    public void deleteNote(Integer noteNo) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            session.delete("note.deleteNote", noteNo);
            session.commit();
        }
    }
}