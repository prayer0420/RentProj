<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    <%@ page import="dto.Member" %>
    <% 
    	Member id = (Member) request.getAttribute("loginId");
    %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Product List</title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/mySell.css">
</head>
<body>
	 <div class="wrapper">
      <div class="container">
        <!-- 사이드바 -->
        <jsp:include page="/JSP/MyPage/mypageSidebar.jsp" />

        <!-- 콘텐츠 영역 -->
        <section class="content">
          <h2>판매 상품</h2>
          <div class="divider"></div>

          <!-- 드롭다운 메뉴 영역 -->
          <div class="filter-section">
            <select class="filter-dropdown" name="period">
              <option value="">조회 기간 선택</option>
              <option value="12months">전체</option>
              <option value="7days">최근 7일</option>
              <option value="1month">1개월</option>
              <option value="3months">3개월</option>
              <option value="6months">6개월</option>
            </select>

            <select class="filter-dropdown" name="status">
              <option value="">배송 상태 선택</option>
              <option value="all">전체</option>
              <option value="">상품준비중</option>
              <option value="">배송중</option>
              <option value="">배송완료</option>
              <option value="">거래완료</option>
            </select>
          </div>

          <!-- 상품 카드 1 -->
          <c:forEach var="item" items="${productList }">
          <form action="">
	          <div class="product-card" id="product">
	            <!-- 주문 정보 상단 영역 -->
	            <div class="order-info">
	              <div class="order-meta">
	                <span class="order-date">상품등록일: ${item.createDate}</span>
	                <span class="status-text">거래중</span>
	              </div>
	              <div class="order-status-area">
	                <a href="${contextPath }/mySellDetail?orderNo=${item.orderNo }" class="order-detail-link">거래 상세보기 &gt;</a>
	              </div>
	            </div>
	
	            <!-- 구분선 -->
	            <div class="card-divider"></div>
	
	            <!-- 상품 정보 영역 -->
	            <div class="card-content">
	              <img
	                src="${contextPath }/img/camera.jpg"
	                alt="상품 이미지"
	                class="product-image"
	              />
	              <div class="product-info">
	                <p>${item.no }</p>
	                <h3>${item.title }</h3>
	                <p>가격: ${item.salePrice }원</p>
	                <p>배송비: ${item.deliveryPrice}원</p>
	              </div>
	              <div class="status-change-btns">
	                <button type="submit" id="confrim-order">송장번호입력</button>
	                <button
	                  onclick="openModalWith('주문을 취소하시겠습니까?', cancelOrder)"
	                >
	                  주문취소
	                </button>
	              </div>
	            </div>
	          </div>
          </form>
          </c:forEach>
        </section>
      </div>
    </div>

    <!-- 재사용 가능한 모달 -->
    <div id="universalModal" class="modal-overlay">
      <div class="modal-content">
        <p id="modalMessage">여기에 메시지가 들어갑니다</p>
        <div class="modal-buttons">
          <button onclick="handleModalConfirm()">확인</button>
          <button onclick="closeModal()">취소</button>
        </div>
      </div>
    </div>

    <!-- 자바스크립트 코드 -->
    <script>
      function toggleSubmenu(clickedTitle) {
        const menuItem = clickedTitle.parentElement;

        if (menuItem.classList.contains("active")) {
          menuItem.classList.remove("active");
        } else {
          document
            .querySelectorAll(".menu-item")
            .forEach((item) => item.classList.remove("active"));
          menuItem.classList.add("active");
        }
      }

      /* 모달창 관련: 메시지, 콜백 함수 코드 */
      let modalConfirmCallback = null;

      function openModalWith(message, onConfirmCallback) {
        document.getElementById("modalMessage").textContent = message;
        modalConfirmCallback = onConfirmCallback;
        document.getElementById("universalModal").style.display = "flex";
      }

      function handleModalConfirm() {
        if (typeof modalConfirmCallback === "function") {
          modalConfirmCallback();
        }
        closeModal();
      }

      function closeModal() {
        document.getElementById("universalModal").style.display = "none";
      }

      // 각각의 동작 정의
      function deleteProduct() {
        alert("상품을 삭제합니다");
        // 실제 삭제 API 호출 등
      }

      function hideProduct() {
        alert("상품을 숨깁니다");
      }

      function cancelOrder() {
        alert("주문을 취소합니다");
      }
    </script>

</body>
</html>