package controller.productDetail;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import dto.Order;
import dto.Product;
import service.order.OrderService;
import service.order.OrderServiceImpl;

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
		Member member = (Member) session.getAttribute("member");
		Integer memberNo = member.getNo();
		Integer price = Integer.parseInt(amount);

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

		Order order = new Order(memberNo, price,productNo, orderId);
		OrderService service = new OrderServiceImpl();
		try {
			if (status == 200) {
				// 승인 성공 → DB 저장 가능
				service.insertOrder(order);
				request.setAttribute("order", order);
				request.setAttribute("result", responseText.toString());
				response.sendRedirect("productDetail?no=" + productNo + "&paid=true");
				System.out.println("컨펌성공");
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
