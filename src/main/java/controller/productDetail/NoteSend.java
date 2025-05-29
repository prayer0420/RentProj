package controller.productDetail;

import dto.Note;
import service.note.NoteService;
import service.note.NoteServiceImpl;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;
import java.util.Date;

@WebServlet("/noteSend")
public class NoteSend extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final NoteService noteService = new NoteServiceImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("application/json; charset=UTF-8");  // JSON 응답 타입

        HttpSession session = request.getSession(false);
        Integer senderNo = (Integer) session.getAttribute("no");

        if (senderNo == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401
            response.getWriter().write("{\"error\":\"로그인 필요\"}");
            return;
        }

        try {
            Integer receiverNo = Integer.parseInt(request.getParameter("receiverNo"));
            Integer productNo = Integer.parseInt(request.getParameter("productNo"));
            String noteContent = request.getParameter("noteContent");

            Note note = new Note();
            note.setMemberNo(senderNo);
            note.setReceiverNo(receiverNo);
            note.setProductNo(productNo);
            note.setNoteContent(noteContent);
            note.setCurdate(new Date());

            noteService.sendNote(note);

            // ✅ JSON 응답으로 성공 전달
            response.getWriter().write("{\"result\":\"success\"}");

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"쪽지 전송 실패\"}");
        }
    }

}