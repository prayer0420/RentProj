package controller.mypage;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import service.mark.MarkService;
import service.mark.MarkServiceImpl;
import service.member.MemberService;
import service.member.MemberServiceImpl;
import utils.PageInfo;

@WebServlet("/myMarkList")
public class MyMarkList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final MarkService markService = new MarkServiceImpl();
	private final MemberService memberService = new MemberServiceImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession(false);
		Integer memberNo = (Integer) session.getAttribute("no");

		String pageP = request.getParameter("page");
		int page = 1;
		try {
			page = (pageP != null && !pageP.isEmpty()) ? Integer.parseInt(pageP) : 1;
		} catch (NumberFormatException e) {
			System.out.println("❌ page 파싱 실패 → 기본 1페이지");
		}
		
		try {
			if (memberNo == null) {
				response.sendRedirect(request.getContextPath() + "/login");
				return;
			}

			PageInfo pageInfo = markService.getPageInfo(memberNo, page);

			List<Map<String, Object>> marklist = markService.selectMyMarkList(memberNo, pageInfo);
			System.out.println("찜정보"+marklist );
			request.setAttribute("marklist", marklist);
			request.setAttribute("pageInfo", pageInfo);

			request.getRequestDispatcher("/JSP/MyPage/myMarkList.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/error.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		try {
			String[] marklistIds = request.getParameterValues("marklistIds");

			HttpSession session = request.getSession(false);
			String memberId = (String) session.getAttribute("id");
			Integer memberNo = (Integer) session.getAttribute("no");

			if (marklistIds != null && memberId != null) {
				for (String productNoStr : marklistIds) {
					int productNo = Integer.parseInt(productNoStr);
					//삭제 로직
					markService.deleteMark(memberNo, productNo);
				}
			}

			// 삭제 끝났으면 다시 찜목록 새로고침
			response.sendRedirect(request.getContextPath() + "/myMarkList");

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/error.jsp");
		}
	}
}
