<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%
  java.util.List<dto.Product> pl = (java.util.List<dto.Product>) request.getAttribute("productList");
  for (dto.Product p : pl) {
    System.out.println("JSP 확인용 상품번호: " + p.getNo() + " 거리 = " + p.getDistance());
  }
%>

<link rel="stylesheet" href="${contextPath}/CSS/ProductList/productList.css" />
<div class="products-container">
  <div class="products">
    <c:forEach var="p" items="${productList}">
    <a href="${contextPath}/productDetail?no=${p.no}&tradeType=${p.tradeType}">
      <div class="product-card">
        <!-- 상품 이미지 -->
        
		<c:choose>
		  <c:when test="${empty p.img1}">
		    <img src="${contextPath}/img/default_product.png" alt="기본 이미지" loading="lazy"/>
		  </c:when>
		  <c:otherwise>
		    <img src="${contextPath}/upload/${p.img1}" alt="${p.title}" loading="lazy"/>
		  </c:otherwise>
		</c:choose>
		
        <!-- 상품 제목 -->
        <div class="product-title">${p.title}</div>

		<!-- 가격 및 타입 -->
		<div class="product-price">
		  <c:choose>
		    <c:when test="${p.tradeType == '나눔'}">
		      <span class="free">무료나눔</span><br/>
		    </c:when>
		    <c:otherwise>
		      <c:if test="${p.salePrice != null and p.tradeType != '대여' and p.tradeType != '나눔'}">
		        <span class="sale">판매가 <fmt:formatNumber value="${p.salePrice}" type="number" />원</span><br/>
		      </c:if>
		      <c:if test="${p.rentPrice != null}">
		        <span class="rent">대여가 <fmt:formatNumber value="${p.rentPrice}" type="number" />원/1일</span><br/>
		      </c:if>
		      <c:if test="${(p.tradeType == '대여' or p.tradeType == '판매/대여') and p.secPrice != null}">
		        <span class="deposit">보증금 <fmt:formatNumber value="${p.secPrice}" type="number" />원</span>
		      </c:if>
		    </c:otherwise>
		  </c:choose>
		</div>

		<div class="product-type">${p.tradeType}</div>

		
		<!--직거래지역 -->
        <div class="product-location">${p.deliveryAddr} ${p.formattedDistance}</div>

        <!-- 업로드된 시간 표시 -->
        <div class="product-meta">${p.timeAgo}</div>
      </div>
      </a>
    </c:forEach>
  </div>
</div>

<!-- 페이징: 항상 출력되도록 고정 -->
<c:if test="${pageInfo.allPage > 1}">
  <div id="paging">
  
    <%-- 이전 화살표 (첫 페이지엔 disabled) --%>
    <c:choose>
      <c:when test="${pageInfo.curPage == 1}">
        <span class="disabled">&laquo;</span>
      </c:when>
      <c:otherwise>
        <a href="#" data-page="${pageInfo.curPage - 1}">&laquo;</a>
      </c:otherwise>
    </c:choose>

    <%-- 1부터 allPage까지 번호 쭉 뿌리기 --%>
    <c:forEach var="i" begin="1" end="${pageInfo.allPage}">
      <c:choose>
        <c:when test="${pageInfo.curPage == i}">
          <span class="active">${i}</span>
        </c:when>
        <c:otherwise>
          <a href="#" data-page="${i}">${i}</a>
        </c:otherwise>
      </c:choose>
    </c:forEach>

    <%-- 다음 화살표 (마지막 페이지엔 disabled) --%>
    <c:choose>
      <c:when test="${pageInfo.curPage == pageInfo.allPage}">
        <span class="disabled">&raquo;</span>
      </c:when>
      <c:otherwise>
        <a href="#" data-page="${pageInfo.curPage + 1}">&raquo;</a>
      </c:otherwise>
    </c:choose>
  </div>
</c:if>
