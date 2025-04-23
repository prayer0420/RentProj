package controller.main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String id = (String) request.getSession().getAttribute("id");

            String latStr = request.getParameter("lat");
            String lngStr = request.getParameter("lng");

            Double lat = Double.parseDouble(latStr);
            Double lng = Double.parseDouble(lngStr);

            MemberService service = new MemberServiceImpl();
            Member member = service.getMemberById(id); // DB에서 다시 가져옴

            String address = service.updateLocationAndGetAddress(member.getNo(), lat, lng);

            // 세션 갱신
            HttpSession session = request.getSession();
            session.setAttribute("latitude", lat);
            session.setAttribute("longitude", lng);
            session.setAttribute("location", address);

            response.setContentType("application/json");
            response.getWriter().write("{\"address\":\"" + address + "\"}");
            response.setStatus(HttpServletResponse.SC_OK);

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
