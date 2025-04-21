<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/header/header1.css">
</head>
<body>
	<header class="top-nav">
		<div class="left-header">
			<a href="${pageContext.request.contextPath}/JSP/Main/main.jsp">
				<divclass="logo">RE:NT</div>
			</a> 
			<a href="${pageContext.request.contextPath}/JSP/ProductRegister/productRegister.jsp" class="product-add">
				상품 등록
			</a>
		</div>

		<!-- 검색은 GET /list?searchText=키워드 로 -->
		<form id="mainSearchForm"
			action="${pageContext.request.contextPath}/list" method="get"
			class="search-box">
			<input id="mainSearchInput" name="searchText" type="text"
				value="${fn:escapeXml(param.searchText)}" placeholder="검색어를 입력해주세요" />
			<button id="mainSearchBtn" type="submit">🔍</button>
		</form>

		<div class="header-actions">
			<button>📍 위치</button>
			<button>🔔 알림</button>
			<button>📄 마이페이지</button>
			<span style="display: none;">닉네임</span> <span style="display: none;">로그아웃</span>
		</div>
	</header>

</body>
</html>