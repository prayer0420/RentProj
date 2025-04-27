<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ page import="dto.Member" %>
    <% 
    	String id = (String) request.getAttribute("loginId");
    %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Product List</title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/mySell.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
          <h2>판매 상품</h2>
          <div class="divider"></div><br>
          
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
		                <span class="order-date">상품등록일: <fmt:formatDate value="${item.createDate}" pattern="yyyy년 MM월 dd일"/> </span>
		              </div>
		              <div class="order-status-area">
		              	  <span class="status-text">${item.deliveryStatus }</span>&nbsp;&nbsp;
		                  <span class="status-text">${item.orderStatus }</span>
			              <c:choose>
			              	<c:when test="${item.orderNo eq null }">
			              		<span>&nbsp;</span>
			              	</c:when>
			              	<c:otherwise>
			                	<a href="${contextPath }/mySellDetail?orderNo=${item.orderNo }" class="order-detail-link">거래 상세보기 &gt;</a>
			                </c:otherwise>
			              </c:choose>
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
		               <c:choose>
		               	<c:when test="${item.deliveryStatus eq '상품게시중'}">
					        <button type="button" class="open-invoice-btn" data-orderno="${item.orderNo}">상품숨김</button><br>
					        <button type="button" class="open-invoice-btn" data-orderno="${item.orderNo}">상품삭제</button>
					        
		               	</c:when>
		               	<c:when test="${item.orderStatus eq '결제완료'}">
					        <button type="button" class="open-invoice-btn" data-orderno="${item.orderNo}">송장번호입력</button>
		               	</c:when>
		               	<c:when test="${item.orderStatus eq '배송완료'}">
					        <button type="button" class="open-invoice-btn" data-orderno="${item.orderNo}">대여거래종료</button>
		               	</c:when>
		               </c:choose>
		              </div>
		            </div>
		          </div>
	          </form>
	          </c:forEach>
          		
	          <!-- 페이징 처리 --> 
	          <br>
				<jsp:include page="/JSP/MyPage/mypagePaging.jsp" > 
					<jsp:param name="baseUrl" value="${contextPath }/mySell" />
				</jsp:include>
			
			</c:otherwise>
		</c:choose>
		
        </section>
      </div>
    </div>
					
		<!-- 푸터 -->
		  <jsp:include page="/JSP/Header/footer.jsp" />


          <!-- 송장번호입력 모달 -->
          <jsp:include page="/JSP/MyPage/mypageModal.jsp" />
					
</body>
</html>