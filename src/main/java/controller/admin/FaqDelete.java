package controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.FAQ.FaqService;
import service.FAQ.FaqServiceImpl;

/**
 * Servlet implementation class FaqDelete
 */
@WebServlet("/faqDelete")
public class FaqDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FaqDelete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	       try {
	            // [1] 삭제할 FAQ 번호들 받기
	            String[] noParams = request.getParameterValues("no[]");

	            // [2] 번호 파라미터 검증
	            if (noParams == null || noParams.length == 0) {
	                response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
	                response.setContentType("application/json;charset=UTF-8");
	                response.getWriter().write("{\"success\": false, \"message\": \"삭제할 FAQ가 없습니다.\"}");
	                return;
	            }

	            List<Integer> noList = new ArrayList<>();
	            for (String noStr : noParams) {
	                noList.add(Integer.parseInt(noStr));
	            }

	            // [3] 서비스 호출하여 삭제 진행
	            FaqService faqService = new FaqServiceImpl();
	            boolean success = faqService.deleteFaqList(noList);

	            // [4] 결과 응답
	            response.setContentType("application/json;charset=UTF-8");
	            if (success) {
	                response.getWriter().write("{\"success\": true}");
	            } else {
	                response.getWriter().write("{\"success\": false, \"message\": \"FAQ 삭제 실패\"}");
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
	            response.setContentType("application/json;charset=UTF-8");
	            response.getWriter().write("{\"success\": false, \"message\": \"서버 오류\"}");
	        }
	    }
	}