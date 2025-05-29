package controller.rentalCalendar;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import dto.Rental;
import service.rental.RentalService;
import service.rental.RentalServiceImpl;

/**
 * Servlet implementation class GetReservedDates
 */
@WebServlet("/getReservedDates")
public class GetReservedDates extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetReservedDates() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=utf-8");

		int productNo = Integer.parseInt(request.getParameter("productNo"));

		RentalService service = new RentalServiceImpl();
		try {
			List<Rental> reservedList = service.getReservedDatesByProduct(productNo);
			Gson gson = new Gson();
			gson = new GsonBuilder()
					  .setDateFormat("yyyy-MM-dd")
					  .create();
			String json = gson.toJson(reservedList);
			
			PrintWriter out = response.getWriter();
			out.print(json);
			out.flush();
			
		}catch(Exception e) {
			e.printStackTrace();
		}

	}


}
