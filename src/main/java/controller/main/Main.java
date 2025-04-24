package controller.main;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Alarm;
import dto.Product;
import service.alarm.FcmServiceImpl;
import service.product.ProductService;
import service.product.ProductServiceImpl;
import utils.PageInfo;

@WebServlet("/main")
public class Main extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Main() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ProductService productService = new ProductServiceImpl();

		// 로그인한 사용자 정보에서 위도/경도 가져오기
		String id = (String)request.getSession().getAttribute("id");
		System.out.println("세션 member: " + id);
		
		Double lat = (Double) request.getSession().getAttribute("latitude");
		Double lng = (Double) request.getSession().getAttribute("longitude");

		if (lat == null || lng == null) {
		    System.out.println("세션에 위도/경도 없음");
		}

		//추천 상품 (조회수 기준 정렬)
		List<Product> popularList = productService.getPopularProducts(5);
		List<Product> localList  =  null;
		List<Product> fullList  =  null;
		if (lat == null || lng == null) {
		    // 로그인 안 한 상태 → 전체 상품 보여주기
			fullList  = productService.getProducts(null,null,null,null, new PageInfo(1,1,1,1));
			localList = fullList.size() > 5 ? fullList.subList(0, 5) : fullList;
		} else {
		    // 로그인 한 상태 → 동네 상품 보여주기
			localList = productService.getProductsNearby(lat, lng,30);
		}

		//알람리스트 가져와서 세션에 저장
		if (id != null) {
		    List<Alarm> alarms =null;
			try {
				alarms = new FcmServiceImpl().getAlarmList(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
		    request.getSession().setAttribute("alarms", alarms);
		}
		
		//결과 전달
		request.setAttribute("popularList", popularList);
		request.setAttribute("localList", localList);
		request.getRequestDispatcher("/JSP/Main/main.jsp").forward(request, response);
	}
}