package controller.productList;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Product;
import service.product.ProductService;
import service.product.ProductServiceImpl;
import utils.PageInfo;

/**
 * 상품 목록만 비동기(AJAX)로 응답하는 서블릿
 * 요청 경로: /productList
 * 응답 JSP: /JSP/ProductList/productList.jsp (fragment)
 */
@WebServlet("/productList")
public class ProductList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final ProductService productService = new ProductServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		// 1. 클라이언트로부터 전달된 요청 파라미터 수집
		String searchText  = req.getParameter("searchText");    // 검색어
		String categoryNoP = req.getParameter("categoryNo");    // 카테고리 번호
		String tradeType   = req.getParameter("tradeType");     // 거래 유형
		String sort        = req.getParameter("sort");          // 정렬 기준
		String pageP       = req.getParameter("page");          // 현재 페이지 번호

		// 2. 문자열 파라미터 → 숫자(Integer) 변환
		Integer categoryNo = null;
		if (categoryNoP != null && !categoryNoP.isEmpty()) {
			try {
				categoryNo = Integer.valueOf(categoryNoP);
			} catch (NumberFormatException e) {
				categoryNo = null; // 잘못된 값이면 null로 처리
			}
		}

		int page = 1; // 기본 페이지 1
		if (pageP != null && !pageP.isEmpty()) {
			try {
				page = Integer.parseInt(pageP);
			} catch (NumberFormatException e) {
				page = 1;
			}
		}

		// 3. 페이징 정보 계산 + 상품 목록 조회
		PageInfo pageInfo = productService.getPageInfo(searchText, categoryNoP, tradeType, sort, page);
		List<Product> productList = productService.getProducts(searchText, categoryNo, tradeType, sort, pageInfo);

		// 4. 상품 목록 + 페이지 정보 JSP에 전달
		req.setAttribute("productList", productList);
		req.setAttribute("pageInfo", pageInfo);

		// 5. AJAX용 상품 리스트 JSP 프래그먼트로 이동
		req.getRequestDispatcher("/JSP/ProductList/productList.jsp")
		   .forward(req, resp);
	}
}
