package service.order;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dao.order.OrderDAO;
import dao.order.OrderDAOImpl;
import dto.Order;
import utils.MybatisSqlSessionFactory;
import utils.PageInfo;

public class OrderServiceImpl implements OrderService {
	OrderDAO orderDAO;

	public OrderServiceImpl() {
		orderDAO = new OrderDAOImpl();
	}

	@Override
	public void insertOrder(Order order) throws Exception {
		orderDAO.insertOrder(order);
	}

	// 관리자 전체 주문 조회용
	@Override
	public List<Order> searchOrders(Map<String, Object> params, PageInfo pageInfo) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		List<Order> orderList = new ArrayList<>();

		try {
			OrderDAO dao = new OrderDAOImpl();

			// 1. 검색 조건에 따른 총 주문 수 조회
			int totalCnt = dao.getOrderCount(params);

			// 2. 검색 결과가 없으면 페이지 정보 초기화 후 빈 리스트 반환
			if (totalCnt == 0) {
				pageInfo.setAllPage(0);
				pageInfo.setStartPage(0);
				pageInfo.setEndPage(0);
				pageInfo.setTotalCount(0);
				return orderList;
			}

			// 3. 페이징 정보 계산
			int pageSize = pageInfo.getPageSize();
			int curPage = pageInfo.getCurPage();
			int allPage = (int) Math.ceil((double) totalCnt / pageSize);
			int startPage = (curPage - 1) / 10 * 10 + 1;
			int endPage = Math.min(startPage + 9, allPage);

			pageInfo.setAllPage(allPage);
			pageInfo.setStartPage(startPage);
			pageInfo.setEndPage(endPage);
			pageInfo.setTotalCount(totalCnt);

			// 4. LIMIT 시작 인덱스 계산 및 검색 파라미터 설정
			int row = (curPage - 1) * pageSize;
			params.put("row", row);
			params.put("size", pageSize);

			// 5. 최종 주문 목록 조회
			orderList = dao.searchOrders(params);

		} catch (Exception e) {
			e.printStackTrace(); // 예외 로깅
		} finally {
			sqlSession.close(); // 세션 자원 해제
		}

		return orderList;
	}

	@Override
	public boolean hasMemberOrderProduct(Integer memberNo, Integer productNO) throws Exception {
		return orderDAO.hasMemberOrderProduct(memberNo, productNO) > 0;
	}

	@Override
	public boolean checkOrder(Integer productNo) throws Exception {
		return orderDAO.checkOrder(productNo) > 0;
	}
}
