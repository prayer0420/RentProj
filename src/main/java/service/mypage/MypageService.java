package service.mypage;

import java.util.List;

import dto.Product;
import utils.PageInfo;

public interface MypageService {

	List<Product> productListByPage(PageInfo pageInfo) throws Exception;

}
