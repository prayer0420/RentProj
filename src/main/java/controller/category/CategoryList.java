package controller.category;



import java.io.IOException;
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
 * Servlet implementation class CategoryList
 */
@WebServlet("/categoryList")
public class CategoryList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoryList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			CategoryService categoryService = new CategoryServiceImpl();
			List<Category> categoryList = categoryService.getAllCategories();
			System.out.println(categoryList);
			request.setAttribute("categoryList", categoryList);
			request.getRequestDispatcher("JSP/Admin/categoryCreate.jsp").forward(request, response);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}


}
