package controller.productList;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Category;
import dto.Product;
import service.product.ProductService;
import service.product.ProductServiceImpl;
import utils.PageInfo;

@WebServlet("/list")
public class ListBody extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ListBody() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ProductService productService = new ProductServiceImpl();

		// 1) 파라미터 수집
		String searchText = request.getParameter("searchText");
		String categoryNo = request.getParameter("categoryNo");
		String tradeType = request.getParameter("tradeType");
		String sort = request.getParameter("sort");
		int page = parseInt(request.getParameter("page"), 1);
		Double lat = (Double) request.getSession().getAttribute("latitude");
		Double lng = (Double) request.getSession().getAttribute("longitude");

		// 2) 페이지 정보 계산
		PageInfo pageInfo = productService.getPageInfo(searchText, categoryNo, tradeType, sort, page);

		// 3) 상품 목록 조회
		Integer categoryInt = (categoryNo != null && !"0".equals(categoryNo)) ? Integer.valueOf(categoryNo) : null;
		List<Product> list = productService.getProducts(searchText, categoryInt, tradeType, sort, pageInfo,lat,lng);

		// 4) 카테고리 목록
		List<Category> categories = productService.getAllCategories();

		// 5) 데이터 전달
		request.setAttribute("productList", list);
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("categories", categories);
		request.getRequestDispatcher("/JSP/ProductList/list.jsp").forward(request, response);
	}

	private int parseInt(String s, int def) {
		try {
			return Integer.parseInt(s);
		} catch (Exception e) {
			return def;
		}
	}
}
