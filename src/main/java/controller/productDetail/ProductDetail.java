package controller.productDetail;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;

@WebServlet("/productDetail")
public class ProductDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ProductDetail() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null) {
			System.out.println("[DEBUG] 세션 없음");
		} else {
			Member member = (Member) session.getAttribute("member");
			if (member == null) {
				System.out.println("[DEBUG] 세션 있음, but 로그인 안됨 (member == null)");
			} else {
				System.out.println("[DEBUG] 로그인됨 - ID: " + member.getId() + ", 닉네임: " + member.getNickname());
			}
		}

		// forward to JSP
		request.getRequestDispatcher("/JSP/ProductDetail/productDetail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
