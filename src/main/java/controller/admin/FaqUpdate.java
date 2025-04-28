package controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import dto.Faq;
import service.FAQ.FaqService;
import service.FAQ.FaqServiceImpl;

/**
 * Servlet implementation class FaqModify
 */
@WebServlet("/faqUpdate")
public class FaqUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FaqUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // [1] 업로드 경로 및 최대 파일 크기 설정
        String savePath = request.getServletContext().getRealPath("/upload");
        int maxSize = 5 * 1024 * 1024; // 5MB

        // [2] MultipartRequest로 파일 업로드 및 파라미터 받기
        MultipartRequest multi = new MultipartRequest(
            request, 
            savePath, 
            maxSize, 
            "UTF-8", 
            new DefaultFileRenamePolicy()
        );

        // [3] form 데이터 꺼내기
        int no = Integer.parseInt(multi.getParameter("no"));
        int categoryNo = Integer.parseInt(multi.getParameter("categoryNo"));
        String title = multi.getParameter("title");
        String content = multi.getParameter("content");
        String imgUrl = multi.getFilesystemName("ifile"); // 새로 업로드된 파일명

        // 기존 이미지가 유지되어야 하는 경우
        if (imgUrl == null) {
            imgUrl = multi.getParameter("existingImage"); // 기존 이미지명 유지
        }

        // [4] DTO 객체에 데이터 설정
        Faq faq = new Faq();
        faq.setNo(no);
        faq.setCategoryNo(categoryNo);
        faq.setTitle(title);
        faq.setContent(content);
        faq.setImgUrl(imgUrl);

        // [5] Service 호출하여 DB 수정
        FaqService faqService = new FaqServiceImpl();
        boolean success = false;

        try {
            success = faqService.modifyFaq(faq);

            // 성공 여부에 따라 JSON 응답
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"success\": " + success + "}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"success\": false, \"message\": \"FAQ 수정 실패\"}");
        }
    }
}