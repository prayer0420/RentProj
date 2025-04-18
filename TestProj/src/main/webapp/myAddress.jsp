<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="css/header.css" />
<link rel="stylesheet" href="css/myAddress.css" />

<div class="address-page">
  <div class="address-header">
    <h2>배송지 관리</h2>
    <button class="add-address-btn" onclick="openAddressAddModal()">
      <i class="icon-truck"></i> 배송지 추가
    </button>
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

  <div class="address-list">
    <c:choose>
      <c:when test="${not empty addressList}">
        <c:forEach var="addr" items="${addressList}">
          <div class="address-card">
            <div class="card-top">
              <div class="alias-group">
                <strong>${addr.alias}</strong>
                <c:if test="${addr.isDefault == 'true'}">
                  <span class="badge">기본배송지</span>
                </c:if>
              </div>
              <form action="deleteAddress.do" method="post">
                <input type="hidden" name="id" value="${addr.id}" />
                <button type="submit" class="delete-btn">✕</button>
              </form>
            </div>
            <div class="card-body">
              <p>${addr.recipient} <span class="phone">| ${addr.phone}</span></p>
              <p>[${addr.zipcode}] ${addr.address} ${addr.detail}</p>
              <c:if test="${not empty addr.memo}">
                <p class="memo">${addr.memo}</p>
              </c:if>
              <form action="editAddressForm.do" method="get">
                <input type="hidden" name="id" value="${addr.id}" />
                <button type="submit" class="edit-btn">수정</button>
              </form>
            </div>
          </div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <p class="empty-text">등록된 배송지가 없습니다.</p>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<jsp:include page="addressAdd.jsp" />

<script>
  function openAddressAddModal() {
    document.getElementById('addressAddModal').style.display = 'flex';
  }
</script>

