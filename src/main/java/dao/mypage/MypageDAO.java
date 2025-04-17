package dao.mypage;

import java.util.List;

import dto.Product;

public interface MypageDAO {

	Integer selectProductCount() throws Exception;

	List<Product> selectProductListByPage(Integer row) throws Exception;

}
