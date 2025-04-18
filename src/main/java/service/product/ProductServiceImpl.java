package service.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.category.CategoryDAO;
import dao.category.CategoryDAOImpl;
import dao.product.ProductDAO;
import dao.product.ProductDAOImpl;
import dto.Category;
import dto.Product;
import utils.PageInfo;

public class ProductServiceImpl implements ProductService {
	private ProductDAO productDAO;
	private CategoryDAO categoryDAO;

	private static final int PAGE_SIZE = 10; // 한 페이지에 보여줄 상품 수
	private static final int PAGE_BLOCK = 5; // 페이지 블록 수

	public ProductServiceImpl() {
		productDAO = new ProductDAOImpl();
		categoryDAO = new CategoryDAOImpl();
	}
	@Override
	public void registSell(Product product) throws Exception {
		productDAO.insertProductSell(product);
	}
	@Override
	public void registRentSell(Product product) throws Exception {
		productDAO.insertProductRentSell(product);
	}
	@Override
	public void registFree(Product product) throws Exception {
		productDAO.insertProductFree(product);
	}

	@Override
	public void registRent(Product product) throws Exception {
		productDAO.insertProductRent(product);
	}

	@Override
	public List<Product> getAll(String tradeType, String sort, int page) {
		String orderBy = resolveSort(sort);
		int offset = (page - 1) * PAGE_SIZE;
		return productDAO.selectAll(tradeType, orderBy, offset, PAGE_SIZE);
	}

	@Override
	public List<Product> searchByName(String name, String tradeType, String sort, int page) {
		String orderBy = resolveSort(sort);
		int offset = (page - 1) * PAGE_SIZE;
		return productDAO.selectByName(name, tradeType, orderBy, offset, PAGE_SIZE);
	}

	@Override
	public List<Product> searchByCategory(int categoryNo, String tradeType, String sort, int page) {
		String orderBy = resolveSort(sort);
		int offset = (page - 1) * PAGE_SIZE;
		return productDAO.selectByCategory(categoryNo, tradeType, orderBy, offset, PAGE_SIZE);
	}

	@Override
	 public PageInfo getPageInfo(String searchText, String categoryNo, String tradeType, String sort, int page) {
        int totalRecord;
        if (searchText != null && !searchText.isBlank()) {
            totalRecord = productDAO.countByName(searchText, tradeType);
        } else if (categoryNo != null && !categoryNo.isBlank()) {
            totalRecord = productDAO.countByCategory(Integer.parseInt(categoryNo), tradeType);
        } else {
            totalRecord = productDAO.countAll(tradeType);
        }

        int totalPage = (int) Math.ceil((double) totalRecord / PAGE_SIZE);
        int startPage = ((page - 1) / PAGE_BLOCK) * PAGE_BLOCK + 1;
        int endPage = Math.min(startPage + PAGE_BLOCK - 1, totalPage);

        // PageInfo(curPage, allPage, startPage, endPage)
        return new PageInfo(page, totalPage, startPage, endPage);
    }

	@Override
	public List<Category> getAllCategories(){
		List<Category> list;
	    try {
	        list = categoryDAO.selectCategoryList();
	    } catch (Exception e) {
	        throw new RuntimeException("카테고리 조회 실패", e);
	    }
	    // 활성화된 카테고리만 남기기
	    list.removeIf(c -> !c.getIsActive());  // c.getIsActive()가 boolean(primitive)일 경우
	    return list;
	}

	@Override
	public List<Product> getProducts(String searchText, Integer categoryNo, String tradeType, String sort,PageInfo pageInfo) {
		// 1) 검색어, 거래유형 빈 문자열을 null로 바꿔서
		String safeSearch;
		if (searchText != null && !searchText.trim().isEmpty()) {
		    safeSearch = searchText.trim();
		} else {
		    safeSearch = null;
		}

		String safeTrade;
		if (tradeType != null && !tradeType.trim().isEmpty()) {
		    safeTrade = tradeType.trim();
		} else {
		    safeTrade = null;
		}

		// 2) 정렬 기본값
		String safeSort = (sort == null || sort.isEmpty()) ? "latest" : sort;

		// 3) 페이징 계산
		int offset = (pageInfo.getCurPage() - 1) * pageInfo.getPageSize();
		int limit = pageInfo.getPageSize();

		// 4) 파라미터 맵 구성
		Map<String, Object> params = new HashMap<>();
		params.put("searchText", safeSearch);
		params.put("categoryNo", categoryNo);
		params.put("tradeType", safeTrade);
		params.put("sort", safeSort);
		params.put("offset", offset);
		params.put("limit", limit);

		// 5) DAO 호출
		return productDAO.selectProducts(params);
	}

	/**
	 * sort 키워드를 DB ORDER BY 절로 매핑
	 */
	private String resolveSort(String sort) {
		if ("recommend".equals(sort)) {
			return "view_count DESC";
		} else if ("priceAsc".equals(sort)) {
			//COALESCE(a, b) = a != NULL ? a : b
			return "COALESCE(salePrice, rentPrice) ASC";
		} else if ("priceDesc".equals(sort)) {
			return "COALESCE(salePrice, rentPrice) DESC";
		} else { // latest 기본
			return "createDate DESC";
		}
	}
}
