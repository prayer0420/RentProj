package controller.refund;

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

import service.order.OrderService;
import service.order.OrderServiceImpl;

@WebServlet("/refund")
public class Refund extends HttpServlet {

	private static final long serialVersionUID = 1L;

	// ★ 여기에 너의 secret key 넣기 (test / live 구분)
	private static final String SECRET_KEY = "test_sk_pP2YxJ4K87d0W2eyzdE93RGZwXLO";

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 요청 파라미터 UTF-8 인코딩
		request.setCharacterEncoding("UTF-8");

		String paymentKey = request.getParameter("paymentKey");
		String cancelReason = request.getParameter("cancelReason");
		String cancelAmountStr = request.getParameter("cancelAmount"); // 선택사항
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));

		// 입력값 검증
		if (paymentKey == null || paymentKey.trim().isEmpty() || cancelReason == null
				|| cancelReason.trim().isEmpty()) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "paymentKey와 cancelReason은 필수입니다.");
			return;
		}

		paymentKey = paymentKey.trim(); // 혹시 모를 공백 제거

		// 환불 API URL
		String apiUrl = "https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel";

		URL url = new URL(apiUrl);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Authorization",
				"Basic " + Base64.getEncoder().encodeToString((SECRET_KEY + ":").getBytes()));
		conn.setRequestProperty("Content-Type", "application/json");
		conn.setDoOutput(true);

		// JSON Body 구성
		StringBuilder jsonBody = new StringBuilder();
		jsonBody.append("{");
		jsonBody.append("\"cancelReason\":\"").append(cancelReason).append("\"");

		if (cancelAmountStr != null && !cancelAmountStr.trim().isEmpty()) {
			try {
				int cancelAmount = Integer.parseInt(cancelAmountStr.trim());
				if (cancelAmount > 0) {
					jsonBody.append(",\"cancelAmount\":").append(cancelAmount);
				}
			} catch (NumberFormatException e) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "cancelAmount는 숫자여야 합니다.");
				return;
			}
		}

		jsonBody.append("}");

		// Body 전송
		try (OutputStream os = conn.getOutputStream()) {
			byte[] input = jsonBody.toString().getBytes("utf-8");
			os.write(input, 0, input.length);
		}

		// 응답 받기
		int statusCode = conn.getResponseCode();
		InputStream is = (statusCode < 400) ? conn.getInputStream() : conn.getErrorStream();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "utf-8"));

		StringBuilder result = new StringBuilder();
		String line;
		while ((line = br.readLine()) != null) {
			result.append(line.trim());
		}
		try {
			if (statusCode == 200) {
				// DB 상태 변경
				OrderService orderService = new OrderServiceImpl();
			
				orderService.updateOrderStatus(orderNo, "결제취소");
				System.out.println("▶ 주문 상태 업데이트 실행됨: " + orderNo);
				// 클라이언트에 성공 응답
				response.setContentType("application/json;charset=UTF-8");
				response.setStatus(200);
				response.getWriter().write(result.toString());
			} else {
				// 오류 응답
				response.setContentType("application/json;charset=UTF-8");
				response.setStatus(statusCode);
				response.getWriter().write(result.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
