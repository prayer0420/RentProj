<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>주문결제</title>
<meta charset="UTF-8" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/productDetail/footer.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/productDetail/orderPay.css" />
</head>

<body>

	<!-- 주문/결제 페이지 -->
	<div class="order-container">
		<h2 class="order-title">주문/결제</h2>

		<div class="order-box">
			<h3 class="order-subtitle">주문 배송정보</h3>
			<div class="address-title">
				<span class="address-name">집</span>
				<button class="default-address">기본 배송지</button>
			</div>
			<div class="address-info">
				010-1234-5678<br> (04401) 서울특별시 용산구 대사관로39 멘토빌라 20-1호
			</div>
			<button class="address-list" onclick="openAddressModal()">배송지
				목록</button>
		</div>

		<div class="order-box">
			<h3 class="order-subtitle">결제 정보</h3>
			<div class="payment-row">
				<span>상품 금액</span> <strong>10,000원</strong>
			</div>
			<div class="payment-row">
				<span>배송비</span> <strong>3,000원</strong>
			</div>
			<hr>
			<div class="payment-total">
				<span>총 결제 금액</span> <span>13,000원</span>
			</div>
		</div>

		<div class="terms-box">
			<p>주문 정보를 확인하였으며, 아래 약관에 동의합니다.</p>
			<label><input type="checkbox"> [필수] 개인정보 수집 이용 동의</label><br>
			<label><input type="checkbox"> [필수] 상품정보 안내</label>
		</div>

		<button class="pay-button" onclick="showCompletePage()">13,000원
			결제하기</button>
	</div>

	<jsp:include page="addressModal.jsp"></jsp:include>
	<%@ include file="footer.jsp"%>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		function showCompletePage() {
			location.href = 'orderComplete.jsp'
		}
		
		function openAddressModal() {
			document.getElementById('addressModal').style.display = 'flex';
		}

		function closeAddressModal() {
			document.getElementById('addressModal').style.display = 'none';
		}
		function openAddressAddModal() {
			document.getElementById('addressAddModal').style.display = 'flex';
		}

		function closeAddressAddModal() {
			document.getElementById('addressAddModal').style.display = 'none';
		}
	</script>
	
</body>
</html>
