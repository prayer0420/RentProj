package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dto.Announce;
import service.AnnounceService;
import service.AnnounceServiceImpl;

/**
 * Servlet implementation class AnnounceList
 */
@WebServlet("/announceList")
public class AnnounceList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnnounceList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            AnnounceService service = new AnnounceServiceImpl();
            List<Announce> announceList = service.getAllAnnounces();

            if ("json".equals(request.getParameter("format"))) {
                response.setContentType("application/json");
                response.getWriter().write(new Gson().toJson(announceList));
            } else {
                request.setAttribute("announceList", announceList);
                request.getRequestDispatcher("JSP/Admin/announceList.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace(); 
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); 
            response.getWriter().write("{\"success\": false, \"message\": \"서버 오류\"}");
        }
    }
}