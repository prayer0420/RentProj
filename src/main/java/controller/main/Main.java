package controller.main;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Member;
import dto.Product;
import service.product.ProductService;
import service.product.ProductServiceImpl;

@WebServlet("/main")
public class Main extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Main() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ProductService productService = new ProductServiceImpl();

		// 로그인한 사용자 정보에서 위도/경도 가져오기
		Member loginUser = (Member) request.getSession().getAttribute("member");
		System.out.println("세션 member: " + loginUser);
		Double lat = null, lng = null;
		if (loginUser != null) {
		    lat = loginUser.getLatitude();
		    lng = loginUser.getLongitude();
		    System.out.println("로그인한 유저의 정보를 불러옵니다.");
		} else {
		    // 비로그인 상태일 경우 처리 (예: 기본값 처리 or 리디렉션)
		    System.out.println("로그인한 유저가 없습니다.");
		}

		// 1. 추천 상품 (조회수 기준 정렬)
		List<Product> popularList = productService.getPopularProducts(5);

		// 2. 근처 상품 (위도/경도 기준)
		List<Product> localList = null;
		if (loginUser != null) {
		    localList = productService.getProductsNearby(loginUser.getLatitude(), loginUser.getLongitude(), 30.0);
		}
		

		// 3. 결과 전달
		request.setAttribute("popularList", popularList);
		request.setAttribute("localList", localList);
		request.getRequestDispatcher("/JSP/Main/main.jsp").forward(request, response);
	}
}