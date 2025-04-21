package dao.note;

import java.util.List;

import dto.Note;
import dto.Review;

public interface NoteDAO {
	Note noteInsert(Note note) throws Exception;	
	List<Review> selelctReview(int productNo) throws Exception;

}
