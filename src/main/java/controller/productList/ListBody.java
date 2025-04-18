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

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ProductService productService = new ProductServiceImpl();

		String searchText = request.getParameter("searchText");
	    String categoryNo = request.getParameter("categoryNo");
	    String tradeType = request.getParameter("tradeType"); // 필터
	    String sort      = request.getParameter("sort");      // 정렬
	    int page         = parse(request.getParameter("page"), 1);

	    // 1) 검색 vs 2) 카테고리 vs 3) 전체
	    List<Product> list;
	    if (searchText != null && !searchText.isBlank()) {
	      list = productService.searchByName(searchText, tradeType, sort, page);
	    } else if (categoryNo != null && !categoryNo.isBlank()) {
	      list = productService.searchByCategory(
	        Integer.parseInt(categoryNo), tradeType, sort, page);
	    } else {
	      list = productService.getAll(tradeType, sort, page);
	    }

        PageInfo pageInfo = productService.getPageInfo(searchText, categoryNo, tradeType, sort, page);
        List<Category> categories = productService.getAllCategories();

        
        request.setAttribute("productList", list);
        request.setAttribute("pageInfo", pageInfo);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/JSP/ProductList/list.jsp").forward(request, response);
	  }

    private int parse(String s, int def) {
        try { return Integer.parseInt(s); }
        catch (Exception e) { return def; }
    }
}
