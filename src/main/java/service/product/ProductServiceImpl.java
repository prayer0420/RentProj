package service.product;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

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

	// 상품 목록 조회 (검색, 카테고리, 거래유형, 정렬, 페이징)
	@Override
	public List<Product> getProducts(String searchText, Integer categoryNo, String tradeType, String sort,
			PageInfo pageInfo) {
		// 입력값 확인 (null, 빈 문자열 방지)
		String safeSearch = (searchText != null && !searchText.trim().isEmpty()) ? searchText.trim() : null;
		String safeTrade = (tradeType != null && !tradeType.trim().isEmpty()) ? tradeType.trim() : null;
		String safeSort = (sort == null || sort.isEmpty()) ? "latest" : sort;
		Integer safeCategory = (categoryNo != null && categoryNo == 0) ? null : categoryNo;

		// 페이징 계산
		int offset = (pageInfo.getCurPage() - 1) * pageInfo.getPageSize();
		int limit = pageInfo.getPageSize();

		// 파라미터 구성
		Map<String, Object> params = new HashMap<>();
		params.put("searchText", safeSearch);
		params.put("categoryNo", safeCategory);
		params.put("tradeType", safeTrade);
		params.put("sort", safeSort);
		params.put("offset", offset);
		params.put("limit", limit);

		return productDAO.selectProducts(params);
	}

	// 전체 카테고리 목록 조회 (isActive == true 인 경우만)
	@Override
	public List<Category> getAllCategories() {
		List<Category> list;
		try {
			list = categoryDAO.selectCategoryList();
		} catch (Exception e) {
			throw new RuntimeException("카테고리 조회 실패", e);
		}
		// 활성화된 카테고리만 남기기
		list.removeIf(c -> !c.getIsActive()); // c.getIsActive()가 boolean(primitive)일 경우
		return list;
	}

	@Override
	public PageInfo getPageInfo(String searchText, String categoryNo, String tradeType, String sort, int page) {
		int totalRecord;
		if (searchText != null && !searchText.isBlank()) {
			totalRecord = productDAO.countByName(searchText, tradeType);
		} else if (categoryNo != null && !categoryNo.isBlank() && !"0".equals(categoryNo)) {
			totalRecord = productDAO.countByCategory(Integer.parseInt(categoryNo), tradeType);
		} else {
			totalRecord = productDAO.countAll(tradeType);
		}

		int totalPage = (int) Math.ceil((double) totalRecord / PAGE_SIZE);
		int startPage = ((page - 1) / PAGE_BLOCK) * PAGE_BLOCK + 1;
		int endPage = Math.min(startPage + PAGE_BLOCK - 1, totalPage);

		return new PageInfo(page, totalPage, startPage, endPage);
	}

	// sort 키워드를 DB ORDER BY 절로 변환
	private String resolveSort(String sort) {
		if ("recommend".equals(sort)) {
			return "view_count DESC";
		} else if ("priceAsc".equals(sort)) {
			// COALESCE(a, b) = a != NULL ? a : b
			return "COALESCE(salePrice, rentPrice) ASC";
		} else if ("priceDesc".equals(sort)) {
			return "COALESCE(salePrice, rentPrice) DESC";
		} else { // latest 기본
			return "createDate DESC";
		}
	}
	@Override
	public Product selectProductOne(Integer no) throws Exception {
		return productDAO.SelectProductOne(no);
	}

	@Override
	public List<Product> getPopularProducts(int limit) {
		return productDAO.selectPopularProducts(limit);
	}

	// 위치가져오기
	@Override
	public List<Product> getProductsNearby(double userLat, double userLng, double radiusKm) {
		List<Product> allProducts = productDAO.selectAll();
		List<Product> result = new ArrayList<>();
		System.out.println(allProducts);
		for (Product p : allProducts) {
			String addr = p.getDeliveryAddr();
			double[] coords = getLatLngFromAddr(addr);
			if (coords == null)
				continue;

			double distance = getDistance(userLat, userLng, coords[0], coords[1]);
			if (distance <= radiusKm) {
				result.add(p);
			}
			//5개 까지만
			if (result.size() >= 5) break;
		}
		return result;
	}

	private double[] getLatLngFromAddr(String addr) {
		try {
			String encoded = URLEncoder.encode(addr, "UTF-8");
			String url = "https://dapi.kakao.com/v2/local/search/address.json?query=" + encoded;

			HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "KakaoAK 26cbd2829d45a2e79ba779ab7d6c059c");

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = br.readLine()) != null)
				sb.append(line);
			br.close();

			JsonObject json = JsonParser.parseString(sb.toString()).getAsJsonObject();
			JsonArray documents = json.getAsJsonArray("documents");
			if (documents.size() == 0)
				return null;

			JsonObject doc = documents.get(0).getAsJsonObject();
			double lat = doc.get("y").getAsDouble();
			double lng = doc.get("x").getAsDouble();

			return new double[] { lat, lng };
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	private double getDistance(double lat1, double lon1, double lat2, double lon2) {
		double R = 6371; // km
		double dLat = Math.toRadians(lat2 - lat1);
		double dLon = Math.toRadians(lon2 - lon1);
		double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(Math.toRadians(lat1))
				* Math.cos(Math.toRadians(lat2)) * Math.sin(dLon / 2) * Math.sin(dLon / 2);
		double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
		return R * c;
		
	}

	@Override
	public List<Product> getAll(String tradeType, String sort, int page) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Product> searchByName(String name, String tradeType, String sort, int page) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Product> searchByCategory(int categoryNo, String tradeType, String sort, int page) {
		// TODO Auto-generated method stub
		return null;
	}

}
