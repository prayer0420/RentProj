<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }" />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Order List</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/myOrder.css">
<link rel="stylesheet" href="${contextPath}/CSS/mypage/confirmOrder.css">
<style>
.modal {
  display: none !important; /* 처음엔 안 보이게 */
  position: fixed;
  z-index: 9999;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.4);
  justify-content: center;
  align-items: center;
  font-family: 'Noto Sans KR', sans-serif;
}
.modal.show {
  display: flex !important;
}

.modal-content {
  background: #fffefe;
  padding: 24px;
  border-radius: 16px;
  width: 340px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  transform: scale(0.9);
  transition: transform 0.25s ease, opacity 0.25s ease;
  opacity: 0;
}
.modal-content.active {
  transform: scale(1);
  opacity: 1;
}

.modal-title {
  font-size: 18px;
  font-weight: 600;
  margin-bottom: 16px;
  color: #333;
  text-align: center;
}

.modal textarea {
  width: 100%;
  resize: none;
  border: 1px solid #f2cec3;
  border-radius: 10px;
  background-color: #f9f9f9;
  padding: 12px;
  font-size: 14px;
  color: #333;
  outline: none;
  transition: border-color 0.3s ease;
}
.modal textarea:focus {
  border-color: #f7bfa5;
}

.modal-actions {
  margin-top: 20px;
  display: flex;
  justify-content: space-between;
}

.btn-confirm {
  background-color: #4caf50;
  color: white;
  padding: 10px 16px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}
.btn-confirm:hover {
  background-color: #43a047;
}

.btn-cancel {
  background-color: #ddd;
  color: #333;
  padding: 10px 16px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}
.btn-cancel:hover {
  background-color: #ccc;
}
</style>
</head>
<body>
<!-- 헤더 (로고 + 검색창 + 카테고리) -->
  <jsp:include page="/JSP/Header/header.jsp" />
  
	<div class="wrapper">
      <div class="container">
        <!-- 사이드바 -->
        <jsp:include page="/JSP/MyPage/mypageSidebar.jsp" />

        <!-- 콘텐츠 영역 -->
        <section class="content">
          <h2>구매한 상품</h2>
          <div class="divider"></div><br>

		<c:choose>
			<c:when test="${sessionScope.id eq null }">
				<span> 로그인이 필요한 페이지입니다.</span>
			</c:when>
			<c:otherwise>
			
	          <!-- 드롭다운 메뉴 영역 -->
	          <div class="filter-section">
	            <select class="filter-dropdown" name="period">
	              <option value="">조회 기간 선택</option>
	              <option value="12months">전체</option>
	              <option value="7days">최근 7일</option>
	              <option value="1month">1개월</option>
	              <option value="3months">3개월</option>
	              <option value="6months">6개월</option>
	            </select>
	
	            <select class="filter-dropdown" name="status">
	              <option value="">배송 상태 선택</option>
	              <option value="all">전체</option>
	              <option value="preparing">배송준비중</option>
	              <option value="shipping">배송중</option>
	              <option value="delivered">배송완료</option>
	              <option value="cancelled">주문취소</option>
	            </select>
	          </div>
		          <!-- 상품 카드 1 -->
		          <c:forEach var="item" items="${orderList }">
		          <form action="">
			          <div class="product-card">
			            <!-- 주문 정보 상단 영역 -->
			            <div class="order-info">
			              <div class="order-meta">
			                <span class="order-number">주문번호: ${item.orderId }</span>
			                <span class="order-date">주문일: <fmt:formatDate value="${item.orderDate }" pattern="yyyy년 MM월 dd일"/> </span>
			              </div>
			              <div class="order-status-area">
			                <span class="status-text">${item.orderStatus }</span>
			                <a href="${contextPath }/myOrderDetail?orderNo=${item.orderNo }" class="order-detail-link">주문 상세보기 &gt;</a>
			              </div>
			            </div>
			
			            <!-- 구분선 -->
			            <div class="card-divider"></div>
			
			            <!-- 상품 정보 영역 -->
			            <div class="card-content">
			            <a href="${contextPath}/productDetail?no=${item.no }">
			              <img
			                src="${contextPath}/upload/${item.img1}"
			                alt="상품 이미지"
			                class="product-image"
			              /></a>
			              <div class="product-info">
			                <p><a href="${contextPath }/productDetail?no=${item.no }">상품번호: ${item.productNo}</a></p>
			                <h3><a href="${contextPath }/productDetail?no=${item.no }">${item.title }</a></h3>
			                <p>판매가격: <fmt:formatNumber value="${item.salePrice}" type="number" groupingUsed="true" />원</p>
			                <p>배송비: <fmt:formatNumber value="${item.deliveryprice}" type="number" groupingUsed="true" />원</p>
			              </div>
			              <div class="status-change-btns">
			              <c:choose>
				                <c:when test="${item.orderStatus eq '결제완료'}">
									    <button type="button" class="open-cancel-btn" data-paymentkey="${item.paymentKey}"
  										data-orderno="${item.orderNo}">>
									    <input type="hidden" name="orderId" value="${item.orderId}" />
									    <input type="hidden" name="orderNo" value="${item.orderNo}"/>
									    <input type="hidden" name="paymentKey" value="${item.paymentKey}" />
									    <input type="hidden" name="cancelReason" value="사용자 직접 취소" />
									    주문취소</button>
							   </c:when> 
							   <c:when test="${item.orderStatus eq '배송중'}">
							        <button type="button" class="confirm-btn" data-orderno="${item.orderNo}">구매확정</button>
							   </c:when>
							   <c:when test="${item.orderStatus eq '거래완료'}">
							        <button type="button" class="open-review-btn" data-orderno="${item.orderNo}">
							        <a href="${contextPath }/productDetail?no=${item.no }">리뷰쓰러가기</a></button>
							   </c:when>  
							   <c:otherwise>
								    <span>&nbsp;</span>
							   </c:otherwise>
						   </c:choose>
			              </div>
			            </div>
			          </div>
		          </form>
		          </c:forEach>
		          
		          <!-- 페이징 처리 --> 
		          <br>
					<jsp:include page="/JSP/MyPage/mypagePaging.jsp" >
						<jsp:param name="baseUrl" value="${contextPath }/myOrder" />
					</jsp:include>
				
				</c:otherwise>
			</c:choose>

        </section>
      </div>
    </div>
    
    
    
    <!-- 환불 사유 입력 모달 -->
<div id="cancelModal" class="modal">
  <div class="modal-content">
    <h3 class="modal-title">환불 사유를 입력하세요</h3>
    <textarea id="cancelReason" rows="4" placeholder="예: 변심, 잘못 주문 등"></textarea>
    <input type="hidden" id="cancelPaymentKey" />
    <input type="hidden" id="cancelOrderNo" />
    <div class="modal-actions">
      <button id="cancelConfirmBtn" class="btn-confirm">환불 요청</button>
      <button onclick="closeCancelModal()" class="btn-cancel">닫기</button>
    </div>
  </div>
</div>

<!-- 구매확정 모달 추가 -->
<div id="confirmModal" class="modal" >
  <div class="modal-content">
    <p>구매를 확정하시겠습니까?</p>
    <button id="confirmYesBtn">확인</button>
  </div>
</div>

<!-- 푸터 -->
  <jsp:include page="/JSP/Header/footer.jsp" />
  
</body>
<script>
document.addEventListener('DOMContentLoaded', function () {
	  document.querySelectorAll('.open-cancel-btn').forEach(btn => {
	    btn.addEventListener('click', () => {
	      const paymentKey = btn.dataset.paymentkey;
	      const orderNo = btn.dataset.orderno;

	      document.getElementById('cancelPaymentKey').value = paymentKey;
	      document.getElementById('cancelOrderNo').value = orderNo;
	      document.getElementById('cancelReason').value = "";

	      openCancelModal();
	    });
	  });

	  document.getElementById('cancelConfirmBtn').addEventListener('click', () => {
	    const paymentKey = document.getElementById('cancelPaymentKey').value;
	    const orderNo = document.getElementById('cancelOrderNo').value;
	    const cancelReason = document.getElementById('cancelReason').value.trim();

	    if (!cancelReason) {
	      alert("사유를 입력해주세요.");
	      return;
	    }

	    fetch('${contextPath}/refund', {
	      method: 'POST',
	      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	      body: new URLSearchParams({
	        paymentKey,
	        cancelReason,
	        orderNo
	      })
	    })
	    .then(res => {
	      if (!res.ok) throw new Error("환불 실패");
	      return res.json();
	    })
	    .then(data => {
	      alert("✅ 환불이 완료되었습니다!");
	      window.location.href = '${contextPath}/myOrder';
	    })
	    .catch(err => {
	      console.error("❌ 환불 오류:", err);
	      alert("❌ 환불 실패. 관리자에게 문의하세요.");
	    });
	  });
	});

function openCancelModal() {
  const modal = document.getElementById("cancelModal");
  modal.classList.add("show");
  setTimeout(() => {
  modal.querySelector(".modal-content").classList.add("active");
  }, 10);
}
function closeCancelModal() {
  const modal = document.getElementById("cancelModal");
  modal.querySelector(".modal-content").classList.remove("active");
  setTimeout(() => {
    modal.classList.remove("show");
  }, 250);
}

</script>

<!-- 구매확정 버튼 -->
<script>
document.addEventListener('DOMContentLoaded', function () {
  let selectedOrderNo = null;

  document.querySelectorAll('.confirm-btn').forEach(btn => {
    btn.addEventListener('click', function () {
      selectedOrderNo = this.dataset.orderno;
      console.log("구매확정 버튼 클릭: ", selectedOrderNo);

      const modal = document.getElementById("confirmModal");
      modal.classList.add("show");

      setTimeout(() => {
        modal.querySelector(".modal-content").classList.add("active");
      }, 10);
    });
  });

  //'확인' 버튼 누르면
  document.getElementById("confirmYesBtn").addEventListener("click", function () {
    if (!selectedOrderNo) return;

    const button = document.querySelector('.confirm-btn[data-orderno="' + selectedOrderNo + '"]');
    button.disabled = true;
    button.textContent = "처리중...";

    fetch('${contextPath}/confirmOrder', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ orderNo: selectedOrderNo })
    })
    .then(res => res.json())
    .then(data => {
      if (data.success) {
        alert("구매를 확정했어요!");
        button.parentElement.innerHTML = '<span class="confirmed-label">구매 완료!</span>';
      } else {
        alert("구매 확정 실패");
        button.disabled = false;
        button.textContent = "구매확정";
      }

      closeConfirmOrderModal();
    })
    .catch(err => {
      console.error("서버 오류", err);
      alert("서버 오류가 발생했습니다");
      button.disabled = false;
      button.textContent = "구매확정";
      closeConfirmOrderModal();
    });
  });

 
  function closeConfirmOrderModal() {
    const modal = document.getElementById("confirmModal");
    modal.querySelector(".modal-content").classList.remove("active");
    setTimeout(() => {
      modal.classList.remove("show");
    }, 250);
  }
});

</script>



</html>