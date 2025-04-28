package controller.productRegister;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.Product;
import service.product.ProductService;
import service.product.ProductServiceImpl;

/**
 * Servlet implementation class ProductRegisterSell
 */
@WebServlet("/sell")
public class ProductRegisterSell extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductRegisterSell() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/JSP/ProductRegister/ProductRegisterSell.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");

		String path = request.getServletContext().getRealPath("upload");
		File uploadDir = new File(path);
		if (!uploadDir.exists()) {
		    uploadDir.mkdirs();
		}
		int size = 10 * 1024 * 1024;
		MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		Integer categoryNo = Integer.parseInt(multi.getParameter("categoryNo"));
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String state = multi.getParameter("state");
		String deliveryAddr = multi.getParameter("deliveryAddr");

		Integer deliveryPrice = 0;
		if ((multi.getParameter("deliveryPrice")) != null) {
			deliveryPrice = Integer.parseInt(multi.getParameter("deliveryPrice"));
		}
//		Integer deliveryPrice = Integer.parseInt(multi.getParameter("deliveryPrice"));
		String tradeType = multi.getParameter("tradeType");
//		Integer memberNo = Integer.parseInt(multi.getParameter("memberNo"));
		Integer memberNo = 1;
		Integer salePrice = Integer.parseInt(multi.getParameter("salePrice"));
		String deliveryStatus = multi.getParameter("deliveryStatus");

		// 파일 받기
		String[] imgList = new String[5];
		imgList[0] = multi.getFilesystemName("imgList0");
		imgList[1] = multi.getFilesystemName("imgList1");
		imgList[2] = multi.getFilesystemName("imgList2");
		imgList[3] = multi.getFilesystemName("imgList3");
		imgList[4] = multi.getFilesystemName("imgList4");

		// 최소 1장 체크
		if (imgList[0] == null) {
		    request.setAttribute("errorMsg", "상품 이미지는 최소 1장이 필요합니다.");
		    request.getRequestDispatcher("/JSP/ProductRegister/ProductRegisterSell.jsp").forward(request, response);
		    return;
		}
		

		Product product = new Product(categoryNo, title, content, state, imgList[0], imgList[1], imgList[2], imgList[3],
				imgList[4], deliveryAddr, deliveryPrice, tradeType, memberNo, salePrice, deliveryStatus);
		ProductService service = new ProductServiceImpl();

		try {
			service.registSell(product);
			request.setAttribute("Product", product);
			response.sendRedirect(request.getContextPath() + "/main");
		} catch (Exception e) {
			e.printStackTrace(); // 🚩 여기에 예외 정보가 찍힙니다.
		}

	}

}
