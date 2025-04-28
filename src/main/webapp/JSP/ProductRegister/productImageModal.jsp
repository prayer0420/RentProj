<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/productRegister/productImageModal.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/productRegister/productImageCard.css" />

<div class="modal" id="imageModal" style="display: none;">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" onclick="closeImageModal()">×</button>
			<h3>사진 추가</h3>
		</div>
		<div class="modal-img-list" id="imageContainer">
		</div>
		<!-- ✅ 확인 버튼 -->
		<div class="modal-footer">
			<button type="button" class="confirm-button" onclick="confirmImages()">확인</button>
		</div>
	</div>
</div>

