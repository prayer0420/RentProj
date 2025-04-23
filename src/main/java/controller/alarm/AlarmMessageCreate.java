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
 * Servlet implementation class AlarmMessageCreate
 */
@WebServlet("/alarmMessageCreate")
public class AlarmMessageCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AlarmMessageCreate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // AlarmMessageService를 통해 DB 등록 처리
	    AlarmMessageService service = new AlarmMessageServiceImpl();
	    // 1. 요청에서 입력값 꺼내기
        String type = request.getParameter("type");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String remark = request.getParameter("remark");

        // 2. DTO 객체 생성 및 데이터 주입 
        AlarmMessage alarm = new AlarmMessage();
        alarm.setType(type);
        alarm.setTitle(title);
        alarm.setContent(content);
        alarm.setRemark(remark);

        // 3. 서비스 호출 → DB insert 시도
        boolean success = service.createMessage(alarm);

        // 4. 결과 응답 전송 (Ajax가 받을 응답)
        response.setContentType("text/plain");
        response.getWriter().write(String.valueOf(success));
    }
}
