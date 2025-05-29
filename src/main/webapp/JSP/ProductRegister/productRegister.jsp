<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 유형 선택</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/CSS/productRegister/productRegister.css">
</head>
<body>
	<jsp:include page="../Header/header.jsp"></jsp:include>
	<div class="container">
		<h2>상품 등록 유형을 선택하세요</h2>
		<div class="type-filter">
		
			<a href="${pageContext.request.contextPath}/sell" class="type-link type-sell">
			  <img src="${pageContext.request.contextPath}/img/icons/sell.png" alt="판매" class="type-icon">
			  <span>판매</span>
			</a>
			
			<a href="${pageContext.request.contextPath}/rent" class="type-link type-rent">
			  <img src="${pageContext.request.contextPath}/img/icons/rent.png" alt="대여" class="type-icon">
			  <span>대여</span>
			</a>
			
			<a href="${pageContext.request.contextPath}/rentSell" class="type-link type-both">
			  <img src="${pageContext.request.contextPath}/img/icons/both.png" alt="판매/대여" class="type-icon">
			  <span>판매/대여</span>
			</a>
			
			<a href="${pageContext.request.contextPath}/free" class="type-link type-free">
			  <img src="${pageContext.request.contextPath}/img/icons/free.png" alt="무료나눔" class="type-icon">
			  <span>무료나눔</span>
			</a>

		</div>
	</div>

</body>
</html>
