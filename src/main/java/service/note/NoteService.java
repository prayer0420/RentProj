package service.note;

import java.util.List;
import dto.Note;

public interface NoteService {
    void sendNote(Note note);
    List<Note> getReceivedNotes(Integer memberNo);
    List<Note> getSentNotes(Integer memberNo);
    void deleteNote(Integer noteNo);
}
