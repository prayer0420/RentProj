<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Order Detail</title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/myOrderDetail.css">
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
          <h2>주문 상세</h2>
          <div class="divider"></div>
          
          <c:choose>
			<c:when test="${id eq null }">
				<span> 로그인이 필요한 페이지입니다.</span>
			</c:when>
			<c:otherwise>
			
          <div class="section product-box">
                <a href="${contextPath }/productDetail?no=${myOrderDetail.no}">
                <img src="https://via.placeholder.com/120x100?text=🚲" alt="자전거"></a>
                <div class="product-info">
                    <div style="font-size: 13px; color: gray;">
                    	<a href="${contextPath }/productDetail?no=${myOrderDetail.no}">상품번호: ${myOrderDetail.productNo }</a></div>
                    <div class="product-title">
                    	<a href="${contextPath }/productDetail?no=${myOrderDetail.no}">${myOrderDetail.title }</a></div>
                    <div class="price">판매가격: <fmt:formatNumber value="${myOrderDetail.salePrice}" type="number" groupingUsed="true" /> 원</div>
                </div>
                <span class="status-text">${myOrderDetail.orderStatus}</span>
            </div>

            <div class="info-grid">
            	<div class="info-box">
                    <h4>주문 정보</h4>
                    <p>주문번호: ${myOrderDetail.orderId}</p>
                    <p>주문완료일: <fmt:formatDate value="${myOrderDetail.orderDate}" pattern="yyyy년 MM월 dd일" /></p>
                    <p>거래상태: <strong>${myOrderDetail.orderStatus}</strong></p>
                    <p>&nbsp;&nbsp;</p>
                </div>
                
                <div class="info-box">
                    <h4>판매자 정보</h4>
                    <p>아이디: ${myOrderDetail.id }</p>
                    <p>연락처: ${myOrderDetail.phone }</p>
                    <p>&nbsp;&nbsp;</p>
                    
                    <!-- <button class="btn">판매자의 다른 상품-></button>  -->
                    
                </div>
                
            </div>

            <div class="info-grid" style="margin-top: 20px;">
                <div class="info-box">
                    <h4>배송정보</h4>
                    <p>송장번호: ${myOrderDetail.invoiceNo }</p>
                    <p>택배사: ${myOrderDetail.deliveryComp }</p>
                    <p>받는이: ${myOrderDetail.name}</p>
                    <p>배송지: ${myOrderDetail.deliveryAddr }</p>
                </div>
                
                <div class="info-box">
                    <h4>결제정보</h4>
                    <p><strong>총 결제금액: <fmt:formatNumber value="${myOrderDetail.salePrice + myOrderDetail.deliveryprice}" type="number" groupingUsed="true"/>원</strong> </p>
                    <p>구매가격: <fmt:formatNumber value="${myOrderDetail.salePrice}" type="number" groupingUsed="true" />원</p>
                    <p>배송비: <fmt:formatNumber value="${myOrderDetail.deliveryprice}" type="number" groupingUsed="true" /> 원</p>
                    <p>결제방법: ${myOrderDetail.paymentType}</p>
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