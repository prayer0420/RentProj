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

@WebServlet("/productList")
public class ProductList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final ProductService productService = new ProductServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		System.out.println("\n\n🟢 [ProductList 서블릿] 요청 시작 ------------------------------------");

		// 1. 파라미터 수집
		String searchText  = req.getParameter("searchText");
		String categoryNoP = req.getParameter("categoryNo");
		String tradeType   = req.getParameter("tradeType");
		String sort        = req.getParameter("sort");
		String pageP       = req.getParameter("page");

		Double lat = (Double) req.getSession().getAttribute("latitude");
		Double lng = (Double) req.getSession().getAttribute("longitude");

		System.out.printf("📥 파라미터 수신 → searchText=%s, categoryNo=%s, tradeType=%s, sort=%s, page=%s, lat=%s, lng=%s\n",
				searchText, categoryNoP, tradeType, sort, pageP, lat, lng);

		if (tradeType != null && tradeType.trim().isEmpty()) {
			tradeType = null;
		}

		// 2. 파라미터 파싱
		Integer categoryNo = null;
		try {
			categoryNo = (categoryNoP != null && !categoryNoP.isEmpty()) ? Integer.valueOf(categoryNoP) : null;
		} catch (NumberFormatException e) {
			System.out.println("❌ categoryNo 파싱 실패 → 기본값 null");
			categoryNo = null;
		}

		int page = 1;
		try {
			page = (pageP != null && !pageP.isEmpty()) ? Integer.parseInt(pageP) : 1;
		} catch (NumberFormatException e) {
			System.out.println("❌ page 파싱 실패 → 기본값 1");
			page = 1;
		}

		// 3. getPageInfo (소요시간 측정)
		long t1 = System.currentTimeMillis();
		PageInfo pageInfo = productService.getPageInfo(searchText, categoryNoP, tradeType, sort, page);
		long t2 = System.currentTimeMillis();
		System.out.println("⏱️ getPageInfo 소요 시간: " + (t2 - t1) + "ms");

		// 4. 상품 목록 조회
		List<Product> productList;
		long t3 = System.currentTimeMillis();
		if ("distance".equals(sort) && lat != null && lng != null) {
			System.out.println("📌 거리순 정렬 → 좌표 사용하여 상품 조회");
			productList = productService.getProducts(searchText, categoryNo, tradeType, sort, pageInfo, lat, lng);
		} else {
			productList = productService.getProducts(searchText, categoryNo, tradeType, sort, pageInfo, null, null);
		}
		long t4 = System.currentTimeMillis();
		System.out.println("⏱️ getProducts 소요 시간: " + (t4 - t3) + "ms");

		// 5. 결과 로깅
		System.out.println("📦 조회된 상품 수: " + productList.size());
		System.out.println("📄 pageInfo: " + pageInfo);
		System.out.println("✅ 전체 처리 완료: " + (t4 - t1) + "ms");

		// 6. request에 값 저장 + JSP로 forward
		req.setAttribute("productList", productList);
		req.setAttribute("pageInfo", pageInfo);
		req.getRequestDispatcher("/JSP/ProductList/productList.jsp")
		   .forward(req, resp);
	}
}
