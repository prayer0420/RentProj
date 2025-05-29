<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/productDetail/addressCard.css" />

<div class="address-card">
	<div class="card-header">
		<div>
			<strong>${param.alias}</strong>
			<c:if test="${param.isDefault == 'true'}">
				<span class="badge">기본배송지</span>
			</c:if>
		</div>
		<form action="deleteAddress.do" method="post">
			<input type="hidden" name="id" value="${param.id}" />
			<button type="submit" class="delete-btn">✕</button>
		</form>
	</div>
	<div class="card-body">
		<p>${param.recipient}</p>
		<p>${param.phone}</p>
		<p>[${param.zipcode}] ${param.address} ${param.detail}</p>
		<form action="editAddressForm.do" method="get">
			<input type="hidden" name="id" value="${param.id}" />
			<button type="submit" class="edit-btn">수정</button>
		</form>
	</div>
</div>