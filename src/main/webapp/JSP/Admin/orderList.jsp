<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>전체주문조회</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/common.css">
  <style>

    .search-box .row:last-child {
      margin-bottom: 0;
    }

  </style>
</head>
<body>
	<%@ include file="header.jsp" %>
<div class="container">
  <aside>
    <h3>정산관리</h3>
    <div class="menu active"><a href="orderList" style="color: inherit; text-decoration: none;">전체주문조회</a></div>
    <div class="menu inactive"><a href="settlementList" style="color: inherit; text-decoration: none;">주문정산</a></div>
    <div class="menu inactive"><a href="rentalDelayList" style="color: inherit; text-decoration: none;">대여지연조회</a></div>
  </aside>
  <main>
    <div class="breadcrumb">HOME > 정산관리 > 전체주문조회</div>

          <form action="orderList" method="post">
      <div class="search-box">
        <label><b>검색어:</b>&nbsp;&nbsp;
          <select name="type">
	          <option value="orderNo" ${param.type == 'orderNo' ? 'selected' : ''}>주문번호</option>
			  <option value="buyerId" ${param.type == 'buyerId' ? 'selected' : ''}>구매자 ID</option>
			  <option value="sellerId" ${param.type == 'sellerId' ? 'selected' : ''}>판매자 ID</option>
          </select>
        </label>
            <input type="text" name="keyword" value="${param.keyword}" />
        <br><br>
        	<b>거래일자:</b>&nbsp;&nbsp;
		    <input type="date" name="start_date" value="${param.start_date}" />
		    <span>~</span>
		    <input type="date" name="end_date" value="${param.end_date}" />	
        <input type="submit" value="검색">
        <br><br>
        <b>거래유형:</b>&nbsp;&nbsp;
	    <label><input type="radio" name="order_type" value="all" ${param.order_type == 'all' || param.order_type == null ? 'checked' : ''}> 전체</label>
	    <label><input type="radio" name="order_type" value="판매" ${param.order_type == '판매' ? 'checked' : ''}> 판매</label>
	    <label><input type="radio" name="order_type" value="대여" ${param.order_type == '대여' ? 'checked' : ''}> 대여</label>
	    <label><input type="radio" name="order_type" value="나눔" ${param.order_type == '나눔' ? 'checked' : ''}> 나눔</label>
      </div>
      </form>


		<div style="margin-bottom:10px; font-weight:bold;">
		    🔍 검색된 총 주문 수: <span style="color:#007bff;">${pageInfo.totalCount != null ? pageInfo.totalCount : 0}</span>건
		</div>

   <table>
  <thead>
    <tr>
      <th rowspan="2">주문번호</th>
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
	<c:if test="${not empty orderList}">
	  <c:forEach var="order" items="${orderList}">
	    <tr>
	      <td>${order.orderNo}</td>
	      <td><a href="${pageContext.request.contextPath}/productDetail?no=${order.productNo}">${order.productName}</a></td> <!-- product.title -->
	      <td>${order.buyerId}</td>   <!-- member.id (구매자) -->
	      <td>${order.sellerId}</td>  <!-- member.id (판매자) -->
	      <td>${order.orderType}</td>
	      <td><fmt:formatDate value="${order.startDate}" pattern="yyyy-MM-dd" /></td>
	      <td><fmt:formatDate value="${order.endDate}" pattern="yyyy-MM-dd" /></td>
	      <td><fmt:formatNumber value="${order.price != null ? order.price : 0}" pattern="#,##0" /></td>
	      <td><fmt:formatNumber value="${order.deliveryPrice != null ? order.deliveryPrice : 0}" pattern="#,##0" /></td>
	      <td><fmt:formatNumber value="${order.secPrice != null ? order.secPrice : 0}" pattern="#,##0" /></td>
	      <td>${order.paymentType}</td>
	      <td>${order.orderStatus}</td>
	    </tr>
	  </c:forEach>
	  </c:if>
	 <c:if test="${empty orderList}">
      <tr>
        <td colspan="12" style="text-align:center;">데이터가 없습니다.</td>
      </tr>
    </c:if>
	</tbody>
</table>

      <div class="info-note">
      ※주문번호 및 상품명 선택 시, 해당 상품 게시글로 화면 이동
    </div>
 	  <br>
		    <c:if test="${not empty pageInfo and not empty orderList}">
		  <div class="pagination">
		  
		    <!-- 이전 페이지 -->
		    <c:if test="${pageInfo.startPage > 1}">
		      <form method="post" action="${pageContext.request.contextPath}/orderList"  style="display:inline;">
		        <input type="hidden" name="page" value="${pageInfo.startPage - 1}" />
	            <input type="hidden" name="type" value="${param.type}" />
	            <input type="hidden" name="keyword" value="${param.keyword}" />
	            <input type="hidden" name="order_type" value="${param.order_type}" />
	            <input type="hidden" name="start_date" value="${param.start_date}" />
	            <input type="hidden" name="end_date" value="${param.end_date}" />
		        <button type="submit">이전</button>
		      </form>
		    </c:if>
		
		    <!-- 페이지 번호 -->
		    <c:forEach var="p" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
		      <form method="post" action="${pageContext.request.contextPath}/orderList" style="display:inline;">
		        <input type="hidden" name="page" value="${p}" />
	            <input type="hidden" name="type" value="${param.type}" />
	            <input type="hidden" name="keyword" value="${param.keyword}" />
	            <input type="hidden" name="order_type" value="${param.order_type}" />
	            <input type="hidden" name="start_date" value="${param.start_date}" />
	            <input type="hidden" name="end_date" value="${param.end_date}" />	
		        <button type="submit"
		          <c:if test="${p == pageInfo.curPage}">style="font-weight:bold;"</c:if>>
		          ${p}
		        </button>
		      </form>
		    </c:forEach>
		
		    <!-- 다음 페이지 -->
		    <c:if test="${pageInfo.endPage < pageInfo.allPage}">
		      <form method="post" action="${pageContext.request.contextPath}/orderList" style="display:inline;">
	            <input type="hidden" name="page" value="${pageInfo.endPage + 1}" />
	            <input type="hidden" name="type" value="${param.type}" />
	            <input type="hidden" name="keyword" value="${param.keyword}" />
	            <input type="hidden" name="order_type" value="${param.order_type}" />
	            <input type="hidden" name="start_date" value="${param.start_date}" />
	            <input type="hidden" name="end_date" value="${param.end_date}" />			
		        <button type="submit">다음</button>
		      </form>
		    </c:if>
		    
		  </div>
		</c:if>
  </main>
</div>
</body>
</html>