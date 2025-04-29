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
		// [1] 업로드 경로 및 업로드 파일 최대 크기 설정
        String path = request.getServletContext().getRealPath("upload");
        int size = 50 * 1024 * 1024; // 최대 파일 크기: 50MB

        // [2] MultipartRequest를 사용해 파일 업로드 처리 (중복 파일명은 자동 변경)
        MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

        // [3] 전송된 form 데이터 꺼내기
        String name = multi.getParameter("name"); // 카테고리명
        String imgFilename = multi.getFilesystemName("img"); // 업로드된 이미지 파일명

        // [4] DTO 객체 생성 및 값 설정
        Category category = new Category();
        category.setName(name);
        category.setImgFilename(imgFilename);

        // [5] 서비스 호출해 DB에 저장
        try {
            CategoryService service = new CategoryServiceImpl();
            service.registerCategory(category);

            // 저장 성공 시: 카테고리 목록 페이지로 이동
            response.sendRedirect("categoryList");
        } catch (Exception e) {
            e.printStackTrace();
            // 저장 실패 시: 에러 페이지로 포워드
            request.setAttribute("errorMessage", "카테고리 등록 실패");
            request.setAttribute("returnUrl", "/categoryList"); // 돌아갈 경로
            request.getRequestDispatcher("JSP/Admin/error.jsp").forward(request, response);
        }
    }
}
