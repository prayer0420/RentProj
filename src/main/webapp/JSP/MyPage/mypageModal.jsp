<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage Modal</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/invoiceModal.css">

<script type="text/javascript">
	
		<!-- modal.js (jQuery) -->
		$(document).ready(function () {
			console.log("버튼 클릭됨!"); // 확인용
			
			
		  // 송장번호 입력 모달 열기
		  $(".open-invoice-btn").on("click", function () {
		    const orderNo = $(this).data("orderno");
		    $("#orderNo").val(orderNo); // hidden input에 세팅
		    $("#invoiceModal").fadeIn();
		  });
		  
		  // 송장번호 입력 후 데이터 전송
		  $("#submitInvoiceBtn").on("click", function () {
			    const orderNo = $("#orderNo").val();
			    const deliveryComp = $("#deliveryComp").val();
			    const invoiceNo = $("#invoiceNo").val();
			    const redirectUrl = $("#redirectUrl").val(); // 리다이렉트용 URL
		
		    $.ajax({
		        type: "POST",
		        url: "/rent/invoiceSetting", // 서블릿 매핑 경로
		        data: {
		            orderNo: orderNo,
		            deliveryComp: deliveryComp,
		            invoiceNo: invoiceNo
		        },
		        success: function (res) {
		            // 성공 시 페이지 리다이렉트
		            window.location.href = redirectUrl + "?orderNo=" + orderNo;	//동적 리다이렉트
		        },
		        error: function (xhr, status, error) {
		            alert("송장 등록에 실패했습니다. 다시 시도해주세요.");
		        }
		    });
		  });
		  
		    
		 // 닫기
			$(".close").on("click", function () {
			    $("#invoiceModal").fadeOut();
		  	});
		 
		 
		// 외부 클릭 시 모달 닫기
		  $(window).on("click", function (e) {
		    if ($(e.target).is("#invoiceModal")) {
		      $("#invoiceModal").fadeOut();
		    }
		  });
		 
		});
	</script>
</head>
<body>

 <!-- 송장번호입력 모달 -->
          <div id="invoiceModal" class="modal" >
			<div class="modal-content">
				<span class="close">&times;</span>
				<form id="invoiceForm">
					<input type="hidden" id="orderNo" value="${item.orderNo}" />
					<input type="hidden" id="redirectUrl" value="${redirectUrl}" /> <!-- 리다이렉트 URL 세팅 -->
					<div class="input-row">
					<label for="deliveryComp">택배사</label>
					<input type="text" id="deliveryComp" required /></div><br>
					<div class="input-row">
					<label for="invoiceNo">송장번호</label>
					<input type="text" id="invoiceNo" required /></div><br>
					<button type="button" id="submitInvoiceBtn">등록</button>
				 </form>
			</div>
		</div>
    
</body>
</html>