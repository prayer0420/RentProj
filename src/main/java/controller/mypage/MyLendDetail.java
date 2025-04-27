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

import dto.Order;
import service.mypage.MypageService;
import service.mypage.MypageServiceImpl;

/**
 * Servlet implementation class MyLendDetail
 */
@WebServlet("/myLendDetail")
public class MyLendDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyLendDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		if(id == null) {
			// 로그인하지 않은 사용자: 로그인 페이지로 리다이렉트
			response.sendRedirect(request.getContextPath() + "/JSP/Login/login.jsp");
			return;
		}
		
		try {
			Integer orderNo = Integer.parseInt(request.getParameter("orderNo"));
			
			MypageService service = new MypageServiceImpl();
			Map<String, Object> myLendDetail = service.myLendDetail(orderNo, id);
			
			if(myLendDetail == null) {
				request.setAttribute("err", "해당 내역을 조회할 수 없습니다");
				request.getRequestDispatcher("/JSP/MyPage/error.jsp").forward(request, response);
				return;
			}
			
			Integer productNo = (Integer) myLendDetail.get("productNo");	//대여이력을 불러오기 위한 상품번호 추출
			List<Order> lendHistoryList = service.getLendHistoryByProductNo(productNo);	// 대여이력
			request.setAttribute("myLendDetail", myLendDetail);
			request.setAttribute("lendHistoryList", lendHistoryList);
			request.getRequestDispatcher("/JSP/MyPage/myLendDetail.jsp").forward(request, response);
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("err", "빌리기 거래 상세내역 조회시 오류가 발생했습니다.");
			request.getRequestDispatcher("/JSP/MyPage/error.jsp").forward(request, response);
		}
	}

}
