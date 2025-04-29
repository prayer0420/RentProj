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


		// 파라미터 수집
		String searchText  = req.getParameter("searchText");
		String categoryNoP = req.getParameter("categoryNo");
		String tradeType   = req.getParameter("tradeType");
		String sort        = req.getParameter("sort");
		String pageP       = req.getParameter("page");

		Double lat = (Double) req.getSession().getAttribute("latitude");
		Double lng = (Double) req.getSession().getAttribute("longitude");

		if (tradeType != null && tradeType.trim().isEmpty()) {
			tradeType = null;
		}

		// 파라미터 파싱
		Integer categoryNo = null;
		try {
			categoryNo = (categoryNoP != null && !categoryNoP.isEmpty()) ? Integer.valueOf(categoryNoP) : null;
		} catch (NumberFormatException e) {
			categoryNo = null;
		}

		int page = 1;
		try {
			page = (pageP != null && !pageP.isEmpty()) ? Integer.parseInt(pageP) : 1;
		} catch (NumberFormatException e) {
			page = 1;
		}

		PageInfo pageInfo = productService.getPageInfo(searchText, categoryNoP, tradeType, sort, page);

		//상품 목록 조회
		List<Product> productList;
		if ("distance".equals(sort) && lat != null && lng != null) {
			productList = productService.getProducts(searchText, categoryNo, tradeType, sort, pageInfo, lat, lng);
		} else {
			productList = productService.getProducts(searchText, categoryNo, tradeType, sort, pageInfo, null, null);
		}

		//request에 값 저장 + JSP로 forward
		req.setAttribute("productList", productList);
		req.setAttribute("pageInfo", pageInfo);
		req.getRequestDispatcher("/JSP/ProductList/productList.jsp")
		   .forward(req, resp);
	}
}
