<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/ProductList/list.css" />
</head>
<body>

	<!-- 1) 검색 헤더 -->
	<jsp:include page="/JSP/Header/header1.jsp" />

	<!-- 2) 카테고리 헤더 -->
	<jsp:include page="/JSP/Header/header2.jsp" />

	<!-- 3) 필터 & 정렬 바 (AJAX) -->
	<div class="filter-sort-bar">
		<div class="badge-bar">
			<div
				class="badge badge_total ${empty param.tradeType ? 'active' : ''}"
				data-type="전체">전체</div>
			<div
				class="badge badge_sell ${param.tradeType=='판매' ? 'active' : ''}"
				data-type="판매">판매</div>
			<div
				class="badge badge_rent ${param.tradeType=='대여' ? 'active' : ''}"
				data-type="대여">대여</div>
			<div
				class="badge badge_sell_rent ${param.tradeType=='판매대여' ? 'active' : ''}"
				data-type="판매대여">판매/대여</div>
			<div
				class="badge badge_free ${param.tradeType=='나눔' ? 'active' : ''}"
				data-type="나눔">나눔</div>

		</div>
		<div class="sort-options">
			<span class="${param.sort=='recommend'?'active':''}"
				data-sort="recommend">추천순</span> <span
				class="${param.sort=='latest' or empty param.sort?'active':''}"
				data-sort="latest">최신순</span> <span
				class="${param.sort=='priceAsc'?'active':''}" data-sort="priceAsc">낮은가격순</span>
			<span class="${param.sort=='priceDesc'?'active':''}"
				data-sort="priceDesc">높은가격순</span>
		</div>
	</div>

	<!-- 4) AJAX로 교체될 상품 목록 프래그먼트 -->
	<div id="productList">
		<jsp:include page="/JSP/ProductList/productList.jsp" />
	</div>

	<jsp:include page="/JSP/Header/footer.jsp" />

	<script>
  // 1. 상태 객체: 필터/정렬/검색/카테고리/페이지 저장소
  const state = {
	searchText: '${empty param.searchText ? "" : param.searchText}',
    categoryNo: '${empty param.categoryNo ? "" : param.categoryNo}',
    tradeType:  '${empty param.tradeType ? "" : param.tradeType}',
    sort: 		"${empty param.sort ? 'latest' : param.sort}",
    page: 		1
  };

  // 2. Context path
  const base = '${pageContext.request.contextPath}';

  // 3. 공통 기능: 클릭 시 active 클래스 관리 + state 갱신 + 목록 로드
  function activateAndUpdateState(selectorGroup, targetEl, stateKey, newValue) {
    document.querySelectorAll(selectorGroup).forEach(el => el.classList.remove('active'));
    targetEl.classList.add('active');
    state[stateKey] = newValue;
    state.page = 1;
    loadProducts();
  }

  // 4. 상품 목록 비동기 로드
function loadProducts() {
	  /* if (state.categoryNo === "") state.categoryNo = null; */
	  if (state.tradeType === "전체" || state.tradeType === "") state.tradeType = null;
  $.ajax({
    url: base + '/productList',
    type: 'GET',
    data: state, // state 객체 전체를 쿼리스트링으로 전달
    success: function(html) {
      // 서버로부터 받은 상품 목록 HTML을 지정된 영역에 삽입
      document.getElementById('productList').innerHTML = html;

      // 동적으로 추가된 요소에 다시 이벤트 연결
      attachPaging();
      attachAllEventHandlers();

   	  // tradeType이 있으면 해당 필터 뱃지 활성화, 없으면 '전체' 뱃지
      if (state.tradeType) {
    	  updateActive('.badge', 'data-type', state.tradeType || '전체');
      }

      // 정렬 옵션 활성화
      if (state.sort) {
        updateActive('.sort-options span', 'data-sort', state.sort);
      }

      // categoryNo가 존재할 때만 active 처리
      if (state.categoryNo) {
        updateActive('.category-item', 'data-categoryNo', String(state.categoryNo));
      }

    },
    error: function(xhr, status, error) {
      console.error('AJAX 오류 발생:', error);
    }
  });
}


  // 5. active 클래스 갱신 유틸
  function updateActive(selector, attr, value) {
    if (!selector || !attr || !value) return;
    document.querySelectorAll(selector).forEach(e => e.classList.remove('active'));
    const target = document.querySelector(`${selector}[${attr}="${value}"]`);
    if (target) target.classList.add('active');
  }

  // 6. 페이징 이벤트 연결
  function attachPaging() {
    document.querySelectorAll('#paging a[data-page]').forEach(a => {
      a.onclick = e => {
        e.preventDefault();
        state.page = a.dataset.page;
        loadProducts();
      };
    });
  }

  // 7. 필터 / 정렬 / 카테고리 클릭 이벤트 연결
  function attachAllEventHandlers() {
    // 필터 (badge)
    document.querySelectorAll('.badge').forEach(el => {
      el.onclick = () => {
        activateAndUpdateState('.badge', el, 'tradeType', el.dataset.type);
      };
    });

    // 정렬 (sort span)
    document.querySelectorAll('.sort-options span').forEach(el => {
      el.onclick = () => {
        activateAndUpdateState('.sort-options span', el, 'sort', el.dataset.sort);
      };
    });

    // 카테고리 (category-item)
    document.querySelectorAll('.category-item').forEach(el => {
      el.onclick = () => {
        activateAndUpdateState('.category-item', el, 'categoryNo', el.dataset.categoryNo || '');
      };
    });
  }

  // 8. 최초 로딩 시 실행
  loadProducts();
</script>

</body>
</html>