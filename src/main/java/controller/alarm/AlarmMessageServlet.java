package controller.alarm;




import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dto.AlarmMessage;
import service.alarmList.AlarmMessageService;
import service.alarmList.AlarmMessageServiceImpl;

/**
 * Servlet implementation class AlarmMessage
 */
@WebServlet("/alarmMessage")
public class AlarmMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AlarmMessageServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // 서비스 객체 생성
	    AlarmMessageService service = new AlarmMessageServiceImpl();
	    
        // 1. 전체 알림 메시지 조회
	    List<AlarmMessage> list = service.getAllMessages();
        
        // 2. 결과를 request scope에 저장
        request.setAttribute("alarmList", list);
        
        // 3. JSP로 forward
        request.getRequestDispatcher("JSP/Admin/alarmMessage.jsp").forward(request, response);
    }


}
