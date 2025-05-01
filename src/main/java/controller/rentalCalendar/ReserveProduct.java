package controller.rentalCalendar;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Rental;
import service.rental.RentalService;
import service.rental.RentalServiceImpl;

/**
 * Servlet implementation class ReserveProduct
 */
@WebServlet("/reserveProduct")
public class ReserveProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReserveProduct() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/plain; charset=utf-8");

		int productNo = Integer.parseInt(request.getParameter("productNo"));
		int memberNo = (int) request.getSession().getAttribute("no");
		String start = request.getParameter("startDate");
		String end = request.getParameter("endDate");
		if (start == null || end == null || start.isEmpty() || end.isEmpty()) {
		    response.getWriter().print("fail");
		    System.err.println("❌ 날짜 파라미터가 비어있음: start=" + start + ", end=" + end);
		    return;
		}
		System.out.println("예약"+start);
		System.out.println("예약"+end);
		RentalService service = new RentalServiceImpl();

		try {
			boolean isAvailable = service.isRentalDate(productNo, start, end);
			if (isAvailable) {
				Rental rental = new Rental(productNo, memberNo, java.sql.Date.valueOf(start),java.sql.Date.valueOf(end));
				HttpSession session = request.getSession();
				session.setAttribute("rental",rental);
				session.setAttribute("start",start);
				session.setAttribute("end", end);
				response.getWriter().print("success");
			} else {
				response.getWriter().print("fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().print("fail");
		}
	}

}
