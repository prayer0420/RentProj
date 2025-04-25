package controller.mypage;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import service.mypage.MypageService;
import service.mypage.MypageServiceImpl;

/**
 * Servlet implementation class MyLendHistoryDetail
 */
@WebServlet("/myLendHistoryDetail")
public class MyLendHistoryDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyLendHistoryDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");
			HttpSession session = request.getSession();
			String id = (String) session.getAttribute("id");
			
			if(id == null) {
				// 로그인하지 않은 사용자: 로그인 페이지로 리다이렉트
				response.sendRedirect(request.getContextPath() + "/JSP/Login/login.jsp");
				
			}
			
			try {
				Integer orderNo = Integer.parseInt(request.getParameter("orderNo"));
				
				MypageService service = new MypageServiceImpl();
				Map<String, Object> lendDetail;
				
				lendDetail = service.getLendDetailByOrderNo(id, orderNo);	// orderNo로 상세내역 조회
				
				if(lendDetail == null) {
					request.setAttribute("err", "해당 내역을 조회할 수 없습니다");
					request.getRequestDispatcher("/JSP/MyPage/error.jsp").forward(request, response);
					return;
				}
				
				response.setContentType("application/json; charset=UTF-8");

				Gson gson = new Gson();
				String json = gson.toJson(lendDetail);
				
				response.getWriter().write(json);
				
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("err", "대여이력 상세내역 조회시 오류가 발생했습니다.");
				request.getRequestDispatcher("/JSP/MyPage/error.jsp").forward(request, response);
			} 
	}

}
