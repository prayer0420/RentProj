<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    <%@ page import="dto.Member" %>
    <% 
    	Member id = (Member) request.getAttribute("loginId");
    %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Product List</title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/mySell.css">
</head>
<body>
<!-- 헤더 (로고 + 검색창 + 카테고리) -->
  <jsp:include page="/JSP/Header/header.jsp" />
	 <div class="wrapper">
      <div class="container">
        <!-- 사이드바 -->
        <jsp:include page="/JSP/MyPage/mypageSidebar.jsp" />

        <!-- 콘텐츠 영역 -->
        <section class="content">
          <h2>판매 상품</h2>
          <div class="divider"></div>

          <!-- 드롭다운 메뉴 영역 -->
          <div class="filter-section">
            <select class="filter-dropdown" name="period">
              <option value="">조회 기간 선택</option>
              <option value="12months">전체</option>
              <option value="7days">최근 7일</option>
              <option value="1month">1개월</option>
              <option value="3months">3개월</option>
              <option value="6months">6개월</option>
            </select>

            <select class="filter-dropdown" name="status">
              <option value="">배송 상태 선택</option>
              <option value="all">전체</option>
              <option value="">상품준비중</option>
              <option value="">배송중</option>
              <option value="">배송완료</option>
              <option value="">거래완료</option>
            </select>
          </div>

          <!-- 상품 카드 1 -->
          <c:forEach var="item" items="${productList }">
          <form action="">
	          <div class="product-card" id="product">
	            <!-- 주문 정보 상단 영역 -->
	            <div class="order-info">
	              <div class="order-meta">
	                <span class="order-date">상품등록일: ${item.createDate}</span>
	                <span class="status-text">${item.orderStatus }</span>
	              </div>
	              <div class="order-status-area">
	                <a href="${contextPath }/mySellDetail?orderNo=${item.orderNo }" class="order-detail-link">거래 상세보기 &gt;</a>
	              </div>
	            </div>
	
	            <!-- 구분선 -->
	            <div class="card-divider"></div>
	
	            <!-- 상품 정보 영역 -->
	            <div class="card-content">
	              <img
	                src="${contextPath }/img/camera.jpg"
	                alt="상품 이미지"
	                class="product-image"
	              />
	              <div class="product-info">
	                <p>${item.no }</p>
	                <h3>${item.title }</h3>
	                <p>가격: ${item.salePrice }원</p>
	                <p>배송비: ${item.deliveryPrice}원</p>
	              </div>
	              <div class="status-change-btns">
	               <c:if test="${item.orderStatus eq '결제완료'}">
				        <button class="open-invoice-btn" data-orderno="${item.orderNo}">송장번호입력</button>
				   </c:if> 
	              </div>
	            </div>
	          </div>
          </form>
          </c:forEach>
          
          <!-- 송장번호입력 모달 -->
          <div id="invoceModal" class="modal">
					  <div class="modal-content">
					    <span class="close-tracking">&times;</span>
					    <form id="invoiceForm">
					      <input type="hidden" id="orderNo" value="${item.orderNo}" />
					      <label for="deliveryComp">택배사</label>
					      <input type="text" id="deliveryComp" required />
					      <label for="invoiceNo">송장번호</label>
					      <input type="text" id="invoiceNo" required />
					      <button type="button" id="submitInvoiceBtn">등록</button>
					    </form>
					  </div>
					</div>
					
					
          <!-- 페이징 처리 --> 
          <br>
			<jsp:include page="/JSP/MyPage/mypagePaging.jsp" />
			
        </section>
      </div>
    </div>
    
					
<!-- 푸터 -->
  <jsp:include page="/JSP/Header/footer.jsp" />
  
</body>

	<script type="text/javascript">
	
		<!-- modal.js (jQuery) -->
		$(document).ready(function () {
			
		  // 송장번호 입력 모달 열기
		  $(".open-invoice-btn").on("click", function () {
		    const orderNo = $(this).data("order");
		    $("#orderNo").val(orderNo); // hidden input에 세팅
		    $("#invoiceModal").fadeIn();
		  });
		
		    $.ajax({
		        type: "POST",
		        url: "/InvoiceSetting", // 서블릿 매핑 경로
		        data: {
		            orderNo: orderNo,
		            deliveryComp: deliveryComp,
		            invoiceNo: invoiceNo
		        },
		        success: function (res) {
		            // 성공 시 페이지 리다이렉트
		            window.location.href = "/mySellDetail";
		        },
		        error: function (xhr, status, error) {
		            alert("송장 입력에 실패했습니다. 다시 시도해주세요.");
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

</html>