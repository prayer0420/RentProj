package controller.category;



import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Category;
import service.category.CategoryService;
import service.category.CategoryServiceImpl;

/**
 * Servlet implementation class CategoryUpdate
 */
@WebServlet("/categoryUpdate")
public class CategoryUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoryUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String[] noList = request.getParameterValues("no");
		String[] nameList = request.getParameterValues("name");
		String[] isActiveList = request.getParameterValues("isActive");
		
		List<Category> categoryList = new ArrayList<>();
		
		for(int i=0; i<noList.length; i++) {
			categoryList.add(new Category(Integer.parseInt(noList[i]),
					nameList[i],i+1,Boolean.parseBoolean(isActiveList[i])));
		}
		
		try {
			CategoryService categoryService = new CategoryServiceImpl();
			categoryService.categoryUpdate(categoryList);
			response.sendRedirect("categoryList");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
