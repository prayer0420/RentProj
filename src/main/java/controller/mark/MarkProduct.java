package controller.mark;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Mark;
import dto.Member;
import dto.Product;
import service.mark.MarkService;
import service.mark.MarkServiceImpl;

/**
 * Servlet implementation class mark
 */
@WebServlet("/markProduct")
public class MarkProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MarkProduct() {
        super();
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("member");
		Product product = (Product)request.getAttribute("product");
		
		if(member == null) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
		}
		
		Integer memberNo = member.getNo();
		Integer productNo = Integer.parseInt(request.getParameter("productNo"));
		
		MarkService service = new MarkServiceImpl();
		boolean isMark;
		try {
			isMark = service.existsMark(memberNo, productNo);
			// 응답은 JSON으로 보내기
			response.setContentType("application/json");
			response.getWriter().write("{\"isMark\":" + isMark + "}");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
