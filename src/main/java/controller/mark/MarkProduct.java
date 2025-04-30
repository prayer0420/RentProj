package controller.mark;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Mark;
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
		  response.setContentType("application/json; charset=UTF-8");
	        
	        HttpSession session = request.getSession();
	        Integer memberNo = (Integer) session.getAttribute("no");
	        int productNo = Integer.parseInt(request.getParameter("productNo"));

	        if (memberNo == null) {
	            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
	            return;
	        }

	        MarkService service = new MarkServiceImpl();
	        Mark mark = new Mark();
	        mark.setMemberNo(memberNo);
	        mark.setProductNo(productNo);

	        try {
	        	boolean isMark = service.existsMark(memberNo, productNo);
	            if (isMark) {
	                service.deleteMark(mark);
	            } else {
	                service.insertMark(mark);
	            }
	            int count = service.countMarkProduct(productNo);
	            response.getWriter().write("{\"isMark\":" + !isMark + ", \"count\":" + count + "}");
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.getWriter().write("{\"error\":\"서버 오류\"}");
	        }
	    }
	}