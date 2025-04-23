package controller.alarm;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.alarm.FcmService;
import service.alarm.FcmServiceImpl;


@WebServlet("/alarmConfirm")
public class AlarmConfirm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AlarmConfirm() {
        super();
    }


protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		Integer no = Integer.parseInt(request.getParameter("no"));
		try {
			FcmService service = new FcmServiceImpl();
			service.confirmAlarm(no);
			response.getWriter().write("true");
		}catch(Exception e) {
			e.printStackTrace();
			response.getWriter().write("false");
		}
	}
}