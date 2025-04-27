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
@WebServlet("/faqModify")
public class FaqModify extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FaqModify() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		FaqService faqService = new FaqServiceImpl();
	        
        String savePath = getServletContext().getRealPath("/upload");
        int maxSize = 5 * 1024 * 1024;

        MultipartRequest multi = new MultipartRequest(
            request,
            savePath,
            maxSize,
            "UTF-8",
            new DefaultFileRenamePolicy()
        );

        int no = Integer.parseInt(multi.getParameter("no"));

        Faq faq = new Faq(); 
        faq.setNo(no);
        faq.setTitle(multi.getParameter("title"));
        faq.setContent(multi.getParameter("content"));
        faq.setCategoryNo(Integer.parseInt(multi.getParameter("categoryNo")));

        String uploadedFile = multi.getFilesystemName("faqImage");
        if (uploadedFile != null) {
            faq.setImgUrl(uploadedFile);
        }

        boolean success = faqService.modifyFaq(faq);

        Map<String, Object> result = new HashMap<>();
        result.put("success", success);

        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(new Gson().toJson(result));
    }
}