package controller.alarm;

import java.io.IOException;
import java.util.ArrayList;
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
 * Servlet implementation class AlarmMessageDelete
 */
@WebServlet("/alarmMessageDelete")
public class AlarmMessageDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AlarmMessageDelete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 알림 메시지 다중 삭제 처리
		// 요청 파라미터 : no[] (삭제할 번호들)
        String[] noParams = request.getParameterValues("no");
        List<Integer> noList = new ArrayList<>();

        for (String no : noParams) {
            noList.add(Integer.parseInt(no));
        }

        // 삭제 성공 여부를 문자열로 Ajax에 전송
        AlarmMessageService service = new AlarmMessageServiceImpl();
        boolean success = service.deleteMessages(noList);
        // 응답 형식 : 문자열
        response.setContentType("text/plain");
        response.getWriter().write(String.valueOf(success));
		
	}

}
