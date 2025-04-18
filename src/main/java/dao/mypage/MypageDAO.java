package dao.mypage;

import java.util.List;
import java.util.Map;

import dto.Product;

public interface MypageDAO {

	Integer selectProductCountById(String id) throws Exception;

	List<Product> selectProductListByPage(Map<String, Object> paramMap) throws Exception;

}
