<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>주문결제</title>
<meta charset="UTF-8" />
<script src="https://js.tosspayments.com/v2/standard"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/productDetail/footer.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/productDetail/orderPay.css" />
</head>

<body>
	<input type="hidden" name="orderType" value="대여">
	<input type="hidden" name="startDate" value="${startDate}">
	<input type="hidden" name="endDate" value="${endDate}">
	<input type="hidden" name="mStartDate" value="${mStartDate}">
	<input type="hidden" name="mEndDate" value="${mEndDate}">

	<!-- 주문/결제 페이지 -->
	<div class="order-container">
		<h2 class="order-title">주문/결제</h2>

		<div class="order-box">
			<h3 class="order-subtitle">주문 배송정보</h3>
			<div class="address-title">
				<span class="address-name"></span>
			</div>
			<div class="address-info">
				<span class="phone"></span><br> <span class="addressRegion"></span>
				<input type="hidden" name="deliveryAddr" id="deliveryAddressInput">
			</div>
			<button class="address-list" onclick="openAddressModal()">배송지
				목록</button>
		</div>

		<div class="order-box">
			<h3 class="order-subtitle"></h3>
			<div class="payment-row">
				<span>상품 대여 금액</span> <strong id="rentDisplay">계산 중...</strong>
			</div>
			<div class="payment-row">
				<span>보증금</span> <strong id="secDisplay">계산 중...</strong>
			</div>
			<div class="payment-row">
				<span>배송비</span> <strong id="delvDisplay">계산 중...</strong>
			</div>
			<hr>
			<div class="payment-total">
				<span>총 결제 금액</span> <span id="calculatedPrice">계산 중...</span>
			</div>
		</div>

		<div class="terms-box">
			<p>주문 정보를 확인하였으며, 아래 약관에 동의합니다.</p>
			<label><input type="checkbox" class="mCheck"> [필수]
				개인정보 수집 이용 동의</label><br> <label><input type="checkbox"
				class="pCheck"> [필수] 상품정보 안내</label>
		</div>
		<button class="pay-button" onclick="requestPayment()" id="payBtn">결제하기</button>
	</div>

	<jsp:include page="addressModal.jsp"></jsp:include>
	<%@ include file="footer.jsp"%>


	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
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
		
		
		  // ------  SDK 초기화 ------
	      // @docs https://docs.tosspayments.com/sdk/v2/js#토스페이먼츠-초기화
	      const clientKey = "test_ck_ma60RZblrqobDx61bRXZ3wzYWBn1";
	      const customerKey = "b16f0pP6SFUvxgBNYsexX";
	      const tossPayments = TossPayments(clientKey);
	      const productNo = "${product.no}";
	      const productTitle = "${product.title}";
	      const memberPhone = "${phone}".replace(/-/g, "");
	      const memberName = "${nickname}";
	      const orderType="${orderType}";
	      
	      const rentStart = "${sessionScope.start}";
	      const rentEnd = "${sessionScope.end}";
	      const rentStartDay = new Date(rentStart);
	      const rentEndDay = new Date(rentEnd);
	      
	      var diffDay = Math.floor((rentEndDay - rentStartDay)/(1000*60*60*24))+1;
	      
	      
		  const rentPrice = parseInt("${product.rentPrice}");	      
		  const secPrice = parseInt("${product.secPrice}");	      
		  const deliveryPrice = parseInt("${product.deliveryPrice}");	      
	      
	      const price = rentPrice*diffDay+secPrice+deliveryPrice;
	      console.log("가격:"+price);
	      
	      const orderId = "ORDER_"+productNo+"_"+Date.now();//예 ORDER_1_2025-01-01
	      // 회원 결제
	      // @docs https://docs.tosspayments.com/sdk/v2/js#tosspaymentspayment
	      const payment = tossPayments.payment({ customerKey });
	      
	      // 비회원 결제
	      // const payment = tossPayments.payment({customerKey: TossPayments.ANONYMOUS})

	      // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
	      // @docs https://docs.tosspayments.com/sdk/v2/js#paymentrequestpayment
	      async function requestPayment() {
	    	// ✅ startDate, endDate를 버튼 클릭 시점에 DOM에서 읽음
	  			const startDate = document.querySelector('input[name="startDate"]').value;
	  			const endDate = document.querySelector('input[name="endDate"]').value;
	    	  const mCheck = document.querySelector('.mCheck');
			  const pCheck = document.querySelector('.pCheck');
			  const addressRegion = document.querySelector('.addressRegion').innerText.trim();
			
			  //배송지가 선택이 안돼면 경고창 띄우고 함수종료
			  if(!addressRegion){
				  alert("배송지를 선택하셔야 합니다.");
				  return;
			  }
			  // ❗ 체크 안 했으면 경고창 띄우고 함수 종료
			  if (!mCheck.checked) {
			    alert("개인정보 수집 이용에 동의해 주세요.");
			    return;
			  }
			  if (!pCheck.checked) {
			    alert("상품정보 안내에 동의해 주세요.");
			    return;
			  }
	    	  
	    	  
	        // 결제를 요청하기 전에 orderId, amount를 서버에 저장하세요.
	        // 결제 과정에서 악의적으로 결제 금액이 바뀌는 것을 확인하는 용도입니다.
	        await payment.requestPayment({
	          method: "CARD", // 카드 결제
	          amount: {
	            currency: "KRW",
	            value: price,
	          },
	          orderId: orderId, // 고유 주문번호
	          orderName: productTitle,
	          successUrl: window.location.origin + "${pageContext.request.contextPath}/success" + "?deliveryAddr=" + 
	        		  encodeURIComponent(document.getElementById('deliveryAddressInput').value)+ "&orderType=" +
	        		  encodeURIComponent(document.querySelector('input[name="orderType"]').value)+
	        		  "&startDate=" + encodeURIComponent(startDate) +
	        		  "&endDate=" + encodeURIComponent(endDate)
	        		  + "&mStartDate=" +
	        		  encodeURIComponent(document.querySelector('input[name="mStartDate"]').value)
	        		  + "&mEndDate=" +
	        		  encodeURIComponent(document.querySelector('input[name="mEndDate"]').value),
	          failUrl: window.location.origin + "/fail", // 결제 요청이 실패하면 리다이렉트되는 URL
	          customerEmail: "",
	          customerName: memberName,
	          customerMobilePhone: memberPhone,
	          // 카드 결제에 필요한 정보
	          card: {
	            useEscrow: false,
	            flowMode: "DEFAULT", // 통합결제창 여는 옵션
	            useCardPoint: false,
	            useAppCardOnly: false,
	          },
	        });
	      }
	      document.addEventListener("DOMContentLoaded", function () {
	    	  // 계산된 가격
	    	  const rentTotal = rentPrice * diffDay;
	    	  const totalPrice = rentTotal + secPrice + deliveryPrice;

	    	  // 각 요소 가져오기
	    	  const rentDisplay = document.getElementById("rentDisplay");
	    	  const secDisplay = document.getElementById("secDisplay");
	    	  const delvDisplay = document.getElementById("delvDisplay");
	    	  const priceEl = document.getElementById("calculatedPrice");
	    	  const payBtn = document.getElementById("payBtn");

	    	  // 가격 표시 포맷 적용
	    	  if (rentDisplay) rentDisplay.innerText = rentTotal.toLocaleString() + "원";
	    	  if (secDisplay) secDisplay.innerText = secPrice.toLocaleString() + "원";
	    	  if (delvDisplay) delvDisplay.innerText = deliveryPrice.toLocaleString() + "원";
	    	  if (priceEl) priceEl.innerText = totalPrice.toLocaleString() + "원";
	    	  if (payBtn) payBtn.innerText = totalPrice.toLocaleString() + "원 결제하기";
	    	});
	</script>

</body>
</html>
