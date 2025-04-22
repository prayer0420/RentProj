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
				<label><input type="checkbox" class="mCheck"> [필수] 개인정보 수집 이용 동의</label><br> 
				<label><input type="checkbox" class="pCheck"> [필수] 상품정보 안내</label>
			</div>

			<button class="pay-button" onclick="requestPayment()">13,000원
				결제하기</button>
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
	      const orderId = "ORDER_"+productNo+"_"+Date.now();//예 ORDER_1_2025-01-01
	      console.log("productNo:"+productNo)	;
	      console.log("orderId:"+orderId);
	      // 회원 결제
	      // @docs https://docs.tosspayments.com/sdk/v2/js#tosspaymentspayment
	      const payment = tossPayments.payment({ customerKey });
	      
	      // 비회원 결제
	      // const payment = tossPayments.payment({customerKey: TossPayments.ANONYMOUS})

	      // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
	      // @docs https://docs.tosspayments.com/sdk/v2/js#paymentrequestpayment
	      async function requestPayment() {
	    	  const mCheck = document.querySelector('.mCheck');
			  const pCheck = document.querySelector('.pCheck');

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
	            value: 1,
	          },
	          orderId: orderId, // 고유 주문번호
	          orderName: "토스 티셔츠 외 2건",
	          successUrl: window.location.origin +"${pageContext.request.contextPath}/success", // 결제 요청이 성공하면 리다이렉트되는 URL
	          failUrl: window.location.origin + "/fail", // 결제 요청이 실패하면 리다이렉트되는 URL
	          customerEmail: "customer123@gmail.com",
	          customerName: "김토스",
	          customerMobilePhone: "01012341234",
	          // 카드 결제에 필요한 정보
	          card: {
	            useEscrow: false,
	            flowMode: "DEFAULT", // 통합결제창 여는 옵션
	            useCardPoint: false,
	            useAppCardOnly: false,
	          },
	        });
	      }
	    
	</script>

</body>
</html>
