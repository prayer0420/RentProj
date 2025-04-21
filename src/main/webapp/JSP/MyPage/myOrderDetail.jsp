<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="contextPath" value="${pageContext.request.contextPath }" />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Order Detail</title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/myOrderDetail.css">
</head>
<body>
	<div class="wrapper">
      <div class="container">
        <!-- 사이드바 -->
        <jsp:include page="/JSP/MyPage/mypageSidebar.jsp" />
        
        <!-- 콘텐츠 영역 -->
        <section class="content">
          <h2>주문 상세</h2>
          <div class="divider"></div>
          
          <div class="section product-box">
                <img src="https://via.placeholder.com/120x100?text=🚲" alt="자전거">
                <div class="product-info">
                    <div style="font-size: 13px; color: gray;">상품번호 98765432134567</div>
                    <div class="product-title">성인용 자전거 (일반주행용, 3년 전 구입)</div>
                    <div class="price">100,000원</div>
                </div>
                <span class="status-text">상품배송중</span>
            </div>

            <div class="info-grid">
                <div class="info-box">
                    <h4>배송정보</h4>
                    <p>송장번호: 23456789123</p>
                    <p>택배사: 롯데택배</p>
                    <p>배송지: (04020) 서울시 관악구 문성동</p>
                </div>
                <div class="info-box">
                    <h4>판매자 정보</h4>
                    <p>deoksoo1243</p>
                    <p>010-1234-5678</p>
                    <p>&nbsp;&nbsp;</p>
                    
                    <button class="btn">판매자의 다른 상품-></button>
                </div>
            </div>

            <div class="info-grid" style="margin-top: 20px;">
                <div class="info-box">
                    <h4>반품 배송지</h4>
                    <p>(04020) 서울시 관악구 문성동</p>
                    <p></p>
                    <p></p>
                    <p></p>
                    
                </div>
                <div class="info-box">
                    <h4>결제정보</h4>
                    <p><strong>총 결제금액:</strong> 102,500원</p>
                    <p>구매가격: 100,000원</p>
                    <p>배송비: 2,500원</p>
                </div>
            </div>
          </section>
        </div>
    </div>
</body>
</html>