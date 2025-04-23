package controller.alarm;


import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Alarm;
import dto.Member;
import service.alarm.FcmService;
import service.alarm.FcmServiceImpl;

@WebServlet("/alarmList")
public class AlarmList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AlarmList() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Member member = (Member)request.getSession().getAttribute("member");
		System.out.println("알림받은 member:"+ member);
		String id = member.getId();
		System.out.println("알림받은 id:"+ id);
		FcmService service = new FcmServiceImpl();
		try {
			List<Alarm> alarmList = service.getAlarmList(id);
			request.setAttribute("alarms", alarmList);
			request.getRequestDispatcher("/JSP/Header/alarm.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "알람목록조회 실패");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}
}