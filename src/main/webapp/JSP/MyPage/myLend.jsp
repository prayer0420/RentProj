<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }" />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Lend List</title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/myLend.css">
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
          <h2>대여 상품</h2>
          <div class="divider"></div><br>
          
          <c:choose>
			<c:when test="${id eq null }">
				<span> 로그인이 필요한 페이지입니다.</span>
			</c:when>
			
			<c:otherwise>

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
	              <option value="preparing">배송준비중</option>
	              <option value="shipping">배송중</option>
	              <option value="delivered">배송완료</option>
	              <option value="cancelled">주문취소</option>
	            </select>
	          </div>
	
	          <!-- 상품 카드 1 -->
	          <c:forEach var="item" items="${lendList }">
		          <form action="">
		          
		          <div class="product-card">
		            <!-- 주문 정보 상단 영역 -->
		            <div class="order-info">
		              <div class="order-meta">
		                <span class="order-date">상품등록일: <fmt:formatDate value="${item.createDate }" pattern="yyyy년 MM월 dd일"/></span>
		              </div>
		              <div class="order-status-area">
		              	<c:choose>
			              	<c:when test="${item.orderNo eq null }">
		                  		<span class="status-text">상품게시중</span>&nbsp;&nbsp;&nbsp;&nbsp;
			              		<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
			              	</c:when>
			              	<c:otherwise>
		                		<span class="status-text">${item.orderStatus}</span>
		                		<a href="${contextPath }/myLendDetail?orderNo=${item.orderNo}" class="order-detail-link">주문 상세보기 &gt;</a>
		             		</c:otherwise>
		              	</c:choose>
		              </div>
		            </div>
		
		            <!-- 구분선 -->
		            <div class="card-divider"></div>
		
		            <!-- 상품 정보 영역 -->
		            <div class="card-content">
		            <a href="${contextPath }/productDetail?no=${item.no}">
		              <img
		                src="${contextPath}/upload/${item.img1}"
		                alt="상품 이미지"
		                class="product-image"
		              /></a>
		              <div class="product-info">
		                <p><a href="${contextPath }/productDetail?no=${item.no}">${item.no }</a></p>
		                <h3><a href="${contextPath }/productDetail?no=${item.no}">${item.title } </a></h3>
		                <p>1일 <fmt:formatNumber value="${item.price }" type="number" groupingUsed="true" />원</p>
		                <p class="sec-prices">보증금: <fmt:formatNumber value="${item.secPrice}" type="number" groupingUsed="true"/>원</p>
		              </div>
		              
		               <div class="status-change-btns">
		               <c:choose>
		               	<c:when test="${item.orderNo eq null}">
					        <button type="button" class="hide-btn" data-product-no="${item.no}">상품숨김</button>
					        <button type="button" class="delete-btn" data-product-no="${item.no}">상품삭제</button>
					        
		               	</c:when>
		               	<c:when test="${item.orderStatus eq '결제완료'}">
					        <button type="button" class="open-invoice-btn" data-orderno="${item.orderNo}">송장번호입력</button>
		               	</c:when>
		               	<c:when test="${item.orderStatus eq '반납배송중'}">
					        <button type="button" class="confirmReturn-btn" data-orderno="${item.orderNo}">상품반납확인</button>
		               	</c:when>
		               </c:choose>
		              </div>
		              
		            </div>
		          </div>
		          </form>
	          </c:forEach>
          
          <!-- 페이징 처리 --> 
	          <br>
				<jsp:include page="/JSP/MyPage/mypagePaging.jsp" > 
					<jsp:param name="baseUrl" value="${contextPath }/myLend" />
				</jsp:include>
				
          </c:otherwise>
          </c:choose>

        </section>
      </div>
    </div>

   
   <!-- 송장번호입력 모달 -->
   <jsp:include page="/JSP/MyPage/mypageModal.jsp" >
      <jsp:param name="redirectUrl" value="/rent/myLendDetail"/>
	</jsp:include>
   
   
   <!-- 상품숨기기 모달 -->
   <jsp:include page="/JSP/MyPage/hideProduct.jsp" />
   
   <!-- 상품삭제 모달 -->
   <jsp:include page="/JSP/MyPage/deleteProductModal.jsp" />
   
   <!-- 상품반납확인 모달 -->
   <jsp:include page="/JSP/MyPage/confirmReturnModal.jsp" />
   
   <!-- 상품삭제 AJAX -->
    <script>       
        $(document).ready(function() {
	    let selectedProductNo = null;  // 선택한 상품번호 저장용
	
	    // 삭제 버튼 클릭 시 (이벤트 위임)
	    $(document).on('click','.delete-btn',function(){
	    	console.log("버튼 클릭됨!"); // 확인용
	    	console.log("deleteModal 요소 찾기 시도:", $('#deleteModal').length); // 추가
	    	
	        selectedProductNo = $(this).data('product-no'); // 버튼에 심어놓은 상품번호 읽어오기
	        $('#deleteModal').fadeIn(); // 모달 띄우기
	    });
	
	    // 모달에서 '취소' 클릭 시
	    $('#cancelDelete').click(function() {
	        $('#deleteModal').fadeOut(); // 모달 닫기
	        selectedProductNo = null; // 초기화
	    });
	
	    // 모달에서 '확인' 클릭 시 (삭제 실행)
	    $('#confirmDelete').click(function() {
	        if (selectedProductNo) {
	            $.ajax({
	                url: '${contextPath}/deleteProduct',
	                method: 'POST',
	                data: { productNo: selectedProductNo },
	                dataType: 'json',
	                success: function(response) {
	                    if (response.success) {
	                        alert('상품이 삭제되었습니다.');
	                        $('#product-' + selectedProductNo).fadeOut(500, function() {
	                            $(this).remove();
	                        });
	                    } else {
	                        alert('상품 삭제에 실패했습니다.');
	                    }
	                    $('#deleteModal').fadeOut();
	                },
	                error: function(xhr, status, error) {
	                    alert('서버 오류로 삭제에 실패했습니다.');
	                    console.error(error);
	                    $('#deleteModal').fadeOut();
	                }
	            });
	        }
	    });
	});
</script>
			
<!-- 푸터 -->
	<jsp:include page="/JSP/Header/footer.jsp" />
      
</body>
</html>