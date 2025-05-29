package controller.alarm;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Alarm;
import service.alarm.FcmService;
import service.alarm.FcmServiceImpl;

@WebServlet("/alarm")
public class SendAlarm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SendAlarm() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String recvId = request.getParameter("recvId");
		System.out.println(recvId);
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String type = request.getParameter("type");
		boolean isActive = Boolean.valueOf(request.getParameter("isActive"));
		FcmService service = new FcmServiceImpl();
		try {
			service.sendAlarm(new Alarm(type,recvId,title,content,isActive));
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}