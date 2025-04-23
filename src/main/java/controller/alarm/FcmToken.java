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
		System.out.println(request.getParameter("fcmToken"));
		request.setCharacterEncoding("utf-8");
		String fcmToken = request.getParameter("fcmToken");
		System.out.println(fcmToken);
		
		try {
			HttpSession session = request.getSession();
			String memberId = (String)session.getAttribute("id");
			
			MemberService memberServie = new MemberServiceImpl();
	        Member member = memberServie.getMemberById(memberId);
	        
	        if (member != null) {
	            String id = member.getId();
	            FcmService service = new FcmServiceImpl();
	            service.regFcmToken(id, fcmToken);
	        } else {
	            System.out.println("해당 memberId에 해당하는 회원 없음");
	        }
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}