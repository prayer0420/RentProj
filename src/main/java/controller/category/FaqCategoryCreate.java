package controller.category;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dto.FaqCategory;
import service.FAQ.FaqCategoryService;
import service.FAQ.FaqCategoryServiceImpl; 

/**
 * Servlet implementation class FaqCategoryCreate
 */
@WebServlet("/faqCategoryCreate")
public class FaqCategoryCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FaqCategoryCreate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	response.setContentType("application/json;charset=UTF-8");
    	
    	FaqCategoryService faqService = new FaqCategoryServiceImpl();
		
    	List<FaqCategory> list = faqService.getFaqCategoryList();
		String json = new Gson().toJson(list);
		response.getWriter().write(json);
    	
 }
    	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	response.setContentType("application/json;charset=UTF-8");

    	String name = request.getParameter("name");
		FaqCategoryService faqService = new FaqCategoryServiceImpl();

		FaqCategory result = faqService.insertFaqCategory(name);

		if (result != null) {
		    String json = "{\"success\": true, \"name\": \"" + result.getName() + "\", \"no\": " + result.getNo() + "}";
		    response.getWriter().write(json);
		} else {
		    response.getWriter().write("{\"success\": false}");
		}
    
	}

}
