package adminfilter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

 /*
 관리자 전용 페이지 접근을 보호하는 필터
 지정한 JSP와 서블릿 URL 패턴에 대해 요청이 들어올 때,
 세션에서 adminNo 값이 1(관리자)인지 검사하고, 관리자 권한이 없으면 메인 페이지로 리다이렉트
 */

@WebFilter(urlPatterns = {
	// 관리자 JSP 페이지 전체 묶음
    "/JSP/Admin/*",
    // 관리자 전용 서블릿 개별 나열
    "/adminInfo", "/announceList", "/announceCreate", "/announceDelete", "/announceDetail", "/announceUpdate",
    "/faqList", "/faqCreate", "/faqDelete", "/faqDetail", "/faqUpdate", "/faq",
    "/reportedProductList", "/reportDelete", "/reportHide", "/reportActive",
    "/memberInfo", "/memberGrade", "/memberDetailModal","/adminlogout",
    "/settlementList", "/doSettlement", "/rentalDelayList",
    "/categoryCreate", "/categoryList", "/categoryUpdate",
    "/faqCategoryCreate", "/faqCategory"
})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

    	// ServletRequest를 HttpServletRequest로 캐스팅 (세션, 쿠키 등 사용 가능하게)
        HttpServletRequest req = (HttpServletRequest) request;
        // ServletResponse를 HttpServletResponse로 캐스팅 (리다이렉트 가능하게)
        HttpServletResponse res = (HttpServletResponse) response;
        // 현재 요청의 세션 가져오기 (false: 세션이 없으면 null 반환)
        HttpSession session = req.getSession(false);

     // 세션이 없거나, adminNo가 없거나, adminNo 값이 1이 아니면 → 관리자 아님
        if (session == null || session.getAttribute("adminNo") == null || !(session.getAttribute("adminNo").equals(1))) {
        	// 메인 페이지로 강제 리다이렉트
        	res.sendRedirect(req.getContextPath() + "/main");
            return; // 요청 처리 중단
        }
        // 관리자 권한 확인 완료 → 다음 필터나 최종 서블릿/JSP로 요청 전달
        chain.doFilter(request, response);
    }
}