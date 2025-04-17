<<<<<<<< HEAD:src/main/java/controller/admin/CategoryCreate.java
package controller.admin;
========
package controller.category;
>>>>>>>> dev:src/main/java/controller/category/CategoryCreate.java

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dto.Category;
import service.category.CategoryService;
import service.category.CategoryServiceImpl;

/**
 * Servlet implementation class CategoryCreate
 */
@WebServlet("/categoryCreate")
public class CategoryCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoryCreate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("categoryCreate.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String name = request.getParameter("name");
		
		try {
			CategoryService categoryService = new CategoryServiceImpl();
			Category category = new Category(name);
			categoryService.registerCategory(category);
			System.out.println(category);
			Gson gson = new Gson();
			String categoryJson = gson.toJson(category);
			response.getWriter().write(categoryJson);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
	}

}
