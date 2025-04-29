package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dto.Announce;
import service.announce.AnnounceService;
import service.announce.AnnounceServiceImpl;

/**
 * Servlet implementation class AnnounceDetail
 */
@WebServlet("/announceDetail")
public class AnnounceDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnnounceDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            
            request.setCharacterEncoding("UTF-8");
            response.setContentType("application/json; charset=UTF-8");
		// 요청 파라미터로 전달된 공지사항 번호
        int no = Integer.parseInt(request.getParameter("no"));
        
        // 서비스 객체 생성 및 공지사항 조회
        AnnounceService service = new AnnounceServiceImpl();
        Announce announce = service.getAnnounceByNo(no);
        
        // 공지사항 데이터를 JSON 형태로 반환
        response.setContentType("application/json");
        response.getWriter().write(new Gson().toJson(announce));
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
            response.getWriter().write("{\"success\": false, \"message\": \"서버 오류\"}");
        }
	}
	}