package controller.main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.Member;
import org.json.simple.JSONObject;
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
            // 로그인 아이디 가져오기
            String id = (String) request.getSession().getAttribute("id");

            if (id == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return;
            }

            String latStr = request.getParameter("lat");
            String lngStr = request.getParameter("lng");

            if (latStr == null || lngStr == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            Double lat = Double.parseDouble(latStr);
            Double lng = Double.parseDouble(lngStr);

            MemberService service = new MemberServiceImpl();
            Member member = service.getMemberById(id);

            String address = service.updateLocationAndGetAddress(member.getNo(), lat, lng);
            if (address == null) address = "";

            // 세션에도 저장 (원한다면)
            HttpSession session = request.getSession();
            session.setAttribute("latitude", lat);
            session.setAttribute("longitude", lng);
            session.setAttribute("location", address);

            // JSON 응답
            JSONObject json = new JSONObject();
            json.put("address", address);

            response.setContentType("application/json; charset=UTF-8");
            response.getWriter().write(json.toJSONString());
            response.setStatus(HttpServletResponse.SC_OK);

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
