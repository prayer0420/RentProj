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
 * Servlet implementation class FaqCreate
 */
@WebServlet("/faqCreate")
public class FaqCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FaqCreate() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //GET 요청은 jsp 페이지로 이동만
        request.getRequestDispatcher("JSP/Admin/faqCreate.jsp").forward(request, response);
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		FaqService faqService = new FaqServiceImpl();
		
        String savePath = getServletContext().getRealPath("/upload");
        int maxSize = 5 * 1024 * 1024; // 최대 5MB
        
        MultipartRequest multi = new MultipartRequest(
            request,
            savePath,
            maxSize,
            "UTF-8",
            new DefaultFileRenamePolicy()
        );

        // 받은 데이터
        int categoryNo = Integer.parseInt(multi.getParameter("categoryNo"));
        String title = multi.getParameter("title");
        String content = multi.getParameter("content");
        String imgUrl = multi.getFilesystemName("faqImage"); // 업로드된 파일 이름

        // DTO 세팅
        Faq faq = new Faq();
        faq.setCategoryNo(categoryNo);
        faq.setTitle(title);
        faq.setContent(content);
        faq.setImgUrl(imgUrl);

        // 등록
        boolean success = faqService.registerFaq(faq);

        // 결과 응답 (JSON)
        Map<String, Object> result = new HashMap<>();
        result.put("success", success);
        result.put("faq", faq);

        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(new Gson().toJson(result));
    }
}