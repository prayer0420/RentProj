package controller.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Announce;
import service.announce.AnnounceService;
import service.announce.AnnounceServiceImpl;

/**
 * Servlet implementation class ServiceAnnounce
 */
@WebServlet("/serviceAnnounce")
public class ServiceAnnounce extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServiceAnnounce() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		Integer no = Integer.parseInt(request.getParameter("no"));
		System.out.println(no);
		
		AnnounceService service = new AnnounceServiceImpl();
		try {
			Announce announce = service.announceSelectOne(no);
			
			request.setAttribute("announce", announce);
			System.out.println("Announce: " + announce);
			request.getRequestDispatcher("/JSP/Service/serviceAnnounce.jsp").forward(request, response);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
