<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/ProductList/productList.css" />

<div class="products-container">
  <div class="products">
    <c:forEach var="p" items="${productList}">
    <a href="${pageContext.request.contextPath}/productDetail?no=${p.no}&tradeType=${p.tradeType}">
      <div class="product-card">
        <!-- 상품 이미지 -->
        <img src="${p.img1}" alt="${p.title}" />

        <!-- 상품 제목 -->
        <div class="product-title">${p.title}</div>

        <!-- 가격 및 타입 -->
        <div class="product-info">
          <div class="product-price">
            <c:if test="${p.salePrice != null}">
              <span class="sale">판매가 ${p.salePrice}원</span><br/>
            </c:if>
            <c:if test="${p.rentPrice != null}">
              <span class="rent">대여 ${p.rentPrice}원 / 1일</span><br/>
            </c:if>
            <c:if test="${p.secPrice != null}">
              <span class="deposit">보증금 ${p.secPrice}원</span>
            </c:if>
          </div>
          <div class="product-type">${p.tradeType}</div>
        </div>

        <!-- 업로드된 시간 표시 -->
        <div class="product-meta">${p.timeAgo}</div>
      </div>
    </c:forEach>
  </div>
</div>
</a>
<!-- 페이징 -->
<div id="paging">
  <c:if test="${pageInfo.curPage > 1}">
    <a href="#" data-page="${pageInfo.curPage - 1}">&lt;</a>
  </c:if>
  <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" var="i">
    <a href="#" data-page="${i}" class="${i == pageInfo.curPage ? 'select':'btn'}">${i}</a>
  </c:forEach>
  <c:if test="${pageInfo.curPage < pageInfo.allPage}">
    <a href="#" data-page="${pageInfo.curPage + 1}">&gt;</a>
  </c:if>
</div>
