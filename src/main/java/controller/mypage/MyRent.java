package controller.mypage;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import service.mypage.MypageService;
import service.mypage.MypageServiceImpl;
import utils.PageInfo;

/**
 * Servlet implementation class MyRent
 */
@WebServlet("/myRent")
public class MyRent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyRent() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String pageStr = request.getParameter("page");
		Integer page = null;
		if(pageStr == null) {
			page = 1;
		}else {
			page = Integer.parseInt(pageStr);
		}
		PageInfo pageInfo = new PageInfo(page);
		
		HttpSession session = request.getSession(false);
		String id = (session != null)? (String) session.getAttribute("id") : null;
		
		if(id == null) {
			// 로그인하지 않은 사용자
			request.setAttribute("loginId", null);	//JSP에서 분기 처리용
			request.getRequestDispatcher("/JSP/MyPage/myRent.jsp").forward(request, response);
			return;
		}
		
		// 로그인 한 사용자
//		System.out.println("로그인ID: "+id);
		MypageService service = new MypageServiceImpl();
		try {
			List<Map<String,Object>> rentList = service.rentListByPage(pageInfo,id);
			request.setAttribute("pageInfo", pageInfo);
			request.setAttribute("rentList", rentList);
//			System.out.println(rentList);
			request.setAttribute("loginId", id);
			request.getRequestDispatcher("/JSP/MyPage/myRent.jsp").forward(request, response);
		}catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err",	"나의 빌린 상품 목록 조회를 실패했습니다.");
			request.getRequestDispatcher("/JSP/MyPage/error.jsp").forward(request, response);
		}
	}

}
