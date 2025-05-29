package service.rental;

import java.util.List;

import dto.Rental;

public interface RentalService {
	List<Rental> getReservedDatesByProduct(int productNo) throws Exception;
	boolean isRentalDate(int productNo,String startDate, String endDate) throws Exception;
	void insertRental(Rental rental)throws Exception;
}
