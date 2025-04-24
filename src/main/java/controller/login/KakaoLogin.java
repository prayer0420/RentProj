package controller.login;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Alarm;
import dto.LoginResult;
import dto.Member;
import service.alarm.FcmServiceImpl;
import service.member.MemberService;
import service.member.MemberServiceImpl;

@WebServlet("/kakao")
public class KakaoLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public KakaoLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String code =  request.getParameter("code");
		MemberService service = new MemberServiceImpl();
		try {
			HttpSession session = request.getSession();
            LoginResult result = service.KakaoLogin(code);
            //소셜로그인 회원정보 등록
            session.setAttribute("id", result.getMember().getId());
            System.out.println("카카오 로그인 성공: memberId = " + result.getMember().getId());

			//최초 로그인인지 확인 용
            if (result.isFirstLogin()) {
                session.setAttribute("firstLogin", true);
            }			
			
			//알림을 로그인에서 각각?
			 List<Alarm> alarmList = new FcmServiceImpl().getAlarmList(result.getMember().getId());
			 session.setAttribute("alarms", alarmList); //헤더에서 사용

			response.sendRedirect("main");
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "로그인에 실패했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		System.out.println(code);
	}


}
