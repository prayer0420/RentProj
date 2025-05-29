package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.Faq;
import dto.FaqCategory;
import service.FAQ.FaqCategoryService;
import service.FAQ.FaqCategoryServiceImpl;
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
        FaqService faqService = new FaqServiceImpl();
        FaqCategoryService faqCategoryService = new FaqCategoryServiceImpl(); // 카테고리 서비스 추가
    	
    	try {
    		List<FaqCategory> categoryList = faqCategoryService.getFaqCategoryList();
    		request.setAttribute("categoryList", categoryList);
    		List<Faq> faqList = faqService.getFaqList();
    		request.setAttribute("faqList", faqList);
            // [GET] 요청이면 JSP로 이동
            request.getRequestDispatcher("JSP/Admin/faqCreate.jsp").forward(request, response);
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    }
    

    @Override
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
        int categoryNo = Integer.parseInt(multi.getParameter("categoryNo"));
        String title = multi.getParameter("title");
        String content = multi.getParameter("content");
        String imgUrl = multi.getFilesystemName("ifile"); // 업로드된 파일명

        // [4] DTO 객체에 데이터 설정
        Faq faq = new Faq();
        faq.setCategoryNo(categoryNo);
        faq.setTitle(title);
        faq.setContent(content);
        faq.setImgUrl(imgUrl);

        // [5] Service 호출하여 DB 저장
        FaqService faqService = new FaqServiceImpl();
        boolean success = false;

        try {
            success = faqService.registerFaq(faq);
            response.sendRedirect("faqCreate");
            // 성공 여부에 따라 JSON 응답
        } catch (Exception e) {
        }
    }
}