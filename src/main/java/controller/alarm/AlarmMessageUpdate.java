package controller.alarm;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.AlarmMessage;
import service.alarmList.AlarmMessageService;
import service.alarmList.AlarmMessageServiceImpl;

/**
 * Servlet implementation class AlarmMessageUpdate
 */
@WebServlet("/alarmMessageUpdate")
public class AlarmMessageUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AlarmMessageUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    AlarmMessageService service = new AlarmMessageServiceImpl();
		
        AlarmMessage alarm = new AlarmMessage();
        alarm.setNo(Integer.parseInt(request.getParameter("no")));
        alarm.setType(request.getParameter("type"));
        alarm.setTitle(request.getParameter("title"));
        alarm.setContent(request.getParameter("content"));
        alarm.setRemark(request.getParameter("remark"));

        boolean success = service.updateMessage(alarm);

        response.setContentType("text/plain");
        response.getWriter().write(String.valueOf(success));
    }
}
