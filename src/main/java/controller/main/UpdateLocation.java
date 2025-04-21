package controller.main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Member;
import service.member.MemberService;
import service.member.MemberServiceImpl;

@WebServlet("/updateLocation")
public class UpdateLocation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdateLocation() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
          Member loginUser = (Member) req.getSession().getAttribute("member");
          if (loginUser != null) {
        	double lat = Double.parseDouble(req.getParameter("lat"));
            double lng = Double.parseDouble(req.getParameter("lng"));  
            int memberNo = loginUser.getNo();
            System.out.println(memberNo);
            MemberService service = new MemberServiceImpl();
            String address = service.updateLocationAndGetAddress(loginUser.getNo(), lat, lng);
            System.out.println(address);

            // 세션 갱신
            loginUser.setLatitude(lat);
            loginUser.setLongitude(lng);
            loginUser.setLocation(address);

            // 응답
            resp.setContentType("application/json");
            resp.getWriter().write("{\"address\":\"" + address + "\"}");
          }

          resp.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
          e.printStackTrace();
          resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
      }
}
