package service.product;

import java.util.*;
import java.util.stream.Collectors;

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

	private static final int PAGE_BLOCK = 5;

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

	// 상품 목록 조회
	@Override
	public List<Product> getProducts(String searchText, Integer categoryNo, String tradeType, String sort,
	                                 PageInfo pageInfo, Double userLat, Double userLng) {

	    String safeSearch = (searchText != null && !searchText.trim().isEmpty()) ? searchText.trim() : null;
	    String safeTrade = (tradeType != null && !tradeType.trim().isEmpty()) ? tradeType.trim() : null;
	    String safeSort = (sort == null || sort.isEmpty()) ? "latest" : sort;
	    Integer safeCategory = (categoryNo != null && (categoryNo == 0 || categoryNo == 1)) ? null : categoryNo;

	    int offset = (pageInfo.getCurPage() - 1) * pageInfo.getPageSize();
	    int limit = pageInfo.getPageSize();

	    Map<String, Object> params = new HashMap<>();
	    params.put("searchText", safeSearch);
	    params.put("categoryNo", safeCategory);
	    params.put("tradeType", safeTrade);
	    params.put("isHide", 1);
	    params.put("deleted", "N");

	    // 거리순 정렬인 경우: 전체 불러와서 Java에서 거리 계산 + 수동 페이징
	    if ("distance".equals(safeSort) && userLat != null && userLng != null) {
	        params.put("offset", null);
	        params.put("limit", null);

	        List<Product> allProducts = productDAO.selectProducts(params);
	        System.out.println("🧭 거리 정렬 시작: 기준 좌표 = " + userLat + ", " + userLng);

	        for (Product p : allProducts) {
	            if (p.getLatitude() != null && p.getLongitude() != null) {
	                double d = getDistance(userLat, userLng, p.getLatitude(), p.getLongitude());
	                p.setDistance(d);
	                System.out.println("상품 " + p.getNo() + " 거리 = " + d);
	            } else {
	                p.setDistance(Double.MAX_VALUE);
	                System.out.println("상품 " + p.getNo() + " 좌표 없음 처리됨");
	            }
	        }

	        // 정렬 먼저
	        allProducts.sort(Comparator.comparingDouble(Product::getDistance));

	        // ✨ 정확한 offset 기반 subList
	        int start = (pageInfo.getCurPage() - 1) * pageInfo.getPageSize();
	        int end = Math.min(start + pageInfo.getPageSize(), allProducts.size());

	        if (start > allProducts.size()) return Collections.emptyList();

	        return allProducts.subList(start, end);
	    }

	    // 일반 정렬
	    params.put("offset", offset);
	    params.put("limit", limit);
	    params.put("sort", safeSort);

	    return productDAO.selectProducts(params);
	}


	@Override
	public List<Category> getAllCategories() {
		try {
			List<Category> list = categoryDAO.selectCategoryList();
			list.removeIf(c -> !c.getIsActive());
			return list;
		} catch (Exception e) {
			throw new RuntimeException("카테고리 조회 실패", e);
		}
	}

	@Override
	public PageInfo getPageInfo(String searchText, String categoryNo, String tradeType, String sort, int page) {
		int totalRecord;

		System.out.println("🧩 [PageInfo] Params - searchText: " + searchText + ", categoryNo: " + categoryNo + ", tradeType: " + tradeType + ", page: " + page);

		if (searchText != null && !searchText.isBlank()) {
			totalRecord = productDAO.countByName(searchText, tradeType);
			System.out.println("🔢 [PageInfo] countByName result: " + totalRecord);
		} else if (categoryNo != null && !categoryNo.isBlank() && !"0".equals(categoryNo) && !"1".equals(categoryNo)) {
		    totalRecord = productDAO.countByCategory(Integer.parseInt(categoryNo), tradeType);
		    System.out.println("🔢 [PageInfo] countBCategory result: " + totalRecord);
		} else {
			totalRecord = productDAO.countAll(tradeType);
			System.out.println("🔢 [PageInfo] countAll result: " + totalRecord);
		}
		int pageSize = 12; 
		int totalPage = (int) Math.ceil((double) totalRecord / pageSize);
		int startPage = ((page - 1) / PAGE_BLOCK) * PAGE_BLOCK + 1;
		int endPage = Math.min(startPage + PAGE_BLOCK - 1, totalPage);

		PageInfo pageInfo = new PageInfo(page, totalPage, startPage, endPage);
		System.out.println("📦 [PageInfo] pageSize: " + pageInfo.getPageSize());

		return pageInfo;
	}

	@Override
	public Product selectProductOne(Integer no) throws Exception {
		return productDAO.SelectProductOne(no);
	}

	@Override
	public List<Product> getPopularProducts(int limit) {
		return productDAO.selectPopularProducts(limit);
	}

	// 거리 계산
	private double getDistance(double lat1, double lon1, double lat2, double lon2) {
		double R = 6371;
		double dLat = Math.toRadians(lat2 - lat1);
		double dLon = Math.toRadians(lon2 - lon1);
		double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
				+ Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
				* Math.sin(dLon / 2) * Math.sin(dLon / 2);
		double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
		return R * c;
	}

	@Override
	public void incrementViewCount(int no) throws Exception {
		productDAO.incrementViewCount(no);
		
	}

	@Override
	public int selectViewCount(int no) throws Exception {
		return productDAO.selectViewCount(no);
	}
	
	//판매자 아이디 가져오기
	@Override
	public String getSellerIdByProductNo(int productNo) {
	    return productDAO.selectSellerIdByProductNo(productNo);
	}
}