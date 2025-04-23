<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/productDetail/addressModal.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/productDetail/addressCard.css" />

<div class="modal" id="addressModal" style="display: none;">
	<div class="modal-content">
		<div class="modal-header">
			<button class="close" onclick="closeAddressModal()">×</button>
			<h3>배송지 목록</h3>
		</div>
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
			<c:choose >
			<c:when test="${member.address1!=null}">
				<div class="card-header">
					<div>
						<strong>우리집</strong> <span class="badge">기본배송지</span>
					</div>
				</div>
				<div class="card-body">
					<p>${member.nickname}</p>
					<p>${member.phone}</p>
					<p>${member.address1} ${member.region1 }</p>
					<form action="#" method="get">
						<button type="button" class="edit-btn" onclick="addressCheck()">확인</button>
					</form>
				</div>			
			</c:when>
			<c:when test="${member.address1 == null}">
				<h4>배송지가 없습니다. 마이페이지에서 추가해주세요.</h4>
				<a href="${pageContext.request.contextPath}/myOrder"><span>마이페이지 이동</span></a>
			</c:when>
			</c:choose>
		</div>

	</div>
</div>
<jsp:include page="addressAdd.jsp"></jsp:include>
<script type="text/javascript">
	function addressCheck(){
		const address1 = "${member.address1}";
		const region1 = "${member.region1}";
		const phone = "${member.phone}";
		
		
		
		document.querySelector('.addressRegion').innerText=address1+" "+region1;
		document.querySelector('.phone').innerText=phone;
		
		closeAddressModal();
	}
</script>