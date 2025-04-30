package service.note;

import java.util.List;
import dao.note.NoteDAO;
import dao.note.NoteDAOImpl;
import dto.Note;

public class NoteServiceImpl implements NoteService {
    private final NoteDAO noteDAO = new NoteDAOImpl();





    @Override
    public void sendNote(Note note) {
        noteDAO.insertNote(note);
    }

    @Override
    public List<Note> getReceivedNotes(Integer memberNo) {
        return noteDAO.selectReceivedNotes(memberNo);
    }

    @Override
    public List<Note> getSentNotes(Integer memberNo) {
        return noteDAO.selectSentNotes(memberNo);
    }

    @Override
    public void deleteNote(Integer noteNo) {
        noteDAO.deleteNote(noteNo);
    }
}