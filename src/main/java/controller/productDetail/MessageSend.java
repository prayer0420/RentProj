package controller.productDetail;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Note;
import service.note.NoteService;
import service.note.NoteServiceImpl;

/**
 * Servlet implementation class MessageSend
 */
@WebServlet("/message/send")
public class MessageSend extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MessageSend() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/JSP/ProducDetail/messageModal.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		Integer productNo = Integer.parseInt(request.getParameter("productNo").trim());
//		Integer memberNo = Integer.parseInt(request.getParameter("memberNo"));
		Integer memberNo = 1;
		String noteContent = request.getParameter("noteContent");
		String receiver = request.getParameter("receiver");
		String tradeType = request.getParameter("tradeType");
		String encodedTradeType = URLEncoder.encode(tradeType,"utf-8");
		
		
		
		Note note = new Note(productNo, memberNo, noteContent, receiver);
		NoteService service = new NoteServiceImpl();
		try {
			service.insertNote(note);
			request.setAttribute("note", note);
			response.setStatus(HttpServletResponse.SC_OK); // 200 OK
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
	}

}
