package dao.note;

import java.util.List;
import dto.Note;

public interface NoteDAO {
    void insertNote(Note note);
    List<Note> selectReceivedNotes(Integer memberNo);
    List<Note> selectSentNotes(Integer memberNo);
    void deleteNote(Integer noteNo);
}
