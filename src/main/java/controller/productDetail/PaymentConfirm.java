package controller.productDetail;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.alarmList.AlarmMessageDAO;
import dao.alarmList.AlarmMessageDAOImpl;
import dto.Alarm;
import dto.AlarmMessage;
import dto.Order;
import dto.Rental;
import service.alarm.FcmService;
import service.alarm.FcmServiceImpl;
import service.order.OrderService;
import service.order.OrderServiceImpl;
import service.product.ProductService;
import service.product.ProductServiceImpl;
import service.rental.RentalService;
import service.rental.RentalServiceImpl;

/**
 * Servlet implementation class PaymentConfirm
 */
@WebServlet("/confirm")
public class PaymentConfirm extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PaymentConfirm() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String paymentKey = request.getParameter("paymentKey");
		String orderId = request.getParameter("orderId");
		String amount = request.getParameter("amount");
		
		
		HttpSession session = request.getSession();
		Integer memberNo = (Integer)request.getSession().getAttribute("no");
		Integer price = Integer.parseInt(amount);
		String deliveryAddr = (String) request.getAttribute("deliveryAddr");
		String orderType = (String)request.getAttribute("orderType");
	
		Date today = new Date(System.currentTimeMillis());
		Date startDate = today;
		Date endDate = today;
		
		try {
		    String start = (String) session.getAttribute("start");
		    if (start != null && start.matches("\\d{4}-\\d{2}-\\d{2}")) {
		        startDate = Date.valueOf(start);
		    }
		} catch (Exception e) {
		    // 무시: 오늘 날짜 유지
		}

		try {
		    String end = (String) session.getAttribute("end");
		    if (end != null && end.matches("\\d{4}-\\d{2}-\\d{2}")) {
		        endDate = Date.valueOf(end);
		    }
		} catch (Exception e) {
		    // 무시: 오늘 날짜 유지
		}
		
		
//		System.out.println("결제 끝 startDate = " + start);
//		System.out.println("결제 끝 endDate = " + end);
//		if (start == null || !start.matches("\\d{4}-\\d{2}-\\d{2}")) {
//		    throw new IllegalArgumentException("startDate 값이 잘못되었습니다: " + start);
//		}
//		if (end == null || !end.matches("\\d{4}-\\d{2}-\\d{2}")) {
//		    throw new IllegalArgumentException("endDate 값이 잘못되었습니다: " + end);
//		}
//		Date startDate = Date.valueOf(start);
//		Date endDate = Date.valueOf(end);

		// 여기서 orderId로부터 productNo 추출 (예: ORDER_123_1710000000)
		String[] parts = orderId.split("_");
		Integer productNo = Integer.parseInt(parts[1]); // "123"

		// ✅ secretKey는 절대 노출 금지 (서버에서만 보관)
		String secretKey = "test_sk_pP2YxJ4K87d0W2eyzdE93RGZwXLO";
		String encodedKey = Base64.getEncoder().encodeToString((secretKey + ":").getBytes());

		URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Authorization", "Basic " + encodedKey);
		conn.setRequestProperty("Content-Type", "application/json");
		conn.setDoOutput(true);

		// 요청 JSON 생성
		String jsonBody = String.format("{\"paymentKey\":\"%s\",\"orderId\":\"%s\",\"amount\":%s}", paymentKey, orderId,
				amount);

		try (OutputStream os = conn.getOutputStream()) {
			os.write(jsonBody.getBytes("UTF-8"));
		}

		int status = conn.getResponseCode();

		InputStream is = (status == 200) ? conn.getInputStream() : conn.getErrorStream();
		BufferedReader reader = new BufferedReader(new InputStreamReader(is));
		StringBuilder responseText = new StringBuilder();
		String line;
		while ((line = reader.readLine()) != null) {
			responseText.append(line);
		}
		reader.close();
		
		Rental rental = (Rental) session.getAttribute("rental");
		Integer deliveryPrice = (Integer) session.getAttribute("deliveryPrice");
		Integer secPrice = (Integer) session.getAttribute("secPrice");
		
		
		
		Order order = new Order(memberNo, price,productNo, deliveryAddr,orderId,orderType,startDate,endDate,
				paymentKey,deliveryPrice,secPrice);
		OrderService service = new OrderServiceImpl();
		RentalService rentalService = new RentalServiceImpl();
		try {
			if (status == 200) {
				if(rental != null) {
					rentalService.insertRental(rental);
					session.removeAttribute("rental");
				}
				// 승인 성공 → DB 저장 가능
				service.insertOrder(order);
				request.setAttribute("order", order);
				request.setAttribute("result", responseText.toString());
				session.removeAttribute("start");
				session.removeAttribute("end");
				session.removeAttribute("deliveryPrice");
				session.removeAttribute("secPrice");
				
				
				// 알림 전송
				ProductService productService = new ProductServiceImpl();
				String sellerId = productService.getSellerIdByProductNo(productNo);

				AlarmMessageDAO messageDao = new AlarmMessageDAOImpl();
				AlarmMessage template = messageDao.selectByType("Purchase");

				if (template != null) {
					String buyerNickname = (String) session.getAttribute("nickname");

					String filledTitle = template.getTitle().replace("${id}", buyerNickname);
					String filledContent = template.getContent().replace("${id}", buyerNickname);

					Alarm alarm = new Alarm(template.getType(), sellerId, filledTitle, filledContent, true);

					FcmService fcmService = new FcmServiceImpl();
					fcmService.sendAlarm(alarm);
				}
				
				response.sendRedirect("productDetail?no=" + productNo + "&paid=true");
			} else {
				// 승인 실패
				request.setAttribute("error", responseText.toString());
				request.getRequestDispatcher("/payment/fail.jsp").forward(request, response);
				System.out.println("실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
