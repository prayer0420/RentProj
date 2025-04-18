package controller.productList;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Product;
import service.product.ProductService;
import service.product.ProductServiceImpl;
import utils.PageInfo;
import java.util.List;

@WebServlet("/productList")
public class ProductList extends HttpServlet {
    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 1) 파라미터 읽기
        String searchText   = req.getParameter("searchText");
        String categoryNoP  = req.getParameter("categoryNo");
        String tradeType    = req.getParameter("tradeType");
        String sort         = req.getParameter("sort");
        String pageP        = req.getParameter("page");

        // 2) 숫자 파싱 (빈 문자열 방어)
        Integer categoryNo = null;
        if (categoryNoP != null && !categoryNoP.isEmpty()) {
            try {
                categoryNo = Integer.valueOf(categoryNoP);
            } catch (NumberFormatException e) {
                categoryNo = null;
            }
        }

        int page = 1;
        if (pageP != null && !pageP.isEmpty()) {
            try {
                page = Integer.parseInt(pageP);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        // 3) 서비스 호출
        PageInfo pageInfo = productService.getPageInfo(searchText, categoryNoP, tradeType, sort, page);
        List<Product> productList 
            = productService.getProducts(searchText, categoryNo, tradeType, sort, pageInfo);

        // 4) JSP로 데이터 전달
        req.setAttribute("productList", productList);
        req.setAttribute("pageInfo", pageInfo);
        req.getRequestDispatcher("/JSP/ProductList/productList.jsp")
           .forward(req, resp);
        
        
    }
}
