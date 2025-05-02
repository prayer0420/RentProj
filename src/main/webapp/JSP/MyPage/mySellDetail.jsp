<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Selling Detail </title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/mySellDetail.css">
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
          <h2>판매 상세</h2>
          <div class="divider"></div>
          
          <div class="section product-box">
                <a href="${contextPath }/productDetail?no=${mySellDetail.no}&tradeType=판매">
                <img src="https://via.placeholder.com/120x100?text=🚲" alt="자전거" /></a>
                <div class="product-info">
                    <div style="font-size: 13px; color: gray;"><a href="${contextPath }/productDetail?no=${mySellDetail.no}&tradeType=판매">상품번호 ${mySellDetail.no }</a></div>
                    <div class="product-title"><a href="${contextPath }/productDetail?no=${mySellDetail.no}&tradeType=판매">${mySellDetail.title }</a></div>
                    <div class="price"><fmt:formatNumber value="${mySellDetail.salePrice}" type="number" groupingUsed="true" />원</div>
                </div>
            </div>

            <div class="info-grid">
                <div class="info-box">
                    <h4>배송정보</h4>
                    <p>송장번호: ${mySellDetail.invoiceNo }</p>
                    <p>택배사: ${mySellDetail.deliveryComp }</p>
                    <p>배송지: ${mySellDetail.deliveryAddr }</p>
                </div>
                <div class="info-box">
                    <h4>구매 회원</h4>
                    <p>아이디:&nbsp; ${mySellDetail.id}</p>
                    <p>연락처:&nbsp; ${mySellDetail.phone }</p>
                    <p>기본배송지: ${mySellDetail.deliveryAddr }</p>
                </div>
            </div>

            <div class="info-grid" style="margin-top: 20px;">
                <div class="info-box">
                    <h4>주문 정보</h4>
                    <p>주문번호: ${mySellDetail.orderId }</p>
                    <p>주문일: <fmt:formatDate value="${mySellDetail.orderDate}" pattern="yyyy년 MM월 dd일" /> </p>
                    <p>상품출고일: </p>
                    <p>구매확정일: </p>
                    <p>&nbsp;&nbsp;</p>
                </div>
                <div class="info-box">
                    <h4>결제정보</h4>
                    <p class="highlight-red"><strong>총 결제금액: <fmt:formatNumber value="${mySellDetail.salePrice + mySellDetail.deliveryPrice}" type="number" groupingUsed="true"/>원</strong></p>
                    <p>판매가: <fmt:formatNumber value="${mySellDetail.salePrice }" type="number" groupingUsed="true"/>원</p>
                    <p>배송비: <fmt:formatNumber value="${empty mySellDetail.deliveryPrice ? 0 : mySellDetail.deliveryPrice}" type="number" groupingUsed="true"/>원</p>
                    <p>결제수단: ${mySellDetail.paymentType }</p>
                </div>
            </div>
          </section>
        </div>
    </div>
    
    <!-- 푸터 -->
  <jsp:include page="/JSP/Header/footer.jsp" />
</body>
</html>