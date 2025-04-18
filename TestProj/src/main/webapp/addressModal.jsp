<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="css/addressModal.css" />
<link rel="stylesheet" href="css/addressCard.css" />

<div class="modal" id="addressModal" style="display: none;">
  <div class="modal-content">
    <div class="modal-header">
      <button class="close" onclick="closeAddressModal()">×</button>
      <h3>배송지 목록</h3>
    </div>

    <button class="modal-add-btn" onclick="openAddressAddModal()">+ 배송지 추가</button>

    <div class="modal-address-list">
<%--       <c:choose>
        <c:when test="${not empty addressList}">
          <c:forEach var="addr" items="${addressList}">
            <jsp:include page="addressCard.jsp">
              <jsp:param name="id" value="${addr.id}" />
              <jsp:param name="alias" value="${addr.alias}" />
              <jsp:param name="recipient" value="${addr.recipient}" />
              <jsp:param name="phone" value="${addr.phone}" />
              <jsp:param name="zipcode" value="${addr.zipcode}" />
              <jsp:param name="address" value="${addr.address}" />
              <jsp:param name="detail" value="${addr.detail}" />
              <jsp:param name="memo" value="${addr.memo}" />
              <jsp:param name="isDefault" value="${addr.isDefault}" />
            </jsp:include>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <p class="empty-text">등록된 배송지가 없습니다.</p>
        </c:otherwise>
      </c:choose> --%>
	</div>
	<div class="address-card">
		<div class="card-header">
			<div>
				<strong>우리집</strong> <span class="badge">기본배송지</span>
			</div>
			<form action="#" method="post">
				<button type="submit" class="delete-btn">✕</button>
			</form>
		</div>
		<div class="card-body">
			<p>홍길동</p>
			<p>010-1234-5678</p>
			<p>[12345] 서울시 강남구 테헤란로 123 101호</p>
			<form action="#" method="get">
				<button type="submit" class="edit-btn">수정</button>
			</form>
		</div>
	</div>
	
  </div>
</div>
	<jsp:include page="addressAdd.jsp"></jsp:include>