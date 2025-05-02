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

import dto.Member;
import dto.Product;
import service.member.MemberService;
import service.member.MemberServiceImpl;
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
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/JSP/ProductRegister/productRegisterFree.jsp").forward(request, response);
	}

	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        request.setCharacterEncoding("utf-8");

	        String path = request.getServletContext().getRealPath("upload");
	        File uploadDir = new File(path);
	        if (!uploadDir.exists()) {
	            uploadDir.mkdirs();
	        }
	        int size = 10 * 1024 * 1024;

	        MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

	        // 가져오는 데이터
	        Integer categoryNo = Integer.parseInt(multi.getParameter("categoryNo"));
	        String title = multi.getParameter("title");
	        String content = multi.getParameter("content");
	        String state = multi.getParameter("state");

	        Integer deliveryPrice = 0;
	        if ((multi.getParameter("deliveryPrice")) != null) {
	            deliveryPrice = Integer.parseInt(multi.getParameter("deliveryPrice"));
	        }

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
	            request.getRequestDispatcher("/JSP/ProductRegister/productRegisterFree.jsp").forward(request, response);
	            return;
	        }

	        // 세션에서 로그인된 사용자 ID 가져오기
	        String loginId = (String) request.getSession().getAttribute("id");
	        if (loginId == null) {
	            response.sendRedirect(request.getContextPath() + "/JSP/Login/login.jsp");
	            return;
	        }

	        // MemberService 통해 회원 정보 조회
	        MemberService memberService = new MemberServiceImpl();
	        Member member = null;
	        try {
	            member = memberService.getMemberById(loginId);
	        } catch (Exception e1) {
	            e1.printStackTrace();
	        }

	        if (member == null) {
	            request.setAttribute("errorMsg", "회원 정보를 불러올 수 없습니다.");
	            request.getRequestDispatcher("/JSP/ProductRegister/productRegisterFree.jsp").forward(request, response);
	            return;
	        }

	        // member에서 거래지역, 위도경도 정보 가져오기
	        Integer memberNo = member.getNo();
	        String deliveryAddr = member.getLocation();
	        double latitude = member.getLatitude();
	        double longitude = member.getLongitude();

	        if (member.getLocation() == null || member.getLatitude() == null || member.getLongitude() == null) {
	            request.setAttribute("locationError", true);
	            request.getRequestDispatcher("/JSP/ProductRegister/productRegisterFree.jsp").forward(request, response);
	            return;
	        }

	        Product product = new Product(
	                categoryNo, title, content, state, imgList[0], imgList[1], imgList[2], imgList[3], imgList[4], deliveryAddr,
	                deliveryPrice, tradeType, memberNo, latitude, longitude
	        );

	        ProductService service = new ProductServiceImpl();
	        try {
	            service.registFree(product);
	            request.setAttribute("product", product);
	            response.sendRedirect(request.getContextPath() + "/main");

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
}
