<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
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

		<c:choose>
			<c:when test="${id eq null }">
				<span> 로그인이 필요한 페이지입니다.</span>
			</c:when>
			<c:otherwise>
			
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
		          <c:forEach var="item" items="${orderList }">
		          <form action="">
			          <div class="product-card">
			            <!-- 주문 정보 상단 영역 -->
			            <div class="order-info">
			              <div class="order-meta">
			                <span class="order-number">주문번호: ${item.orderId }</span>
			                <span class="order-date">주문일: <fmt:formatDate value="${item.orderDate }" pattern="yyyy년 MM월 dd일"/> </span>
			              </div>
			              <div class="order-status-area">
			                <span class="status-text">${item.orderStatus }</span>
			                <a href="${contextPath }/myOrderDetail?orderNo=${item.orderNo }" class="order-detail-link">주문 상세보기 &gt;</a>
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
			                <p>상품번호: ${item.productNo}</p>
			                <h3>${item.title }</h3>
			                <p>가격: <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" />원</p>
			                <p>배송비: <fmt:formatNumber value="${item.deliveryPrice}" type="number" groupingUsed="true" />원</p>
			              </div>
			              <div class="status-change-btns">
			              <c:choose>
				                <c:when test="${item.orderStatus eq '결제완료'}">
							        <button type="button" class="open-cancel-btn" data-orderno="${item.orderNo}">주문취소</button>
							   </c:when> 
							   <c:when test="${item.orderStatus eq '배송완료'}">
							        <button type="button" class="open-confirm-btn" data-orderno="${item.orderNo}">구매확정</button>
							   </c:when>
							   <c:when test="${item.orderStatus eq '구매완료'}">
							        <button type="button" class="open-review-btn" data-orderno="${item.orderNo}">리뷰쓰러가기</button>
							   </c:when>  
							   <c:otherwise>
								    <span>처리 불가능한 상태</span>
							   </c:otherwise>
						   </c:choose>
			              </div>
			            </div>
			          </div>
		          </form>
		          </c:forEach>
		          
		          <!-- 페이징 처리 --> 
		          <br>
					<jsp:include page="/JSP/MyPage/mypagePaging.jsp" >
						<jsp:param name="baseUrl" value="${contextPath }/myOrder" />
					</jsp:include>
				
				</c:otherwise>
			</c:choose>

        </section>
      </div>
    </div>

<!-- 푸터 -->
  <jsp:include page="/JSP/Header/footer.jsp" />

</body>
</html>