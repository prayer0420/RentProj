package controller.login;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Alarm;
import dto.Member;
import service.alarm.FcmServiceImpl;
import service.member.MemberService;
import service.member.MemberServiceImpl;

@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Login() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/JSP/Login/login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String type = request.getParameter("type");
		String latStr = request.getParameter("latitude");
		String lngStr = request.getParameter("longitude");
		
		Double lat = null, lng = null;

		try {
			if (latStr != null && !latStr.trim().isEmpty()) {
				lat = Double.parseDouble(latStr);
			}
			if (lngStr != null && !lngStr.trim().isEmpty()) {
				lng = Double.parseDouble(lngStr);
			}
		} catch (NumberFormatException e) {
			System.out.println("위도/경도 파싱 실패: " + e.getMessage());
		}

		MemberService service = new MemberServiceImpl();

		try {
			Member member = service.login(id, password);

			HttpSession session = request.getSession();
			session.setAttribute("no", member.getNo());
			session.setAttribute("id", member.getId());
			session.setAttribute("nickname", member.getNickname());
			session.setAttribute("address1", member.getAddress1());
			session.setAttribute("address2", member.getAddress2());//null일 수 있음
			session.setAttribute("address3", member.getAddress3());//null일 수 있음
			session.setAttribute("phone",member.getPhone());
			session.setAttribute("id", id);
			session.setAttribute("nickname", password);
			session.setAttribute("latitude", lat);  // null일 수도 있음
			session.setAttribute("longitude", lng); // null일 수도 있음
			
			//로그인시 알림리스트 세션에 저장
			List<Alarm> alarmList = new FcmServiceImpl().getAlarmList(id);
			session.setAttribute("alarms", alarmList); //헤더에서 사용
			System.out.println("로그인 성공: memberId = " + id);

			// 자동 로그인 쿠키 설정
			Cookie cookie1 = new Cookie("type", type != null ? type : "");
			Cookie cookie2 = new Cookie("id", id != null ? id : "");
			Cookie cookie3 = new Cookie("password", password != null ? password : "");

			response.addCookie(cookie1);
			response.addCookie(cookie2);
			response.addCookie(cookie3);

			// 로그인 성공 후 메인 페이지로 이동
			response.sendRedirect("main");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "로그인에 실패했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}
}
