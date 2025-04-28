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
		FaqService faqService = new FaqServiceImpl();
		
		String[] noList = request.getParameterValues("noList[]");

        boolean success = false;
        if (noList != null) {
            int[] faqNos = new int[noList.length];
            for (int i = 0; i < noList.length; i++) {
                faqNos[i] = Integer.parseInt(noList[i]);
            }
            success = faqService.deleteFaqList(faqNos);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("success", success);

        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(new Gson().toJson(result));
    }
}