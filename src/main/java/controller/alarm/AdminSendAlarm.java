package controller.alarm;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Alarm;
import service.alarm.FcmService;
import service.alarm.FcmServiceImpl;

@WebServlet("/adminSendAlarm")
public class AdminSendAlarm extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");

        String recvId = request.getParameter("recvId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        Alarm alarm = new Alarm("ADMIN", recvId, title, content, true);

        FcmService fcmService = new FcmServiceImpl();

        try {
            fcmService.sendAlarm(alarm);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}

