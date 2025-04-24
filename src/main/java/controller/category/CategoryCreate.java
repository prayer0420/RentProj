package controller.category;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 업로드 경로 설정 (webapp/upload 폴더)
        String path = request.getServletContext().getRealPath("upload");
        int size = 50 * 1024 * 1024; // 최대 파일 크기: 10MB

        // 파일 업로드 처리 (파일명 중복 시 자동 이름 변경)
        MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

        // form 데이터 파라미터 추출
        String name = multi.getParameter("name"); // 카테고리명
        String imgFilename = multi.getFilesystemName("img"); // 업로드된 이미지 파일명

        // DTO 객체 생성
        Category category = new Category();
        category.setName(name);
        category.setImgFilename(imgFilename);

        // 서비스 호출하여 DB에 등록
        try {
            CategoryService service = new CategoryServiceImpl();
            service.registerCategory(category);

            // 클라이언트에게 JSON 또는 단순 텍스트로 응답 가능
            response.setContentType("application/json; charset=utf-8");
            response.getWriter().write("success");
//            response.getWriter().write("{\"status\":\"success\"}");
            
            response.sendRedirect("categoryList");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\", \"message\":\"카테고리 등록 실패\"}");
        }
    }
}
