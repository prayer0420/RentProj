<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/header/header1.css">
</head>
<body>
	<header class="top-nav">
		<div class="left-header">
			<a href="${pageContext.request.contextPath}/JSP/Main/main.jsp"><div class="logo">RE:NT</div></a> 
			<a href="${pageContext.request.contextPath}/JSP/ProductRegister/productRegister.jsp" class="product-add">상품 등록</a>
		</div>
		<div class="search-box">
			<input type="text" placeholder="검색어를 입력해주세요" />
		</div>
		<div class="header-actions">
			<button>📍 위치</button>
			<button>🔔 알림</button>
			<button>📄 마이페이지</button>
			<span style="display: none;">닉네임</span> <span style="display: none;">로그아웃</span>
		</div>
	</header>
	
</body>
</html>