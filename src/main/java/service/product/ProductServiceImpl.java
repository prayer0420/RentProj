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

	private static final int PAGE_SIZE = 10;
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
		System.out.println("🟢 [ProductService] getProducts() 호출");

		String safeSearch = (searchText != null && !searchText.trim().isEmpty()) ? searchText.trim() : null;
		String safeTrade = (tradeType != null && !tradeType.trim().isEmpty()) ? tradeType.trim() : null;
		String safeSort = (sort == null || sort.isEmpty()) ? "latest" : sort;
		Integer safeCategory = (categoryNo != null && categoryNo == 0) ? null : categoryNo;

		int offset = (pageInfo.getCurPage() - 1) * pageInfo.getPageSize();
		int limit = pageInfo.getPageSize();

		Map<String, Object> params = new HashMap<>();
		params.put("searchText", safeSearch);
		params.put("categoryNo", safeCategory);
		params.put("tradeType", safeTrade);
		params.put("offset", offset);
		params.put("limit", limit);

		long t1 = System.currentTimeMillis();

		// 거리순 정렬
		if ("distance".equals(safeSort) && userLat != null && userLng != null) {
			System.out.println("📍 거리 기반 정렬 활성화됨");

			List<Product> products = productDAO.selectProducts(params);
			for (Product p : products) {
				if (p.getLatitude() != null && p.getLongitude() != null) {
					double d = getDistance(userLat, userLng, p.getLatitude(), p.getLongitude());
					p.setDistance(d);
				} else {
					p.setDistance(Double.MAX_VALUE); // 거리 없음 처리
				}
			}
			products.sort(Comparator.comparingDouble(Product::getDistance));
			System.out.println("✅ 거리 계산 완료 / 결과 수: " + products.size());
			System.out.println("⏱️ 거리 정렬 포함 소요 시간: " + (System.currentTimeMillis() - t1) + "ms");
			return products;
		}

		// 기본 정렬
		params.put("sort", safeSort);
		List<Product> result = productDAO.selectProducts(params);
		System.out.println("✅ 일반 정렬 결과 수: " + result.size());
		System.out.println("⏱️ selectProducts() 소요 시간: " + (System.currentTimeMillis() - t1) + "ms");

		return result;
	}

	@Override
	public List<Category> getAllCategories() {
		try {
			List<Category> list = categoryDAO.selectCategoryList();
			list.removeIf(c -> !c.getIsActive());
			System.out.println("📦 활성화된 카테고리 수: " + list.size());
			return list;
		} catch (Exception e) {
			throw new RuntimeException("카테고리 조회 실패", e);
		}
	}

	@Override
	public PageInfo getPageInfo(String searchText, String categoryNo, String tradeType, String sort, int page) {
		System.out.println("🟢 [ProductService] getPageInfo() 호출");

		int totalRecord;
		long t1 = System.currentTimeMillis();

		if (searchText != null && !searchText.isBlank()) {
			totalRecord = productDAO.countByName(searchText, tradeType);
			System.out.println("🔎 검색 기준 상품 수: " + totalRecord);
		} else if (categoryNo != null && !categoryNo.isBlank() && !"0".equals(categoryNo)) {
			totalRecord = productDAO.countByCategory(Integer.parseInt(categoryNo), tradeType);
			System.out.println("📁 카테고리 기준 상품 수: " + totalRecord);
		} else {
			totalRecord = productDAO.countAll(tradeType);
			System.out.println("📄 전체 상품 수: " + totalRecord);
		}

		int totalPage = (int) Math.ceil((double) totalRecord / PAGE_SIZE);
		int startPage = ((page - 1) / PAGE_BLOCK) * PAGE_BLOCK + 1;
		int endPage = Math.min(startPage + PAGE_BLOCK - 1, totalPage);

		System.out.println("⏱️ count 소요 시간: " + (System.currentTimeMillis() - t1) + "ms");
		return new PageInfo(page, totalPage, startPage, endPage);
	}

	@Override
	public Product selectProductOne(Integer no) throws Exception {
		System.out.println("📌 [ProductService] selectProductOne() 호출 → no=" + no);
		return productDAO.SelectProductOne(no);
	}

	@Override
	public List<Product> getPopularProducts(int limit) {
		System.out.println("🔥 인기 상품 요청 → limit=" + limit);
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
}