<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/guide/guideWrite.css">
</head>
<body>
<jsp:include page="../Header/header.jsp"></jsp:include>
	<form action="">
		<h2>상품등록 이용가이드</h2>
		<hr>
		<div class="guide-grid">
			<div class="guide-step">
				<span>1. 상품등록 필수 동의</span>
				<div class="guide-box"></div>
			</div>
			<div class="guide-step">
				<span>2. 카테고리 선택</span>
				<div class="guide-box"></div>
			</div>
			<div class="guide-step">
				<span>3. 상품 제목입력</span>
				<div class="guide-box"></div>
			</div>
			<div class="guide-step">
				<span>4. 빌리 수수료확인</span>
				<div class="guide-box"></div>
			</div>
			<div class="guide-step">
				<span>5. 판매/빌리기 선택</span>
				<div class="guide-box"></div>
			</div>
			<div class="guide-step">
				<span>6. 상품 상태 확인</span>
				<div class="guide-box"></div>
			</div>
			<div class="guide-step">
				<span>7. 거래지역 선택</span>
				<div class="guide-box"></div>
			</div>
			<div class="guide-step">
				<span>8. 이미지 및 상세내용 작성</span>
				<div class="guide-box"></div>
			</div>
		</div>
	</form>
</body>
</html>