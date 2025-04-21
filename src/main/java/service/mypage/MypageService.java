package service.mypage;

import java.util.List;
import java.util.Map;

import dto.Product;
import utils.PageInfo;

public interface MypageService {

	List<Map<String,Object>> productListByPage(PageInfo pageInfo, String id) throws Exception;
	Map<String, Object> mySellDetail(Integer orderNo, String id) throws Exception;

//	List<Order> orderListByPage(PageInfo pageInfo) throws Exception;

}
