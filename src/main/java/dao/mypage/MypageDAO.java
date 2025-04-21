package dao.mypage;

import java.util.List;
import java.util.Map;

import dto.Order;
import dto.Product;

public interface MypageDAO {

	Integer selectProductCountById(String id) throws Exception;
	List<Product> selectProductListByPage(Map<String, Object> paramMap) throws Exception;
	Map<String, Object> selectMySellDetail(Integer orderNo, String id);

	public void updateLocation(String memberId, double latitude, double longitude);

}
