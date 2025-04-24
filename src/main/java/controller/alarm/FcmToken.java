package controller.alarm;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import service.alarm.FcmService;
import service.alarm.FcmServiceImpl;
import service.member.MemberService;
import service.member.MemberServiceImpl;

@WebServlet("/fcmToken")
public class FcmToken extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FcmToken() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		String fcmToken = request.getParameter("fcmToken");
		
		try {
			HttpSession session = request.getSession();
			String memberId = (String)session.getAttribute("id");
			
			Boolean firstLogin = (Boolean) session.getAttribute("firstLogin");
			
			MemberService memberServie = new MemberServiceImpl();
	        Member member = memberServie.getMemberById(memberId);
	        FcmService fcmService = new FcmServiceImpl();
	        
	        if (member != null) {
	            String id = member.getId();
	            fcmService.regFcmToken(id, fcmToken); //토큰 저장
	            
	            //최초 로그인인 경우에만 서버가 알림을 전송
	            if (Boolean.TRUE.equals(firstLogin)) {
	            	System.out.println("fcmtoken"+firstLogin);
	                //회원가입 알림 전송
	            	fcmService.sendSignupAlarm(id); 
	                //전송 후 세션에서 최초로그인 플래그 제거
	            	firstLogin = false;
	                request.getSession().removeAttribute("firstLogin"); //
	              }
	        } else {
	            System.out.println("해당 memberId에 해당하는 회원 없음");
	        }
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}