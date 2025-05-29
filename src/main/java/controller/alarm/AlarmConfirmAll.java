package controller.alarm;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Member;
import service.alarm.FcmService;
import service.alarm.FcmServiceImpl;
import service.member.MemberService;
import service.member.MemberServiceImpl;

@WebServlet("/alarmConfirmAll")
public class AlarmConfirmAll extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AlarmConfirmAll() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sessionId = (String) request.getSession().getAttribute("id");
		MemberService memberServcie = new MemberServiceImpl();
		Member member = null;
		try {
			member = memberServcie.getMemberById(sessionId);
		} catch (Exception e1) {
			e1.printStackTrace();
		}

		boolean result = false;
		if (member != null) {
			FcmService fcmService = new FcmServiceImpl();
			try {
				fcmService.confirmAllAlarms(sessionId);
				result = true;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		response.setContentType("text/plain");
		response.getWriter().write(String.valueOf(result));
	}

}
