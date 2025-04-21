package service.note;

import dao.note.NoteDAO;
import dao.note.NoteDAOImpl;
import dto.Note;

public class NoteServiceImpl implements NoteService {
	private NoteDAO noteDAO;
	
	public NoteServiceImpl(){
		noteDAO = new NoteDAOImpl();
	}

	@Override
	public void insertNote(Note note) throws Exception {
		noteDAO.noteInsert(note);
	}

}
