<%@ page contentType="text/html;charset=UTF-8"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/productDetail/singo.css" />
<!-- 신고 모달 -->
<div id="reportModal">
  <div class="modal-content">
    <h2>신고하기</h2>

    <select id="reportReason" name="type" required>
      <option value="">신고 사유를 선택하세요</option>
      <option value="금지품목">금지품목</option>
      <option value="사기의심">사기의심</option>
      <option value="콘텐츠부적절">콘텐츠부적절</option>
    </select>
     <!-- 🔥 제목 입력 추가 -->
    <input type="text" name="title" id="reportTitle" placeholder="제목을 입력하세요" required />

    <textarea id="reportDetail" placeholder="신고 내용을 입력하세요" required></textarea>

    <div class="modal-buttons">
      <button class="submit-btn" onclick="submitReport()">보내기</button> <!-- 왼쪽 -->
      <button class="cancel-btn" onclick="closeReportModal()">닫기</button> <!-- 오른쪽 -->
    </div>
  </div>
</div>