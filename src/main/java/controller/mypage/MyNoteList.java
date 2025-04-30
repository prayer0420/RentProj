package controller.mypage;


import dto.Note;
import service.note.NoteService;
import service.note.NoteServiceImpl;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/myNoteList")
public class MyNoteList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final NoteService noteService = new NoteServiceImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession(false);
		Integer memberNo = (Integer) session.getAttribute("no");

		if (memberNo == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		try {
			List<Note> receivedNotes = noteService.getReceivedNotes(memberNo);
			List<Note> sentNotes = noteService.getSentNotes(memberNo);

			request.setAttribute("receivedNotes", receivedNotes);
			request.setAttribute("sentNotes", sentNotes);

			request.getRequestDispatcher("/JSP/MyPage/myNoteList.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/error.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] noteIds = request.getParameterValues("noteIds");

		HttpSession session = request.getSession(false);
		Integer memberNo = (Integer) session.getAttribute("no");

		if (noteIds != null && memberNo != null) {
			for (String id : noteIds) {
				int noteId = Integer.parseInt(id);
				noteService.deleteNote(noteId);
			}
		}

		response.sendRedirect(request.getContextPath() + "/myNoteList");
	}
}