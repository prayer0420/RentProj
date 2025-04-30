package service.rental;

import java.util.List;

import dao.rental.RentalDAO;
import dao.rental.RentalDAOImpl;
import dto.Rental;

public class RentalServiceImpl implements RentalService {
	RentalDAO rentalDAO;
	
	public RentalServiceImpl(){
		rentalDAO = new RentalDAOImpl();
	}

	@Override
	public List<Rental> getReservedDatesByProduct(int productNo) throws Exception {
		return rentalDAO.selectByProductNo(productNo);
	}

	@Override
	public boolean isRentalDate(int productNo, String startDate, String endDate) throws Exception {
		return rentalDAO.countRentalDate(productNo, startDate, endDate) == 0;
	}

	@Override
	public void insertRental(Rental rental) throws Exception {
		rentalDAO.insertRental(rental);
	}

}
