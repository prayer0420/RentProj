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

        HttpSession session = request.getSession(false);
        Integer senderNo = (Integer) session.getAttribute("no");

        if (senderNo == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            Integer receiverNo = Integer.parseInt(request.getParameter("receiverNo"));
            Integer productNo = Integer.parseInt(request.getParameter("productNo"));
            String noteContent = request.getParameter("noteContent");
            String origin = request.getParameter("origin"); // 출처 파악

            Note note = new Note();
            note.setMemberNo(senderNo);       // 보내는 사람
            note.setReceiverNo(receiverNo);   // 받는 사람
            note.setProductNo(productNo);
            note.setNoteContent(noteContent);
            note.setCurdate(new Date());

            noteService.sendNote(note);

            // 출처에 따라 리다이렉트
            if ("productDetail".equals(origin)) {
                response.sendRedirect(request.getContextPath() + "/productDetail?no=" + productNo);
            } else if ("myNoteList".equals(origin)) {
                response.sendRedirect(request.getContextPath() + "/myNoteList");
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}
