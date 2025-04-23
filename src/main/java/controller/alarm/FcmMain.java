package controller.alarm;


import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Alarm;
import service.alarm.FcmService;
import service.alarm.FcmServiceImpl;

@WebServlet("/alarmList")
public class FcmMain extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FcmMain() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//임시 로그인 처리
		request.getSession().setAttribute("id", "hong");
		
		String id = (String)request.getSession().getAttribute("id");
		
		FcmService service = new FcmServiceImpl();
		try {
			List<Alarm> alarmList = service.getAlarmList(id);
			request.setAttribute("alarms", alarmList);
			request.getRequestDispatcher("fcm.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "알람목록조회 실패");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}
}