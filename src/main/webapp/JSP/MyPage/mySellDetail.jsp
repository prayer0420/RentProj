<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%
	Map<String,Object> detail = (Map<String,Object>) request.getAttribute("mySellDetail"); 
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Selling Detail </title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/mySellDetail.css">
</head>
<body>
<div class="wrapper">
      <div class="container">
        <!-- 사이드바 -->
        <jsp:include page="/JSP/MyPage/mypageSidebar.jsp" />
        
        <!-- 콘텐츠 영역 -->
        <section class="content">
          <h2>판매 상세</h2>
          <div class="divider"></div>
          
          <div class="section product-box">
                <img src="https://via.placeholder.com/120x100?text=🚲" alt="자전거">
                <div class="product-info">
                    <div style="font-size: 13px; color: gray;">상품번호 98765432134567</div>
                    <div class="product-title">성인용 자전거 (일반주행용, 3년 전 구입)</div>
                    <div class="price">100,000원</div>
                </div>
            </div>

            <div class="info-grid">
                <div class="info-box">
                    <h4>배송정보</h4>
                    <p>송장번호: 23456789123</p>
                    <p>택배사: 롯데택배</p>
                    <p>배송지: (04020) 서울시 관악구 문성동</p>
                </div>
                <div class="info-box">
                    <h4>구매 회원</h4>
                    <p>deoksoo1243</p>
                    <p>010-1234-5678</p>
                    <p>(04020) 서울시 관악구 문성동</p>
                </div>
            </div>

            <div class="info-grid" style="margin-top: 20px;">
                <div class="info-box">
                    <h4>구매 정보</h4>
                    <p>주문번호: 5678901234</p>
                    <p>주문일: 2025-03-04</p>
                    <p>상품출고일: 2025-03-06</p>
                    <p>구매확정일: 2025-03-09</p>
                    <p>&nbsp;&nbsp;</p>
                </div>
                <div class="info-box">
                    <h4>결제정보</h4>
                    <p class="highlight-red"><strong>총 결제금액:</strong> 102,500원</p>
                    <p>판매가: 100,000원</p>
                    <p>배송비: 2500원</p>
                    <p>결제수단: 신용카드</p>
                </div>
            </div>
          </section>
        </div>
    </div>
</body>
</html>