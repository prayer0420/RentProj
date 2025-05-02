	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />       
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/mypageModal.css">

<meta charset="UTF-8">
<title>My Rental Products</title>
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
  background:rgb(255,253,249);
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
  border-color: black;
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

/*반납송장버튼 입력 모달*/
.rmodal {
	  display: none; /* 기본은 숨김 */
	  position: fixed;
	  z-index: 999;
	  left: 0;
	  top: 0;
	  width: 100%;
	  height: 300px;
	  overflow: auto; /* 스크롤 가능 */
	  background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
	}
	
	/* 모달 내부 박스 */
	.rmodal-content {
	  background-color: #fff;
	  margin: 10% auto;
	  padding: 20px;
	  border: 2px solid #aaa;
	  width: 400px;
	  border-radius: 10px;
	  position: relative;
	  text-align: center;
	}

	
	/* 닫기 버튼 (X) */
	.rclose {
	  color: #aaa;
	  float: right;
	  font-size: 24px;
	  font-weight: bold;
	  cursor: pointer;
	}
	
	.rclose:hover {
	  color: black;
	}
	

</style>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/myRent.css">
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
          <h2>빌린 상품</h2>
          <div class="divider"></div><br>

		<c:choose>
			<c:when test="${id eq null }">
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
	
	          <!-- 상품 카드 -->
	          <c:forEach var="item" items="${rentList}">
		          <form action="">
		          <div class="product-card">
		            <!-- 주문 정보 상단 영역 -->
		            <div class="order-info">
		              <div class="order-meta">
		                <span class="order-number">주문번호: ${item.orderId }</span>
		                <span class="order-date">주문일: <fmt:formatDate value="${item.orderDate }" pattern="yyyy년 MM월 dd일" /> </span>
		              </div>
		              <div class="order-status-area">
		                <span class="status-text">${item.orderStatus}</span>
		                <a href="${contextPath }/myRentDetail?orderNo=${item.orderNo }" class="order-detail-link">주문 상세보기 &gt;</a>
		              </div>
		            </div>
		
		            <!-- 구분선 -->
		            <div class="card-divider"></div>
		
		            <!-- 상품 정보 영역 -->
		            <div class="card-content">
		            <a href="${contextPath }/productDetail?no=${item.no }">
		              <img
		                src="${contextPath}/upload/${item.img1}"
		                alt="상품 이미지"
		                class="product-image"
		              /></a>
		              <div class="product-info">
		                <p><a href="${contextPath }/productDetail?no=${item.no }">${item.productNo }</a></p>
		                <p>
						  대여날짜:
						  <fmt:formatDate value="${item.startDate}" pattern="yyyy-MM-dd" />
						  <span> ~ </span>
						  <fmt:formatDate value="${item.endDate}" pattern="yyyy-MM-dd" />
						</p>
		                <h3><a href="${contextPath }/productDetail?no=${item.no }">${item.title }</a></h3>
		                <p>가격: <fmt:formatNumber value="${item.rentPrice }" type="number" groupingUsed="true"/>원</p>
		                <p>배송비: <fmt:formatNumber value="${item.deliveryPrice }" type="number" groupingUsed="true"/></p>
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
							        <button type="button" class="rent-start-btn" data-orderno="${item.orderNo}">빌리기시작</button>
							   </c:when>
							   <c:when test="${item.orderStatus eq '대여중'}">
							        <button type="button" class="open-invoice-btn" data-orderno="${item.orderNo}">반납송장번호입력</button>
							        
							   </c:when>
							   <c:when test="${item.orderStatus eq '거래완료'}">
							        <button type="button" class="open-review-btn" data-orderno="${item.orderNo}">리뷰쓰러가기</button>
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
					<jsp:param name="baseUrl" value="${contextPath }/myRent" />
				</jsp:include>
				
			</c:otherwise>
			</c:choose>
			
        </section>
      </div>
    </div>
    
    <!-- 대여시작 모달 추가 -->
<div id="rentStartModal" class="modal" >
  <div class="modal-content">
    <p>우리... 오늘부터 대여 1일!</p>
    <button id="confirmRent">확인</button>
  </div>
</div>

<!--반납송장번호 입력 모달 -->
<div id="invoiceModal" class="rmodal invoice-modal">
  <div class="rmodal-content">
    <span class="rclose">&times;</span>
    <form>
      <input type="hidden" id="orderNo" />
      <input type="hidden" id="redirectUrl" />
      <label for="reDeliveryComp">택배사</label>
      <input type="text" id="reDeliveryComp" required />
      <label for="reInvoiceNo">송장번호</label>
      <input type="text" id="reInvoiceNo" required />
      <button type="button" id="submitInvoiceBtn">등록</button>
    </form>
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

<!-- 빌리기시작 버튼 -->
<script>
document.addEventListener('DOMContentLoaded', function () {
  let selectedOrderNo = null;

  document.querySelectorAll('.rent-start-btn').forEach(btn => {
    btn.addEventListener('click', function () {
      selectedOrderNo = this.dataset.orderno;
      console.log("빌리기 버튼 클릭됨:", selectedOrderNo);

      const modal = document.getElementById("rentStartModal");
      modal.classList.add("show");

      setTimeout(() => {
        modal.querySelector(".modal-content").classList.add("active");
      }, 10);
    });
  });

  document.getElementById("confirmRent").addEventListener("click", function () {
    if (!selectedOrderNo) return;

    const button = document.querySelector('.rent-start-btn[data-orderno="' + selectedOrderNo + '"]');
    button.disabled = true;
    button.textContent = "처리중...";

    fetch('${contextPath}/rentStart', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ orderNo: selectedOrderNo })
    })
    .then(res => res.json())
    .then(data => {
      if (data.success) {
        alert("대여가 시작되었습니다!");
        button.parentElement.innerHTML = '<span class="confirmed-label">대여 시작!</span>';
      } else {
        alert("대여 시작 실패");
        button.disabled = false;
        button.textContent = "빌리기시작";
      }

      closeRentModal();
    })
    .catch(err => {
      console.error("서버 오류", err);
      alert("서버 오류가 발생했습니다");
      button.disabled = false;
      button.textContent = "빌리기시작";
      closeRentModal();
    });
  });

  function closeRentModal() {
    const modal = document.getElementById("rentStartModal");
    modal.querySelector(".modal-content").classList.remove("active");
    setTimeout(() => {
      modal.classList.remove("show");
    }, 250);
  }
});

</script>

<!-- 반납송장번호 입력 -->
<script>
document.addEventListener("DOMContentLoaded", function () {
	  const modal = document.getElementById("invoiceModal");
	  const orderNoInput = document.getElementById("orderNo");
	  const reDeliveryComp = document.getElementById("reDeliveryComp");
	  const reInvoiceNo = document.getElementById("reInvoiceNo");
	  const redirectUrlInput = document.getElementById("redirectUrl");
	  const submitBtn = document.getElementById("submitInvoiceBtn");

	  document.querySelectorAll(".open-invoice-btn").forEach(function (btn) {
	    btn.addEventListener("click", function () {
	      const orderNo = btn.dataset.orderno;
	      console.log("반납송장 버튼 클릭됨:", orderNo);

	      orderNoInput.value = orderNo;
	      redirectUrlInput.value = "/rent/myRentDetail?orderNo=" + orderNo;

	      showModal(modal);
	    });
	  });

	  submitBtn.addEventListener("click", function () {
	    const orderNo = orderNoInput.value;
	    const company = reDeliveryComp.value.trim();
	    const invoiceNo = reInvoiceNo.value.trim();
	    const redirectUrl = redirectUrlInput.value;

	    if (!company || !invoiceNo) {
	      alert("택배사와 송장번호를 모두 입력해주세요.");
	      return;
	    }

	    fetch("/rent/reInvoiceSetting", {
	      method: "POST",
	      headers: {
	        "Content-Type": "application/x-www-form-urlencoded",
	      },
	      body: new URLSearchParams({
	        orderNo,
	        reDeliveryComp: company,
	        reInvoiceNo: invoiceNo,
	      }),
	    })
	      .then((res) => {
	        if (!res.ok) throw new Error("송장 등록 실패");
	        window.location.href = redirectUrl;
	      })
	      .catch((err) => {
	        console.error(err);
	        alert("송장 등록에 실패했습니다. 다시 시도해주세요.");
	      });
	  });

	  document.querySelectorAll(".rclose").forEach(function (btn) {
		  btn.addEventListener("click", function () {
		    hideModal(modal);
		  });
		});

	  window.addEventListener("click", function (e) {
	    if (e.target === modal) {
	      hideModal(modal);
	    }
	  });

	  function showModal(modal) {
	    modal.style.display = "flex";
	    modal.style.opacity = "0";
	    setTimeout(() => {
	      modal.style.opacity = "1";
	      modal.style.transition = "opacity 0.3s ease";
	    }, 10);
	  }

	  function hideModal(modal) {
	    modal.style.opacity = "0";
	    setTimeout(() => {
	      modal.style.display = "none";
	    }, 250);
	  }
	});

</script>


</html>