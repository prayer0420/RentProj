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

</head>
<body>
	<%@ include file="header.jsp" %>
<div class="container">
  <aside>
    <h3>정산관리</h3>
    <div class="menu inactive">전체주문조회</div>
    <div class="menu inactive">전체수익조회</div>
    <div class="menu inactive">판매정산</div>
    <div class="menu active">대여지연조회</div>
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
        	<b>거래일자:</b>&nbsp;&nbsp;
		    <input type="date" name="start_date" value="${param.start_date}" />
		    <span>~</span>
		    <input type="date" name="end_date" value="${param.end_date}" />	
        <input type="submit" value="검색">

      </div>
	</form>
    

		<div style="margin-bottom:10px; font-weight:bold;">
		    🔍 검색된 총 지연주문 수: <span style="color:#007bff;">${not empty orderlist ? fn:length(orderlist) : 0}</span>건
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
      <th rowspan="2">거래유형</th>
      <th colspan="2">거래일자</th>
      <th colspan="3">결제금액</th>
      <th rowspan="2">결제수단</th>
      <th rowspan="2">거래 상태</th>
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
		  <c:forEach var="order" items="${orderList}" varStatus="status">
		    <tr>		    
		      <td>${status.index + 1}</td> <!-- 해당 리스트 넘버링 -->
		      <td>${order.orderNo}</td>
		      <td>${order.productNo}</td>
		      <td><a href="${pageContext.request.contextPath}/productDetail?no=${order.productNo}">${order.productName}</a></td> <!-- product.title -->
		      <td><a href="memberDetail?memberId=${order.buyerId}">${order.buyerId}</a></td>   <!-- member.id (구매자) -->
		      <td><a href="memberDetail?memberId=${order.sellerId}">${order.sellerId}</a></td>  <!-- member.id (판매자) -->
		      <td>${order.orderType}</td>
		      <td><fmt:formatDate value="${order.startDate}" pattern="yyyy-MM-dd" /></td>
		      <td><fmt:formatDate value="${order.endDate}" pattern="yyyy-MM-dd" /></td>
		      <td><fmt:formatNumber value="${order.price}" pattern="#,##0" /></td>
		      <td><fmt:formatNumber value="${order.deliveryPrice}" pattern="#,##0" /></td>
		      <td><fmt:formatNumber value="${order.secPrice}" pattern="#,##0" /></td>
		      <td>${order.paymentType}</td>
		      <td>${order.orderStatus}</td>
		    </tr>
		  </c:forEach>
		</tbody>
	</table>	

    <div class="notice">
      * 구매자/판매자 선택 시 각 회원의 상세 정보 페이지 제공
    </div>
  </main>
 </div>
</body>
</html>