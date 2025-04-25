package controller.category;



import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

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
        // 업로드 경로 설정 (webapp/upload 폴더)
        String path = request.getServletContext().getRealPath("upload");
        int size = 50 * 1024 * 1024; // 최대 파일 크기: 10MB

        // 파일 업로드 처리 (파일명 중복 시 자동 이름 변경)
        MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		
		String[] noList = multi.getParameterValues("no");
		String[] nameList = multi.getParameterValues("name");
		String[] isActiveList = multi.getParameterValues("isActive");
		String[] oldFilenameList = multi.getParameterValues("oldFilename");
		
		List<Category> categoryList = new ArrayList<>();
		
		for(int i=0; i<noList.length; i++) {
			String filename = multi.getFilesystemName("imgfilename"+i);
			if(filename==null || filename.trim().equals("")) {
				filename = oldFilenameList[i];
			}
			categoryList.add(new Category(Integer.parseInt(noList[i]),
					nameList[i],i+1,Boolean.parseBoolean(isActiveList[i]),filename));
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
