<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage Modal</title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/mypageModal.css">
</head>
<body>

<!-- 재사용 가능한 모달 -->
    <div id="universalModal" class="modal-overlay">
      <div class="modal-content">
        <p id="modalMessage">여기에 메시지가 들어갑니다</p>
        <div class="modal-buttons">
          <button onclick="handleModalConfirm()">확인</button>
          <button onclick="closeModal()">취소</button>
        </div>
      </div>
    </div>
    
</body>

<!-- 자바스크립트 코드 -->
    <script>

      /* 모달창 관련: 메시지, 콜백 함수 코드 */
      let modalConfirmCallback = null;

      function openModalWith(message, onConfirmCallback) {
        document.getElementById("modalMessage").textContent = message;
        modalConfirmCallback = onConfirmCallback;
        document.getElementById("universalModal").style.display = "flex";
      }

      function handleModalConfirm() {
        if (typeof modalConfirmCallback === "function") {
          modalConfirmCallback();
        }
        closeModal();
      }

      function closeModal() {
        document.getElementById("universalModal").style.display = "none";
      }

      // 각각의 동작 정의
      function deleteProduct() {
        alert("상품을 삭제합니다");
        // 실제 삭제 API 호출 등
      }

      function hideProduct() {
        alert("상품을 숨깁니다");
      }

      function cancelOrder() {
        alert("주문을 취소합니다");
      }
    </script>
    
</html>