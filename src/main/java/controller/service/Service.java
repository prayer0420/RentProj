package controller.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Announce;
import dto.Faq;
import service.FAQ.FaqService;
import service.FAQ.FaqServiceImpl;
import service.announce.AnnounceService;
import service.announce.AnnounceServiceImpl;

/**
 * Servlet implementation class Service
 */
@WebServlet("/service")
public class Service extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Service() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		FaqService faqService = new FaqServiceImpl();
		AnnounceService announceService = new AnnounceServiceImpl();
		
		try {
			List<Faq> faqList = faqService.selectAllFaq();
			List<Announce> announceList = announceService.announceSelectAll();
			request.setAttribute("faqList", faqList);
			request.setAttribute("announceList",announceList);
			request.getRequestDispatcher("/JSP/Service/service.jsp").forward(request, response);
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
