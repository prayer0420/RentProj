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
	
		Integer memberNo = Integer.parseInt(multi.getParameter("memberNo"));
		Integer categoryNo = Integer.parseInt(multi.getParameter("categoryNo"));
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String deliveryAddr = multi.getParameter("deliveryAddr");
		String tradeType = multi.getParameter("tradeType");
		// 최대 5개의 이미지 받아오기
		String[] imgList = new String[5];
		for (int i = 0; i < 5; i++) {
			String fileName = multi.getFilesystemName("imgList"); // name 속성은 모두 imgList이기 때문에 getFilesystemName은 첫 번째 것만 반환
			if (i == 0) {
				imgList[i] = fileName;
			} else {
				imgList[i] = multi.getFilesystemName("imgList" + i); // 참고: 이건 동작하지 않음
			}
		}
		// 대안: 직접 파싱 (MultipartRequest는 동일 name의 여러 파일을 다루기 어려움)
		java.util.Enumeration<?> files = multi.getFileNames();
		int idx = 0;
		while (files.hasMoreElements() && idx < 5) {
			String name = (String) files.nextElement();
			String fileName = multi.getFilesystemName(name);
			if (fileName != null) {
				imgList[idx++] = fileName;
			}
		}
		String img1 = imgList[0];
		String img2 = imgList[1];
		String img3 = imgList[2];
		String img4 = imgList[3];
		String img5 = imgList[4];
		
		Product product = new Product(categoryNo, title, content, img1,img2,img3,img4,img5,deliveryAddr ,tradeType, memberNo);
		
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
