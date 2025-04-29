package controller;

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

/**
 * Servlet implementation class RefundServlet
 */
@WebServlet("/refund")
public class RefundServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RefundServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String paymentKey = request.getParameter("paymentKey");
		String cancelReason = request.getParameter("cancelReason");
		String cancelAmount = request.getParameter("cancelAmount"); // 선택사항

		if (paymentKey == null || cancelReason == null) {
			response.getWriter().println("필수 항목이 누락되었습니다.");
			return;
		}

		// API 요청
		String apiUrl = "https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel";
		URL url = new URL(apiUrl);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		conn.setRequestMethod("POST");
		conn.setRequestProperty("Authorization", "Basic "
				+ Base64.getEncoder().encodeToString(("test_sk_pP2YxJ4K87d0W2eyzdE93RGZwXLO" + ":").getBytes()));
		conn.setRequestProperty("Content-Type", "application/json");
		conn.setDoOutput(true);

		// JSON Body 생성
		StringBuilder jsonBody = new StringBuilder();
		jsonBody.append("{");
		jsonBody.append("\"cancelReason\":\"").append(cancelReason).append("\"");

		if (cancelAmount != null && !cancelAmount.isEmpty()) {
			jsonBody.append(",\"cancelAmount\":").append(cancelAmount);
		}

		jsonBody.append("}");

		// Body 전송
		try (OutputStream os = conn.getOutputStream()) {
			byte[] input = jsonBody.toString().getBytes("utf-8");
			os.write(input, 0, input.length);
		}

		// 응답 처리
		int status = conn.getResponseCode();
		InputStream is = (status < 400) ? conn.getInputStream() : conn.getErrorStream();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "utf-8"));
		StringBuilder responseText = new StringBuilder();
		String responseLine;

		while ((responseLine = br.readLine()) != null) {
			responseText.append(responseLine.trim());
		}

		// 결과 출력
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().write(responseText.toString());
	}

}
