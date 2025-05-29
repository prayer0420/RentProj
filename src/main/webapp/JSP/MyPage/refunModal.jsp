<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.modal {
  display: none;
  position: fixed;
  z-index: 9999;
  left: 0; top: 0;
  width: 100%; height: 100%;
  background-color: rgba(0,0,0,0.5);
  justify-content: center; align-items: center;
}
.modal-content {
  background: #fff;
  padding: 20px;
  border-radius: 8px;
  width: 300px;
}
.modal-actions {
  margin-top: 10px;
  text-align: right;
}
.modal textarea {
  width: 100%;
  resize: none;
}
</style>
</head>
<body>
        <!-- 환불 사유 입력 모달 -->
<div id="cancelModal" class="modal">
  <div class="modal-content">
    <h3>환불 사유를 입력하세요</h3>
    <textarea id="cancelReason" rows="4" placeholder="예: 변심, 잘못 주문 등"></textarea>
    <input type="hidden" id="cancelPaymentKey" />
    <input type="hidden" id="cancelOrderNo" />
    <div class="modal-actions">
      <button id="cancelConfirmBtn">환불 요청</button>
      <button onclick="closeCancelModal()">닫기</button>
    </div>
  </div>
</div>
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
</html>