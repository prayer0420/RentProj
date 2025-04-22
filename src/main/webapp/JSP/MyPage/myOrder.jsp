<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="contextPath" value="${pageContext.request.contextPath }" />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Order List</title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/myOrder.css">
</head>
<body>
<!-- 헤더 (로고 + 검색창 + 카테고리) -->
  <jsp:include page="/JSP/Header/header.jsp" />
  
	<div class="wrapper">
      <div class="container">
        <!-- 사이드바 -->
        <jsp:include page="/JSP/MyPage/mypageSidebar.jsp" />

        <!-- 콘텐츠 영역 -->
        <section class="content">
          <h2>구매한 상품</h2>
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
              <option value="preparing">배송준비중</option>
              <option value="shipping">배송중</option>
              <option value="delivered">배송완료</option>
              <option value="cancelled">주문취소</option>
            </select>
          </div>

          <!-- 상품 카드 1 -->
          <div class="product-card">
            <!-- 주문 정보 상단 영역 -->
            <div class="order-info">
              <div class="order-meta">
                <span class="order-number">주문번호: 2025040801</span>
                <span class="order-date">주문일: 2025-04-08</span>
              </div>
              <div class="order-status-area">
                <span class="status-text">주문완료</span>
                <a href="#" class="order-detail-link">주문 상세보기 &gt;</a>
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
                <p>7890123456</p>
                <h3>
                  앤디워홀 카메라! 1975년 생산된 Konica35EF 필름카메라
                  판매(생활기스 있음)
                </h3>
                <p>가격: 200,000원</p>
                <p>배송비: 2,500원</p>
              </div>
              <div class="status-change-btns">
                <button
                  onclick="openModalWith('주문을 취소하시겠습니까?', cancelOrder)"
                >
                  주문취소
                </button>
              </div>
            </div>
          </div>

          <!-- 상품 카드 2 -->
          <div class="product-card">
            <!-- 주문 정보 상단 영역 -->
            <div class="order-info">
              <div class="order-meta">
                <span class="order-number">주문번호: 2025040801</span>
                <span class="order-date">주문일: 2025-04-08</span>
              </div>
              <div class="order-status-area">
                <span class="status-text">상품준비중</span>
                <a href="#" class="order-detail-link">주문 상세보기 &gt;</a>
              </div>
            </div>

            <!-- 구분선 -->
            <div class="card-divider"></div>

            <!-- 상품 정보 영역 -->
            <div class="card-content">
              <img
                src="${contextPath }/img/bicycle.jpg"
                alt="상품 이미지"
                class="product-image"
              />
              <div class="product-info">
                <p>7890123456</p>
                <h3>빈티지 감성의 성인용 자전거 팝니다 (사용감 조금 있음)</h3>
                <p>가격: 100,000원</p>
                <p>배송비: 무료</p>
              </div>
              <div class="status-change-btns">
                <button
                  onclick="openModalWith('주문을 취소하시겠습니까?', cancelOrder)"
                >
                  주문 취소
                </button>
              </div>
            </div>
          </div>

          <!-- 상품 카드 3 -->
          <div class="product-card">
            <!-- 주문 정보 상단 영역 -->
            <div class="order-info">
              <div class="order-meta">
                <span class="order-number">주문번호: 2365478965</span>
                <span class="order-date">주문일: 2025-02-08</span>
              </div>
              <div class="order-status-area">
                <span class="status-text">거래완료</span>
                <a href="#" class="order-detail-link">주문 상세보기 &gt;</a>
              </div>
            </div>

            <!-- 구분선 -->
            <div class="card-divider"></div>

            <!-- 상품 정보 영역 -->
            <div class="card-content">
              <img
                src="${contextPath }/img/watering-can.jpg"
                alt="상품 이미지"
                class="product-image"
              />
              <div class="product-info">
                <p>4567890987</p>
                <h3>화분 물뿌리개(새 제품)</h3>
                <p>가격: 5,000원</p>
                <p>배송비: 2,500원</p>
              </div>
              <div class="status-change-btns">
                <button onclick="openModalWith('구매를 확정하시겠습니까?', confirmOrder)">구매확정</button>
                <button onclick="openModalWith('주문을 취소하시겠습니까?', cancelOrder)">주문취소</button>
              </div>
            </div>
          </div>
        </section>
      </div>
    </div>

<!-- 푸터 -->
  <jsp:include page="/JSP/Header/footer.jsp" />
  
  
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
      
      function cancelOrder() {
        alert("주문을 취소합니다");
      }
      
      function confirmOrder() {
          alert("구매를 확정합니다");
        }
    </script>

</body>
</html>