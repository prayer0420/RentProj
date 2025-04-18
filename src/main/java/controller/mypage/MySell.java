package controller.mypage;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Product;
import service.mypage.MypageService;
import service.mypage.MypageServiceImpl;
import utils.PageInfo;

/**
 * Servlet implementation class MySell
 */
@WebServlet("/mySell")
public class MySell extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MySell() {
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
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		System.out.println("로그인ID: "+id);
		MypageService service = new MypageServiceImpl();
		try {
			List<Product> productList = service.productListByPage(pageInfo,id);
			request.setAttribute("pageInfo", pageInfo);
			request.setAttribute("productList", productList);
			System.out.println(productList);
			request.getRequestDispatcher("/JSP/MyPage/mySell.jsp").forward(request, response);
		}catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err",	"나의 판매상품 목록 조회를 실패했습니다.");
			request.getRequestDispatcher("/JSP/MyPage/error.jsp").forward(request, response);
		}
		
	}
	
	

}
