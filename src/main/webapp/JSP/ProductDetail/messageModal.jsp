<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/productDetail/messageModal.css" />

<div class="modal-overlay" id="messageModal">
  <form action="${pageContext.request.contextPath}/message/send" method="post">
    <div class="modal">
      <div class="modal-title">쪽지보내기</div>
      <div class="modal-sub">상품 상세페이지 - 쪽지보내기</div>

      <!-- 서버에서 넘긴 변수 사용 -->
      <input type="hidden" name="receiver" value="${sellerName}">
      <input type="hidden" name="productTitle" value="${product.title}">

      <div class="info-box">
        <div class="info-row">
          <div class="label">받는 사람</div>
          <div class="value">${param.id}</div>
        </div>
        <div class="info-row">
          <div class="label">상품 이름</div>
          <div class="value">${product.title}</div>
        </div>
      </div>

      <div class="textarea-box">
        <label for="message">쪽지 보내기</label>
        <textarea id="message" name="message" placeholder="내용을 입력하세요." required></textarea>
      </div>

      <div class="modal-actions">
        <button type="submit" class="btn-submit">보내기</button>
        <button type="button" class="btn-close" onclick="closeMessageModal()">닫기</button>
      </div>
    </div>
  </form>
</div>