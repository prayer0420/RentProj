package controller.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Faq;
import service.FAQ.FaqService;
import service.FAQ.FaqServiceImpl;

/**
 * Servlet implementation class ServiceFAQ
 */
@WebServlet("/serviceFAQ")
public class ServiceFAQ extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServiceFAQ() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
	    
	    String noParam = request.getParameter("no");
	    FaqService faqService = new FaqServiceImpl();
	    
	    try {
	        List<Faq> faqList = faqService.selectAllFaq();  // 항상 전체 리스트 가져옴 (검색/탭 기능 위해)
	        request.setAttribute("faqList", faqList);

	        if (noParam != null && !noParam.trim().isEmpty()) {
	            Integer no = Integer.parseInt(noParam);
	            request.setAttribute("filterNo", no);  // 별도로 필터링할 no만 세팅
	        }
	        
	        request.getRequestDispatcher("/JSP/Service/serviceFAQ.jsp").forward(request, response);
	        
	    } catch (Exception e) {
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
