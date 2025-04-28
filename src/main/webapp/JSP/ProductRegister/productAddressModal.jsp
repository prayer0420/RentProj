<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/productRegister/productAddressModal.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/productRegister/productAddressCard.css" />

<div class="modal" id="addressModal" style="display: none;">
	<div class="modal-content">
		<div class="modal-header">
			<button class="close" onclick="closeAddressModal()">×</button>
			<h3>배송지 목록</h3>
		</div>
		<div class="modal-address-list">
		</div>
			<c:if test="${address1!=null}">
				<div class="address-card">
					<c:set var="fullAddress1" value="${address1}" />
					<div class="card-header">
						<div>
							<strong class="alias1"></strong> <span class="badge">기본배송지</span>
						</div>
					</div>
					<div class="card-body">
						<p class="address1"></p>
						<p class="detail1"></p>

						<form action="#" method="get">
							<button type="button" class="edit-btn" onclick="addressCheck1()">확인</button>
						</form>
					</div>
				</div>
			</c:if>
			<c:if test="${address2!=null}">
				<div class="address-card">
					<c:set var="fullAddress2" value="${address2}" />
					<div class="card-header">
						<div>
							<strong class="alias2"></strong> <span class="badge">기본배송지</span>
						</div>
					</div>
					<div class="card-body">
						<p class="address2"></p>
						<p class="detail2"></p>

						<form action="#" method="get">
							<button type="button" class="edit-btn" onclick="addressCheck2()">확인</button>
						</form>
					</div>
				</div>
			</c:if>
			<c:if test="${address3!=null}">
				<div class="address-card">
					<c:set var="fullAddress3" value="${address3}" />
					<div class="card-header">
						<div>
							<strong class="alias3"></strong> <span class="badge">기본배송지</span>
						</div>
					</div>
					<div class="card-body">
						<p class="address3"></p>
						<p class="detail3"></p>

						<form action="#" method="get">
							<button type="button" class="edit-btn" onclick="addressCheck3()">확인</button>
						</form>
					</div>
				</div>
			</c:if>
			<c:if test="${address1 == null && address2 == null && address3 == null}">
				<div class="address-card">
					<h4>배송지가 없습니다. 마이페이지에서 추가해주세요.</h4>
					<a href="${pageContext.request.contextPath}/myOrder"><span>마이페이지
							이동</span></a>
				</div>
			</c:if>

	</div>
</div>
<script type="text/javascript">
	const fullAddress1 = "${address1}";
	const parts1 = fullAddress1.split("@@");
	const alias1 = parts1[0];
	const address1 = parts1[1];
	//const post1 = part1[2];
	const detail1 = parts1[3];
	
	const fullAddress2 = "${address2}";
	const parts2 = fullAddress2.split("@@");
	const alias2 = parts2[0];
	const address2 = parts2[1];
	//const post2 = part2[2];
	const detail2 = parts2[3];
	
	const fullAddress3 = "${address3}";
	const parts3 = fullAddress3.split("@@");
	const alias3 = parts3[0];
	const address3 = parts3[1];
	//const post3 = part3[2];
	const detail3 = parts3[3];
	

	document.querySelector(".alias1").innerText = alias1;
	document.querySelector(".address1").innerText = address1;
	//document.querySelector(".post1").innerText = post1;
	document.querySelector(".detail1").innerText = detail1;
	
	document.querySelector(".alias2").innerText = alias2;
	document.querySelector(".address2").innerText = address2;
	//document.querySelector(".post2").innerText = post2;
	document.querySelector(".detail2").innerText = detail2;

	
	document.querySelector(".alias3").innerText = alias3;
	document.querySelector(".address3").innerText = address3;
	//document.querySelector(".post3").innerText = post3;
	document.querySelector(".detail3").innerText = detail3;


	function addressCheck1() {
		document.querySelector('.addressRegion').innerText = "";
		document.querySelector('.address-name').innerText = "";
		
		document.querySelector('.addressRegion').innerText = address1 + "\n"
				+ detail1;
		document.getElementById("deliveryAddressInput").value = address1+detail1;
		document.querySelector('.address-name').innerText = alias1;

		closeAddressModal();
	}
	
	function addressCheck2() {
		document.querySelector('.addressRegion').innerText = "";
		document.querySelector('.address-name').innerText = "";
		
		document.querySelector('.addressRegion').innerText = address2 + "\n"
				+ detail2;
		document.getElementById("deliveryAddressInput").value = address2+detail2;
		document.querySelector('.address-name').innerText = alias2;

		closeAddressModal();
	}
	
	function addressCheck3() {
		document.querySelector('.addressRegion').innerText = "";
		document.querySelector('.address-name').innerText = "";
		
		document.querySelector('.addressRegion').innerText = address3 + "\n"
				+ detail3;
		document.getElementById("deliveryAddressInput").value = address3+detail3;
		document.querySelector('.address-name').innerText = alias3;

		closeAddressModal();
	}
	
	
	
</script>