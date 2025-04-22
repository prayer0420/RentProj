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
		String sendId = request.getParameter("sendId");
		System.out.println(sendId);
		String sendName = request.getParameter("sendName");
		String recvId = request.getParameter("recvId");
		System.out.println(recvId);
		String title = request.getParameter("title");
		String body = request.getParameter("body");
		FcmService service = new FcmServiceImpl();
		try {
			service.sendAlarm(new Alarm(sendId, sendName,recvId,title,body));
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}