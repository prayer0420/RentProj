<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>상품 목록</title>
<link rel="stylesheet" href="css/header.css" />
<link rel="stylesheet" href="css/footer.css" />
<link rel="stylesheet" href="css/list.css" />
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
</head>
<body>
	<jsp:include page="/JSP/Header/header.jsp"></jsp:include>
		<div class="filter-sort-bar">
			<div class="badge-bar">
				<div class="badge 판매">판매</div>
				<div class="badge 대여">대여</div>
				<div class="badge 판매대여">판매/대여</div>
				<div class="badge 나누몬">나눔</div>
			</div>
			<div class="sort-options">
				<span class="active">동네상품</span> <span>최신순</span> <span>낮은가격순</span>
				<span>높은가격순</span>
			</div>
		</div>

		<div class="products-container">
			<div class="products">

				<!-- 상품 카드 -->
				<div class="product-card">
					<div class="new-badge">NEW</div>
					<img src="https://image.url/sample.jpg">
					<div class="product-title">버즈 프로3</div>
					<div class="product-info">
						<div class="product-price">
							<span class="sale">판매가 80,000원</span><br> <span class="rent">대여
								3,000원 / 1일</span><br> <span class="deposit">보증금 20,000원</span>
						</div>
						<div class="product-type 판매">판매</div>
					</div>
					<div class="product-meta">2시간 전</div>
				</div>

				<div class="product-card">
					<div class="new-badge">NEW</div>
					<img src="https://image.url/sample.jpg">
					<div class="product-title">버즈 프로3</div>
					<div class="product-info">
						<div class="product-price">
							<span class="sale">판매가 80,000원</span><br> <span class="rent">대여
								3,000원 / 1일</span><br> <span class="deposit">보증금 20,000원</span>
						</div>
						<div class="product-type 판매">대여</div>
					</div>
					<div class="product-meta">2시간 전</div>
				</div>

				<div class="product-card">
					<div class="new-badge">NEW</div>
					<img src="https://image.url/sample.jpg">
					<div class="product-title">버즈 프로3</div>
					<div class="product-info">
						<div class="product-price">
							<span class="sale">판매가 80,000원</span><br> <span class="rent">대여
								3,000원 / 1일</span><br> <span class="deposit">보증금 20,000원</span>
						</div>
						<div class="product-type 판매">대여/판매</div>
					</div>
					<div class="product-meta">2시간 전</div>
				</div>

				<div class="product-card">
					<div class="new-badge">NEW</div>
					<img src="https://image.url/sample.jpg">
					<div class="product-title">버즈 프로3</div>
					<div class="product-info">
						<div class="product-price">
							<span class="sale">판매가 80,000원</span><br> <span class="rent">대여
								3,000원 / 1일</span><br> <span class="deposit">보증금 20,000원</span>
						</div>
						<div class="product-type 판매">대여/판매</div>
					</div>
					<div class="product-meta">2시간 전</div>
				</div>

				<div class="product-card">
					<div class="new-badge">NEW</div>
					<img src="https://image.url/sample.jpg">
					<div class="product-title">버즈 프로3</div>
					<div class="product-info">
						<div class="product-price">
							<span class="sale">판매가 80,000원</span><br> <span class="rent">대여
								3,000원 / 1일</span><br> <span class="deposit">보증금 20,000원</span>
						</div>
						<div class="product-type 판매">대여/판매</div>
					</div>
					<div class="product-meta">2시간 전</div>
				</div>

				<div class="product-card">
					<div class="new-badge">NEW</div>
					<img src="https://image.url/sample.jpg">
					<div class="product-title">버즈 프로3</div>
					<div class="product-info">
						<div class="product-price">
							<span class="sale">판매가 80,000원</span><br> <span class="rent">대여
								3,000원 / 1일</span><br> <span class="deposit">보증금 20,000원</span>
						</div>
						<div class="product-type 판매">대여/판매</div>
					</div>
					<div class="product-meta">2시간 전</div>
				</div>

				<div class="product-card">
					<div class="new-badge">NEW</div>
					<img src="https://image.url/sample.jpg">
					<div class="product-title">버즈 프로3</div>
					<div class="product-info">
						<div class="product-price">
							<span class="sale">판매가 80,000원</span><br> <span class="rent">대여
								3,000원 / 1일</span><br> <span class="deposit">보증금 20,000원</span>
						</div>
						<div class="product-type 판매">대여/판매</div>
					</div>
					<div class="product-meta">2시간 전</div>
				</div>

				<div class="product-card">
					<div class="new-badge">NEW</div>
					<img src="https://image.url/sample.jpg">
					<div class="product-title">버즈 프로3</div>
					<div class="product-info">
						<div class="product-price">
							<span class="sale">판매가 80,000원</span><br> <span class="rent">대여
								3,000원 / 1일</span><br> <span class="deposit">보증금 20,000원</span>
						</div>
						<div class="product-type 판매">대여/판매</div>
					</div>
					<div class="product-meta">2시간 전</div>
				</div>

				<div class="product-card">
					<div class="new-badge">NEW</div>
					<img src="https://image.url/sample.jpg">
					<div class="product-title">버즈 프로3</div>
					<div class="product-info">
						<div class="product-price">
							<span class="sale">판매가 80,000원</span><br> <span class="rent">대여
								3,000원 / 1일</span><br> <span class="deposit">보증금 20,000원</span>
						</div>
						<div class="product-type 판매">대여/판매</div>
					</div>
					<div class="product-meta">2시간 전</div>
				</div>

				<div class="product-card">
					<div class="new-badge">NEW</div>
					<img src="https://image.url/sample.jpg">
					<div class="product-title">버즈 프로3</div>
					<div class="product-info">
						<div class="product-price">
							<span class="sale">판매가 80,000원</span><br> <span class="rent">대여
								3,000원 / 1일</span><br> <span class="deposit">보증금 20,000원</span>
						</div>
						<div class="product-type 판매">대여/판매</div>
					</div>
					<div class="product-meta">2시간 전</div>
				</div>

				<div class="product-card">
					<div class="new-badge">NEW</div>
					<img src="https://image.url/sample.jpg">
					<div class="product-title">버즈 프로3</div>
					<div class="product-info">
						<div class="product-price">
							<span class="sale">판매가 80,000원</span><br> <span class="rent">대여
								3,000원 / 1일</span><br> <span class="deposit">보증금 20,000원</span>
						</div>
						<div class="product-type 판매">대여/판매</div>
					</div>
					<div class="product-meta">2시간 전</div>
				</div>

			</div>
		</div>

	<jsp:include page="/JSP/Header/footer.jsp"></jsp:include>

	<script>
  		const badges = document.querySelectorAll('.badge');
  		badges.forEach(badge => {
    	badge.addEventListener('click', () => {
  		badges.forEach(b => b.classList.remove('active'));
      	badge.classList.add('active');
    });
  });

  		const sorts = document.querySelectorAll('.sort-options span');
  		sorts.forEach(sort => {
   		sort.addEventListener('click', () => {
      	sorts.forEach(s => s.classList.remove('active'));
      	sort.classList.add('active');
    });
  });
</script>
</body>
</html>