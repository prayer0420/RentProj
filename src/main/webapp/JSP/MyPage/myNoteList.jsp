<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${contextPath}/CSS/mypage/myNoteList.css" />

<jsp:include page="/JSP/Header/header.jsp" />
<div class="wrapper">
  <div class="container">
    <jsp:include page="/JSP/MyPage/mypageSidebar.jsp" />

    <section class="content">
      <h2 class="title">나의 쪽지함</h2>
      <div class="divider"></div>

      <div class="note-tabs">
        <button class="tab-button active" data-target="receivedBox">받은 쪽지</button>
        <button class="tab-button" data-target="sentBox">보낸 쪽지</button>
      </div>

      <form id="noteForm" method="post" action="${contextPath}/noteSend">
        <input type="hidden" name="origin" value="myNoteList" />
        <div class="note-actions-bar">
          <label><input type="checkbox" id="checkAll"> 전체 선택</label>
          <button type="submit" class="delete-selected-btn">선택 삭제</button>
        </div>

        <div class="note-header-row">
          <span></span>
          <span>보낸 사람</span>
          <span>상품명</span>
          <span>내용</span>
          <span>받은 시간</span>
          <span class="note-header-extra">비고</span>
        </div>

        <div class="note-list active" id="receivedBox">
          <c:forEach var="note" items="${receivedNotes}">
            <div class="note-row" onclick="toggleNoteDetail(this)">
              <input type="checkbox" class="check-item" name="noteIds" value="${note.noteNo}" onclick="event.stopPropagation();">
              <span class="note-who">${note.senderNickname}</span>
              <span class="note-title">${note.productTitle}</span>
              <span class="note-preview">
			  <c:choose>
			    <c:when test="${fn:length(note.noteContent) > 15}">
			      ${fn:substring(note.noteContent, 0, 15)}...
			    </c:when>
			    <c:otherwise>
			      ${note.noteContent}
			    </c:otherwise>
			  </c:choose>
			</span>

              <span class="note-time"><fmt:formatDate value="${note.curdate}" pattern="yyyy-MM-dd HH:mm"/></span>
              <div class="note-detail">
                <div class="note-full">${note.noteContent}</div>
                <div class="note-actions">
                  <a href="${contextPath}/productDetail?no=${note.productNo}" class="btn-detail">상품 보러가기</a>
                  <button type="button" class="btn-reply"
                    onclick="event.stopPropagation(); openNoteModal(${note.senderNo}, '${note.senderNickname}', ${note.productNo}, '${note.productTitle}')">답장</button>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>

		<div class="note-list" id="sentBox">
		  <c:forEach var="note" items="${sentNotes}">
		    <div class="note-row" onclick="toggleNoteDetail(this)">
		      <input type="checkbox" class="check-item" name="noteIds" value="${note.noteNo}" onclick="event.stopPropagation();">
		      <span class="note-who">${note.receiverNickname}</span>
		      <span class="note-title">${note.productTitle}</span>
		      <span class="note-preview">
		        <c:choose>
		          <c:when test="${fn:length(note.noteContent) > 15}">
		            ${fn:substring(note.noteContent, 0, 15)}...
		          </c:when>
		          <c:otherwise>
		            ${note.noteContent}
		          </c:otherwise>
		        </c:choose>
		      </span>
		      <span class="note-time"><fmt:formatDate value="${note.curdate}" pattern="yyyy-MM-dd HH:mm"/></span>
		      <div class="note-detail">
		        <div class="note-full">${note.noteContent}</div>
		        <div class="note-actions">
		          <a href="${contextPath}/productDetail?no=${note.productNo}" class="btn-detail">상품 보러가기</a>
		          <button type="button" class="btn-reply"
		            onclick="event.stopPropagation(); openNoteModal(${note.receiverNo}, '${note.receiverNickname}', ${note.productNo}, '${note.productTitle}')">답장</button>
		        </div>
		      </div>
		    </div>
		  </c:forEach>
		</div>

      </form>
    </section>
  </div>
</div>

<jsp:include page="/JSP/ProductDetail/noteModal.jsp" />
<jsp:include page="/JSP/Header/footer.jsp" />

<script>
document.querySelectorAll('.tab-button').forEach(btn => {
  btn.addEventListener('click', function() {
    document.querySelectorAll('.tab-button').forEach(b => b.classList.remove('active'));
    document.querySelectorAll('.note-list').forEach(list => list.classList.remove('active'));
    this.classList.add('active');
    const targetId = this.getAttribute('data-target');
    document.getElementById(targetId).classList.add('active');
  });
});

document.getElementById("checkAll").addEventListener("change", function () {
  document.querySelectorAll(".check-item").forEach(cb => cb.checked = this.checked);
});

document.getElementById("noteForm").addEventListener("submit", function (e) {
  const checked = document.querySelectorAll(".check-item:checked");
  if (checked.length === 0) {
    alert("삭제할 쪽지를 선택하세요.");
    e.preventDefault();
  } else if (!confirm("선택한 쪽지를 삭제하시겠습니까?")) {
    e.preventDefault();
  }
});

function toggleNoteDetail(row) {
  const detail = row.querySelector('.note-detail');
  detail.classList.toggle('open');
}

function openNoteModal(memberNo, nickname, productNo, productTitle) {
  document.getElementById("modalReceiverNo").value = memberNo;
  document.getElementById("modalProductNo").value = productNo;
  document.getElementById("modalReceiverName").textContent = nickname;
  document.getElementById("modalProductTitle").textContent = productTitle;
  
  document.getElementById("messageModal").style.display = "flex";
}

function closeMessageModal() {
  document.getElementById("messageModal").style.display = "none";
}
</script>