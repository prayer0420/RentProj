<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>상품 목록</title>
  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- 상품 리스트 CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/ProductList/list.css">
</head>
<body>

  <!-- 1. 상단 공통 헤더 (로고 + 검색창 + 카테고리 버튼) -->
  <jsp:include page="/JSP/Header/header.jsp" />

  <%-- <!-- 2. 카테고리 헤더 (카테고리 버튼 영역) -->
  <jsp:include page="/JSP/Header/header2.jsp" /> --%>

  <!-- 3. 거래유형 필터 + 정렬 버튼 영역 -->
  <div class="filter-sort-bar">
    <!-- 거래유형 필터 뱃지 -->
    <div class="badge-bar">
      <div class="badge badge_total ${empty param.tradeType ? 'active' : ''}" data-type="전체">전체</div>
      <div class="badge badge_sell ${param.tradeType=='판매' ? 'active' : ''}" data-type="판매">판매</div>
      <div class="badge badge_rent ${param.tradeType=='대여' ? 'active' : ''}" data-type="대여">대여</div>
      <div class="badge badge_sell_rent ${param.tradeType=='판매대여' ? 'active' : ''}" data-type="판매대여">판매/대여</div>
      <div class="badge badge_free ${param.tradeType=='무료나눔' ? 'active' : ''}" data-type="무료나눔">나눔</div>
    </div>

    <!-- 정렬 옵션 -->
    <div class="sort-options">
      <span class="${param.sort=='latest' or empty param.sort ? 'active' : ''}" data-sort="latest">최신순</span>
      <span class="${param.sort=='distance' ? 'active' : ''}" data-sort="distance">거리순</span>
      <span class="${param.sort=='priceAsc' ? 'active' : ''}" data-sort="priceAsc">낮은가격순</span>
      <span class="${param.sort=='priceDesc' ? 'active' : ''}" data-sort="priceDesc">높은가격순</span>
    </div>
  </div>

  <!-- 4. 상품 목록 영역 (AJAX로 바뀌는 영역) -->
  <div id="productList">
    <jsp:include page="/JSP/ProductList/productList.jsp" />
  </div>

  <!-- 5. 푸터 -->
  <jsp:include page="/JSP/Header/footer.jsp" />

  <!-- 6. 필터, 정렬, 페이징, 상품목록 AJAX 처리 JS -->
  <script>
    // 1. 상태 저장용 객체 (서버에 보낼 파라미터)
    const state = {
      searchText: '${fn:escapeXml(param.searchText)}',
      categoryNo: '${empty param.categoryNo ? "0" : param.categoryNo}',
      tradeType: '${param.tradeType}',
      sort: '${empty param.sort ? "latest" : param.sort}',
      page: ${param.page != null && param.page != "" ? param.page : 1}
    };

    // 2. contextPath (URL 경로 앞에 붙이기용)
    const base = '${pageContext.request.contextPath}';

    // 3. 상품 목록을 서버에서 AJAX로 불러오기
    function loadProducts() {
      // "전체"는 tradeType null로 처리
      if (state.tradeType === "전체" || !state.tradeType) state.tradeType = null;

      $.ajax({
        url: base + '/productList', // 서블릿 or 컨트롤러
        type: 'GET',
        data: state,
        success: function(html) {
          // 받아온 HTML로 상품 목록 영역 교체
          document.getElementById('productList').innerHTML = html;
          // 이벤트 재연결
          attachPaging();
          attachFilterEvents();
          attachSortEvents();
        },
        error: function(xhr, status, error) {
          console.error('AJAX 오류:', error);
        }
      });
    }

    // 4. 페이징 버튼 이벤트 연결
    function attachPaging() {
      document.querySelectorAll('#paging a[data-page]').forEach(a => {
        a.onclick = e => {
          e.preventDefault();
          state.page = a.dataset.page;
          loadProducts();
        };
      });
    }

    // 5. 거래유형 필터 버튼 이벤트 연결
    function attachFilterEvents() {
      document.querySelectorAll('.badge').forEach(el => {
        el.onclick = () => {
          // 모든 필터 버튼 비활성화 → 클릭된 필터만 active
          document.querySelectorAll('.badge').forEach(b => b.classList.remove('active'));
          el.classList.add('active');
          state.tradeType = el.dataset.type;
          state.page = 1;
          loadProducts();
        };
      });
    }

    // 6. 정렬 버튼 이벤트 연결
    function attachSortEvents() {
      document.querySelectorAll('.sort-options span').forEach(el => {
        el.onclick = () => {
          // 모든 정렬 옵션 비활성화 → 클릭된 정렬만 active
          document.querySelectorAll('.sort-options span').forEach(s => s.classList.remove('active'));
          el.classList.add('active');
          state.sort = el.dataset.sort;
          state.page = 1;
          loadProducts();
        };
      });
    }

    // 7. 페이지 최초 로딩 시 실행
    document.addEventListener("DOMContentLoaded", () => {
      loadProducts();
      attachFilterEvents();
      attachSortEvents();
      attachPaging();  
    });
  </script>

</body>
</html>
