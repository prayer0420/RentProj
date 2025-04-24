<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Lend Detail</title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/myLendDetail.css">
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
          <h2>대여 상세</h2>
          <div class="divider"></div>
          
          <c:choose>
			<c:when test="${id eq null }">
				<span> 로그인이 필요한 페이지입니다.</span>
			</c:when>
			
			<c:otherwise>
          
	          <div class="section product-box">
	                <img src="https://via.placeholder.com/120x100?text=🚲" alt="자전거">
	                <div class="product-info">
	                    <div style="font-size: 13px; color: gray;">상품번호: ${myLendDetail.no }</div>
	                    <div class="product-title">${myLendDetail.title }</div>
	                    <div class="price">1일 <fmt:formatNumber value="${myLendDetail.price }" type="number" groupingUsed="true"/>원 </div>
	                </div>
	                <span class="status-text">${myLendDetail.orderStatus }</span>
	            </div>
	
	            <div class="info-grid">
	                <div class="info-box">
	                    <h4>대여 배송 정보</h4>
	                    <p>송장번호: ${myLendDetail.invoiceNo }</p>
	                    <p>택배사: ${myLendDetail.deliveryComp }</p>
	                    <p>배송지: ${myLendDetail.deliveryAddr }</p>
	                </div>
	                <div class="info-box">
	                    <h4>대여회원 정보</h4>
	                    <p>${myLendDetail.id }</p>
	                    <p>${myLendDetail.phone }</p>
	                    <p></p>
	                    
	                </div>
	            </div>
	
	            <div class="info-grid" style="margin-top: 20px;">
	                <div class="info-box">
	                    <h4>대여 기간</h4>
	                    <p>대여 신청일: <fmt:formatDate value="${myLendDetail.orderDate }" pattern="yyyy년 MM월 dd일" /> </p>
	                    <p>대여 시작일: <fmt:formatDate value="${myLendDetail.startDate }" pattern="yyyy년 MM월 dd일"/></p>
	                    <p><strong>대여 종료일: <fmt:formatDate value="${myLendDetail.endDate }" pattern="yyyy년 MM월 dd일"/> </strong></p>
	                    <p><strong>상품 회수일:</strong></p>
	                    
	                </div>
	                <div class="info-box">
	                    <h4>결제정보</h4>
	                    <p><strong>총 결제금액: 400,000원 </strong></p>
	                    <p>1일 이용금액: <fmt:formatNumber value="${myLendDetail.price }" type="number" groupingUsed="true"/>원 &nbsp;&nbsp;<strong>총 3일 이용</strong></p>
	                    <p>보증금: <fmt:formatNumber value="${myLendDetail.secPrice }" type="number" groupingUsed="true"/>원</p>
	                    <p>배송비: <fmt:formatNumber value="${myLendDetail.deliveryPrice }" type="number" groupingUsed="true"/>원</p>
	                </div>
	            </div>
            
             <div class="rental-table-wrapper">
                <h3>이 상품의 대여 거래 이력</h3>
                <div class="divider"></div>
                <table class="rental-table">
                    <thead>
                        <tr>
                            <th>이용자ID</th>
                            <th>대여기간</th>
                            <th>이용일</th>
                            <th>이용금액</th>
                            <th>상품훼손/연체</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="history" items="${lendHistoryList }">
	                        <tr class="highlight">
	                            <td><strong>deoksoo1243</strong></td>
	                            <td><strong>2025-03-04 ~ 2025-03-07</strong></td>
	                            <td><strong>3일</strong></td>
	                            <td><strong>300,000원</strong></td>
	                            <td>없음</td>
	                        </tr>
                        </c:forEach>
                        <tr>
                            <td>dong</td>
                            <td>2025-02-11 ~ 2025-02-12</td>
                            <td>3일</td>
                            <td>300,000원</td>
                            <td>없음</td>
                        </tr>
                        <tr>
                            <td>honggil</td>
                            <td>2025-03-01 ~ 2025-03-04</td>
                            <td>3일</td>
                            <td>300,000원</td>
                            <td>없음</td>
                        </tr>
                        <tr>
                            <td>honggil</td>
                            <td>2025-03-01 ~ 2025-03-04</td>
                            <td>3일</td>
                            <td>300,000원</td>
                            <td>없음</td>
                        </tr>
                        <tr>
                            <td>honggil</td>
                            <td>2025-03-01 ~ 2025-03-04</td>
                            <td>3일</td>
                            <td>300,000원</td>
                            <td>없음</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            </c:otherwise>
            </c:choose>
            
          </section>
        </div>
    </div>
    
    <!-- 푸터 -->
	<jsp:include page="/JSP/Header/footer.jsp" />
		  
	<script>
	$(document).ready(function() {
	    $('.history-row').click(function() {
	        const rentNo = $(this).data('orderNo');
	
	        $.ajax({
	            url: '/lendHistoryDetail',
	            method: 'GET',
	            data: { rentNo: rentNo },
	            dataType: 'json',
	            success: function(data) {
	                $('#detailUserId').text(data.userId);
	                $('#detailPeriod').text(data.startDate + " ~ " + data.endDate);
	                $('#detailPrice').text(data.price + "원");
	                $('#detailNote').text(data.note || "없음");
	            },
	            error: function(err) {
	                alert("대여 상세정보를 불러오는 데 실패했습니다.");
	                console.log(err);
	            }
	        });
	    });
	});
	</script>
</body>
</html>