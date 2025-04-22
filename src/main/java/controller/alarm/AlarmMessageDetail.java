package controller.alarm;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.alarmList.AlarmMessageService;
import service.alarmList.AlarmMessageServiceImpl;

/**
 * Servlet implementation class AlarmMessageDetail
 */
@WebServlet("/alarmMessageDetail")
public class AlarmMessageDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AlarmMessageDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 알림 메시지 단건 조회 처리 : 요청 파라미터 no (알림 번호) : 응답 형식 JSON (알림 메시지 객체)
		// 사용 위치: 리스트에서 제목 클릭 → 수정 모달 열기 시 Ajax 요청
		
		// 서비스 객체 선언
	    AlarmMessageService service = new AlarmMessageServiceImpl();
	    // 1. 요청 파라미터(no) 가져오기 → 알림 번호
		int no = Integer.parseInt(request.getParameter("no"));
		// 2. 서비스 통해 단건 조회 → DB에서 해당 알림 데이터 가져오기
        AlarmMessage alarm = service.getMessageByNo(no);
        // 3. JSON 응답 설정
        response.setContentType("application/json;charset=UTF-8");
        // 4. ObjectMapper를 사용해 alarm 객체를 JSON 문자열로 변환 후 전송
        // new ObjectMapper().writeValue(response.getWriter(), alarm);
		
		
		

	
	}

}
