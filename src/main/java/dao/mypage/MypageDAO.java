package dao.mypage;

import java.util.List;
import java.util.Map;

import dto.Product;

public interface MypageDAO {

	Integer selectProductCountById(String id) throws Exception;
	List<Map<String, Object>> selectProductListByPage(Map<String, Object> paramMap) throws Exception;
	Map<String, Object> selectMySellDetail(Integer orderNo, String id);
	boolean updateInvoiceInfo(Integer orderNo, String deliveryComp, String invoiceNo) throws Exception;

	public void updateLocation(String memberId, double latitude, double longitude) ;

}
