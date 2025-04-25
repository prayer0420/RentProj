package controller.category;



import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.FaqCategory;
import service.FAQ.FaqService;
import service.FAQ.FaqServiceImpl;

/**
 * Servlet implementation class FaqCategory
 */
@WebServlet("/faqCategory")
public class FaqCategoryList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FaqCategoryList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");	
		
		// Service 생성
			FaqService faqService = new FaqServiceImpl();   
		
	        // 1. 카테고리 목록 조회
	        List<FaqCategory> list = faqService.getFaqCategoryList();

	        // 2. request에 담기
	        request.setAttribute("faqCategoryList", list);

	        // 3. JSP로 포워딩
	        request.getRequestDispatcher("JSP/Admin/faqCategory.jsp").forward(request, response);
	    }



}