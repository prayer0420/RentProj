<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>대여지연조회</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/common.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/modal.css">

</head>
<body>
	<%@ include file="header.jsp" %>
<div class="container">
  <aside>
    <h3>정산관리</h3>
    <div class="menu inactive"><a href="orderList" style="color: inherit; text-decoration: none;">전체주문조회</a></div>
    <div class="menu inactive"><a href="settlementList" style="color: inherit; text-decoration: none;">주문정산</a></div>
    <div class="menu active"><a href="rentalDelayList" style="color: inherit; text-decoration: none;">대여지연조회</a></div>
  </aside>

  <main>
    <div class="breadcrumb">HOME > 정산관리 > 대여지연조회</div>
	<form method="post" action="${pageContext.request.contextPath}/rentalDelayList">
    <div class="search-box">
        <label><b>검색어:</b>&nbsp;&nbsp;
          <select name="type">
	          <option value="orderNo" ${param.type == 'orderNo' ? 'selected' : ''}>주문번호</option>
			  <option value="productNo" ${param.type == 'productNo' ? 'selected' : ''}>상품번호</option>
			  <option value="productName" ${param.type == 'productName' ? 'selected' : ''}>상품명</option>
          </select>
        </label>
            <input type="text" name="keyword" value="${param.keyword}" />
        <br><br>
        	<b style="font-size: 13px;">거래일자:</b>&nbsp;&nbsp;
		    <input type="date" name="start_date" value="${param.start_date}" />
		    <span>~</span>
		    <input type="date" name="end_date" value="${param.end_date}" />	
        <input type="submit" value="검색">

      </div>
	</form>
    

		<div style="margin-bottom:10px; font-weight:bold;">
		    🔍 검색된 총 지연주문 수: <span style="color:#007bff;">${not empty orderList ? fn:length(orderList) : 0}</span>건
		</div>

  <table>
  <thead>
    <tr>
      <th rowspan="2">No</th>
      <th rowspan="2">주문번호</th>
      <th rowspan="2">상품번호</th>
      <th rowspan="2">상품명</th>
      <th rowspan="2">구매자</th>
      <th rowspan="2">판매자</th>
      <th colspan="2">거래일자</th>
      <th colspan="3">결제금액</th>
      <th rowspan="2">거래상태</th>
      <th rowspan="2">알림</th>
      
    </tr>
    <tr>
      <th>거래시작일</th>
      <th>거래종료일</th>
      <th>물품가</th>
      <th>배송비</th>
      <th>보증금</th>
    </tr>
  </thead>
		<tbody>
		<c:if test="${not empty orderList}">
		  <c:forEach var="order" items="${orderList}" varStatus="status">
		    <tr>		    
		      <td>${status.index + 1}</td> <!-- 해당 리스트 넘버링 -->
		      <td>${order.orderNo}</td>
		      <td>${order.productNo}</td>
		      <td><a href="${pageContext.request.contextPath}/productDetail?no=${order.productNo}">${order.productName}</a></td> <!-- product.title -->
		      <td><a href="javascript:void(0);" onclick="openMemberDetail('${order.buyerId}')">${order.buyerId}</a></td>   <!-- member.id (구매자) -->
		      <td><a href="javascript:void(0);" onclick="openMemberDetail('${order.sellerId}')">${order.sellerId}</a></td>  <!-- member.id (판매자) -->
		      <td><fmt:formatDate value="${order.startDate}" pattern="yyyy-MM-dd" /></td>
		      <td><fmt:formatDate value="${order.endDate}" pattern="yyyy-MM-dd" /></td>
		      <td><fmt:formatNumber value="${order.price}" pattern="#,##0" /></td>
		      <td><fmt:formatNumber value="${order.deliveryPrice}" pattern="#,##0" /></td>
		      <td><fmt:formatNumber value="${order.secPrice}" pattern="#,##0" /></td>
		      <td>${order.orderStatus}</td>
		      <td><button>알림전송</button></td>
		    </tr>
		  </c:forEach>
		  </c:if>
		  <c:if test="${empty orderList}">
		      <tr>
		        <td colspan="13" style="text-align:center;">데이터가 없습니다.</td>
		      </tr>
		  </c:if>
		</tbody>
	</table>	

    <div class="info-note">
      ※구매자/판매자 선택 시 각 회원의 상세 정보 페이지 제공
    </div>
    
    <!-- 모달 HTML -->
		<div id="memberModal" class="modal">
		  <div class="modal-content">
		    <div class="modal-title">[회원정보상세]</div>
		    <div class="modal-close">
		      <button onclick="document.getElementById('memberModal').style.display='none'">닫기</button>
		    </div>
		    <div id="memberDetailBody"></div>
		  </div>
		</div>
		
		
  </main>
 </div>
 
 	<!-- 판매자 구매자id 눌렀을때 상세 정보 팝업 추가 -->
 	<script>
		function openMemberDetail(memberId) {
		  fetch('${pageContext.request.contextPath}/memberDetailModal?memberId=' + memberId)
		    .then(res => res.text())
		    .then(html => {
		      document.getElementById('memberDetailBody').innerHTML = html;
		      document.getElementById('memberModal').style.display = 'block';
		    }).catch(err => {
		      document.getElementById('memberDetailBody').innerHTML = '<p>회원 정보를 불러오지 못했습니다.</p>';
		    });
		}
		
			// 모달 닫기
			window.addEventListener('click', function(event) {
			  const modal = document.getElementById('memberModal');
			  // 바깥 영역만 클릭되었을 때
			  if (event.target === modal) {
			    modal.style.display = 'none';
			  }
			});
		</script>	
</body>
</html>