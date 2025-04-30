<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }" />     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Rent Detail</title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/myRentDetail.css">
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
          <h2>빌리기 상세</h2>
          <div class="divider"></div>
          
          <c:choose>
			<c:when test="${id eq null }">
				<span> 로그인이 필요한 페이지입니다.</span>
			</c:when>
			<c:otherwise>
          
	          <div class="section product-box">
	          	<a href="${contextPath }/productDetail?no=${myRentDetail.no }">
	                <img src="${contextPath }/img/bicycle.jpg" alt="자전거"></a>
	                <div class="product-info">
	                    <div style="font-size: 13px; color: gray;">
	                    <a href="${contextPath }/productDetail?no=${myRentDetail.no }">상품번호 ${myRentDetail.productNo }</a></div>
	                    <div class="product-title">
	                    <a href="${contextPath }/productDetail?no=${myRentDetail.no }">${myRentDetail.title }</a></div>
	                    <div class="price">1일 <fmt:formatNumber value="${myRentDetail.rentPrice }" type="number" groupingUsed="true" />원</div>
	                </div>
	                <span class="status-text">${myRentDetail.orderStatus }</span>
	            </div>
	
	            <div class="info-grid">
	                <div class="info-box">
	                    <h4>배송정보</h4>
	                    <p>송장번호: ${myRentDetail.invoiceNo }</p>
	                    <p>택배사: ${myRentDetail.deliveryComp }</p>
	                    <p>배송지: ${myRentDetail.deliveryAddr }</p>
	                </div>
	                <div class="info-box">
	                    <h4>판매자 정보</h4>
	                    <p>아이디: ${myRentDetail.memberId }</p>
	                    <p>연락처: ${myRentDetail.phone }</p>
	                    <p>반환배송지: ${myRentDetail.address1 }</p>
	                    <!-- <button class="btn">판매자의 다른 상품-></button>	 -->
	                    
	                </div>
	            </div>
	
	            <div class="info-grid" style="margin-top: 20px;">
	                <div class="info-box">
	                    <h4>대여 기간</h4>
	                    <fmt:parseDate value='${myRentDetail.orderDate}' pattern="yyyy-MM-dd" var='orderDate'/>
	                    <p>대여 신청일 <fmt:formatDate value="${orderDate }" pattern="yyyy년 MM월 dd일"/> </p>
	                    <fmt:parseDate value='${myRentDetail.startDate}' pattern="yyyy-MM-dd" var='startDate'/>
	                    <p>대여 시작일 <fmt:formatDate value="${startDate }" pattern="yyyy년 MM월 dd일"/> </p>
	                    <fmt:parseDate value='${myRentDetail.endDate}' pattern="yyyy-MM-dd" var='endDate'/>
	                    <p><strong>대여 종료일 <fmt:formatDate value="${endDate }" pattern="yyyy년 MM월 dd일"/></strong></p>
	                    <p><strong>상품 회수일 </strong></p> 
	                    
	                </div>
	                <div class="info-box">
	                    <h4>결제정보</h4>
	                    <p><strong>총 결제금액: <fmt:formatNumber value="${myRentDetail.deliveryPrice + myRentDetail.rentPrice + myRentDetail.secPrice }" type="number" groupingUsed="true" />원 </strong></p>
	                    <p>1일 이용금액: <fmt:formatNumber value="${myRentDetail.rentPrice }" type="number" groupingUsed="true"/>원 &nbsp;&nbsp;<strong>총 3일 이용</strong></p>
	                    <p>보증금: <fmt:formatNumber value="${myRentDetail.secPrice}" type="number" groupingUsed="true" />원</p>
	                    <p>배송비: <fmt:formatNumber value="${myRentDetail.deliveryPrice}" type="number" groupingUsed="true" />원</p>
	                </div>
	            </div>
            </c:otherwise>
            </c:choose>
          </section>
        </div>
    </div>
    
    <!-- 푸터 -->
	<jsp:include page="/JSP/Header/footer.jsp" />

</body>
</html>