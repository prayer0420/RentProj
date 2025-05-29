package filter;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

import dto.Category;
import service.category.CategoryService;
import service.category.CategoryServiceImpl;

@WebFilter("/*")  // 모든 요청에 적용
public class CategoryInjectFilter implements Filter {

    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;

        if (req.getAttribute("categoryList") == null) {
            try {
                List<Category> categoryList = categoryService.getAllCategories();
                req.setAttribute("categoryList", categoryList);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        chain.doFilter(request, response); // 다음으로 넘기기
    }

    @Override
    public void init(FilterConfig filterConfig) {}

    @Override
    public void destroy() {}
}
