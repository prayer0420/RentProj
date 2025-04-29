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


        // [1] 업로드 경로 설정
        String uploadPath = request.getServletContext().getRealPath("/upload");
        int maxSize = 5 * 1024 * 1024; // 5MB
        try {
            MultipartRequest multi = new MultipartRequest(
                    request,
                    uploadPath,
                    10 * 1024 * 1024,
                    "utf-8",
                    new DefaultFileRenamePolicy()
            );

            // [2] 파라미터 수집
            String faqNoStr = multi.getParameter("faqNo");
            if (faqNoStr == null || faqNoStr.trim().isEmpty()) {
                response.getWriter().write("{\"success\": false, \"message\": \"faqNo 누락\"}");
                return;
            }

            int faqNo = Integer.parseInt(faqNoStr.trim());
            int categoryNo = Integer.parseInt(multi.getParameter("categoryNo"));
            String title = multi.getParameter("title");
            String content = multi.getParameter("content");

            // [3] 이미지 처리
            String imgUrl = multi.getFilesystemName("ifile");
            if (imgUrl == null) {
                imgUrl = multi.getParameter("existingImage"); // 기존 이미지 유지
            }

            // [4] DTO 생성
            Faq faq = new Faq();
            faq.setNo(faqNo);
            faq.setCategoryNo(categoryNo);
            faq.setTitle(title);
            faq.setContent(content);
            faq.setImgUrl(imgUrl);

            // [5] 서비스 호출
            FaqService service = new FaqServiceImpl();
            service.modifyFaq(faq);

            // [6] 성공 응답
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"success\": true}");

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"서버 오류: " + e.getMessage() + "\"}");
        }
    }
}