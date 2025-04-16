<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

/* 배너 */
.banner {
	background-color: rgb(228, 242, 220);
	padding: 40px 24px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.banner h2 {
	font-size: 24px;
	font-weight: 700;
	margin-bottom: 12px;
	color: #2f855a;
}

.banner button {
	padding: 8px 16px;
	background-color: #2f855a;
	color: #fff;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	font-size: 14px;
}

.banner-img {
	width: 300px;
	margin-right: 900px;
}

.banner-container {
	width: 500px;
	margin: 0 200px;
	float: left;
}

/* 섹션 제목 */
.section-title {
	font-size: 18px;
	font-weight: 600;
	margin: 30px 24px 10px;
	margin-left: 250px;
}

/* 상품 */
.product-grid {
	padding: 0 24px 40px;
	display: flex;
	justify-content: center;
	grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
	gap: 50px;
	justify-content: center; /* 추가 */
}

.product-card {
	background-color: #fff;
	border-radius: 10px;
	padding: 10px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
	text-align: center;
}

.product-card img {
	width: 100%;
	height: 140px;
	object-fit: cover;
	border-radius: 8px;
}

.product-name {
	font-size: 14px;
	font-weight: 500;
	margin-top: 8px;
}

.product-price {
	font-size: 12px;
	color: #6b7280;
	margin-top: 4px;
}
</style>
</head>
<body>
<jsp:include page="../Header/header1.jsp"></jsp:include>
	<section class="banner">
		<div class="banner-container">
			<h2 class="banner-h2">RE:NT에서 렌트하세요!</h2>
			<a href="../service/service.jsp"><button>이용가이드 &gt;</button></a>
		</div>
		<div class="banner-img">
			<img src="../../image/rent.jpg" alt="배너 이미지">
		</div>
	</section>
<jsp:include page="../Header/header2.jsp"></jsp:include>

	<section>
		<div class="section-title">오늘의 인기 상품이에요!</div>
		<div class="product-grid">
			<div class="product-card">
				<img src="../../image/shopping.jpg" alt="">
				<div class="product-name">아이폰 13 Pro</div>
				<div class="product-price">월 40,000원</div>
			</div>
			<div class="product-card">
				<img src="../../image/shopping.jpg" alt="">
				<div class="product-name">아이폰 13 Pro</div>
				<div class="product-price">월 40,000원</div>
			</div>
			<div class="product-card">
				<img src="../../image/shopping.jpg" alt="">
				<div class="product-name">아이폰 13 Pro</div>
				<div class="product-price">월 40,000원</div>
			</div>
			<div class="product-card">
				<img src="../../image/shopping.jpg" alt="">
				<div class="product-name">아이폰 13 Pro</div>
				<div class="product-price">월 40,000원</div>
			</div>
			<div class="product-card">
				<img src="../../image/shopping.jpg" alt="">
				<div class="product-name">아이폰 13 Pro</div>
				<div class="product-price">월 40,000원</div>
			</div>
		</div>
	</section>
	<section>
		<div class="section-title">내 동네에서 이런것도 빌릴 수 있어요!</div>
		<div class="product-grid">
			<div class="product-card">
				<img src="../../image/shopping.jpg" alt="">
				<div class="product-name">아이폰 13 Pro</div>
				<div class="product-price">월 40,000원</div>
			</div>
			<div class="product-card">
				<img src="../../image/shopping.jpg" alt="">
				<div class="product-name">아이폰 13 Pro</div>
				<div class="product-price">월 40,000원</div>
			</div>
			<div class="product-card">
				<img src="../../image/shopping.jpg" alt="">
				<div class="product-name">아이폰 13 Pro</div>
				<div class="product-price">월 40,000원</div>
			</div>
			<div class="product-card">
				<img src="../../image/shopping.jpg" alt="">
				<div class="product-name">아이폰 13 Pro</div>
				<div class="product-price">월 40,000원</div>
			</div>
			<div class="product-card">
				<img src="../../image/shopping.jpg" alt="">
				<div class="product-name">아이폰 13 Pro</div>
				<div class="product-price">월 40,000원</div>
			</div>
		</div>
	</section>
</body>
</html>