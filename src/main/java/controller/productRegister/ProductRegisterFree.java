package controller.productRegister;

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
 * Servlet implementation class ProductRegisterFree
 */
@WebServlet("/free")
public class ProductRegisterFree extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductRegisterFree() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/JSP/ProductRegister/ProductRegisterFree.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String path = request.getServletContext().getRealPath("upload");
		int size = 10*1024*1024;
		
		MultipartRequest multi = new MultipartRequest(request, path,size,"utf-8",new DefaultFileRenamePolicy());
	
//		Integer memberNo = Integer.parseInt(multi.getParameter("memberNo"));
		Integer memberNo = 1;
		Integer categoryNo = Integer.parseInt(multi.getParameter("categoryNo"));
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String deliveryAddr = multi.getParameter("deliveryAddr");
		String tradeType = multi.getParameter("tradeType");

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
		
		
		Product product = new Product(categoryNo, title, content, imgList[0],imgList[1],imgList[2],imgList[3],imgList[4],deliveryAddr ,tradeType, memberNo);
		
		ProductService service = new ProductServiceImpl();
		
		try {
			service.registFree(product);
			request.setAttribute("product", product);
			response.sendRedirect(request.getContextPath()+"/main");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
	}

}
