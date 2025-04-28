package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dto.Faq;
import dto.FaqCategory;
import service.FAQ.FaqCategoryService;
import service.FAQ.FaqCategoryServiceImpl;
import service.FAQ.FaqService;
import service.FAQ.FaqServiceImpl;

/**
 * Servlet implementation class Faq
 */
@WebServlet("/faq")
public class FaqList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FaqList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        FaqService faqService = new FaqServiceImpl();

        try {
            // FAQ 리스트 반환
            List<Faq> faqList = faqService.getFaqList();
            System.out.println("FAQ 데이터: " + faqList); // 로그 추가

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(new Gson().toJson(faqList));
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}