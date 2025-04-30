<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${contextPath}/CSS/productDetail/noteModal.css" />

<!-- 쪽지 보내기 모달 -->
<div class="modal-overlay" id="messageModal" style="display:none;">
  <form id="messageForm" action="${contextPath}/noteSend" method="post">
    <input type="hidden" name="origin" value="myNoteList" /> <!-- 출처 전송 -->
    <div class="modal">
      <div class="modal-title">쪽지 보내기</div>
      <div class="modal-sub">상품 상세페이지 - 쪽지 전송</div>

      <!-- 동적으로 채워질 필드 -->
      <input type="hidden" name="receiverNo" id="modalReceiverNo" />
      <input type="hidden" name="productNo" id="modalProductNo" />

      <div class="info-box">
        <div class="info-row">
          <div class="label">받는 사람</div>
          <div class="value" id="modalReceiverName">닉네임</div>
        </div>
        <div class="info-row">
          <div class="label">상품 이름</div>
          <div class="value" id="modalProductTitle">상품명</div>
        </div>
      </div>

      <div class="textarea-box">
        <label for="noteContent">쪽지 내용</label>
        <textarea id="noteContent" name="noteContent" placeholder="내용을 입력하세요." required></textarea>
      </div>

      <div class="modal-actions">
        <button type="submit" class="btn-submit" id="sendMessageBtn">보내기</button>
        <button type="button" class="btn-close" onclick="closeMessageModal()">닫기</button>
      </div>
    </div>
  </form>
</div>

<script>
function closeMessageModal() {
  document.getElementById("messageModal").style.display = "none";
}
</script>
