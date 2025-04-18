<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<title>주문완료</title>
<meta charset="UTF-8" />
<link rel="stylesheet" href="css/header.css" />
<link rel="stylesheet" href="css/footer.css" />
<link rel="stylesheet" href="css/footer.css" />
</head>
<body>
	<%@ include file="header.jsp"%>
	<%@ include file="category.jsp"%>

	<!-- 주문 완료 페이지 -->
	<div class="order-container">
		<h2 class="order-title">주문이 완료 되었습니다!</h2>
		<div class="order-number">
			주문번호: <strong>701013213201110014</strong>
		</div>

		<div class="order-box">
			<h3 class="order-subtitle">결제 정보</h3>
			<div class="payment-row">
				결제 금액: <strong>13,000원</strong>
			</div>
		</div>

		<div class="order-box">
			<h3 class="order-subtitle">주문 및 배송정보</h3>
			<div class="payment-row">
				<strong>주문상품</strong><br> 갤럭시 버즈 프로 3
			</div>
			<div class="payment-row">
				<strong>배송지</strong><br> 집<br> 010-1234-5678<br>
				(04401) 서울특별시 용산구 대사관로39 멘토빌라 20-1호
			</div>
		</div>
	</div>

	<%@ include file="footer.jsp"%>
</body>
</html>