package controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.AnnounceService;
import service.AnnounceServiceImpl;

/**
 * Servlet implementation class AnnounceDelete
 */
@WebServlet("/announceDelete")
public class AnnounceDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnnounceDelete() {
        super();
    }

    // POST 방식으로 공지사항 삭제 처리
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
            // 번호 목록을 받아오기
            String[] noParams = request.getParameterValues("no[]");

            // noParams가 null 또는 빈 값일 경우 처리
            if (noParams == null || noParams.length == 0) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
                response.getWriter().write("{\"success\": false, \"message\": \"삭제할 공지사항 번호가 없습니다.\"}");
                return;
            }

            // 번호 목록을 List로 변환
            List<Integer> noList = new ArrayList<>();
            for (String no : noParams) {
                noList.add(Integer.parseInt(no));
            }

            // 서비스 객체를 통해 공지사항 삭제
            AnnounceService service = new AnnounceServiceImpl();
            boolean success = service.deleteAnnounces(noList);

            // 결과 응답 전송
            response.setContentType("application/json");
            if (success) {
                response.setStatus(HttpServletResponse.SC_OK); // 200 OK
                response.getWriter().write("{\"success\": true}");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
                response.getWriter().write("{\"success\": false, \"message\": \"삭제 실패\"}");
            }
        } catch (Exception e) {
            // 예외 발생 시 로그 출력 및 오류 메시지 반환
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
            response.getWriter().write("{\"success\": false, \"message\": \"서버 오류\"}");
        }
    }
}