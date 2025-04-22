
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.alarm.FcmService;
import service.alarm.FcmServiceImpl;


/**
 * Servlet implementation class FcmToken
 */
@WebServlet("/fcmToken")
public class FcmToken extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FcmToken() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(request.getParameter("fcmToken"));
		request.setCharacterEncoding("utf-8");
		String fcmToken = request.getParameter("fcmToken");
		System.out.println(fcmToken);
		
		try {
			HttpSession session = request.getSession();
			session.setAttribute("id", "hong"); //임시 로그인 처리
			String id = (String)session.getAttribute("id");
			FcmService service = new FcmServiceImpl();
			service.regFcmToken(id,fcmToken);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}