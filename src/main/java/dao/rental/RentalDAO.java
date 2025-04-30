package dao.rental;

import java.util.List;

import dto.Rental;

public interface RentalDAO {
	List<Rental> selectByProductNo(int productNo) throws Exception;
	int countRentalDate(int productNo,String startDate,String endDate) throws Exception;
	void insertRental(Rental rental) throws Exception;

}
