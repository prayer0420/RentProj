<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>나의 리뷰</title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/myReviewList.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<jsp:include page="/JSP/Header/header.jsp" />

<div class="wrapper">
  <div class="container">

    <jsp:include page="/JSP/MyPage/mypageSidebar.jsp" />

    <section class="content">
      <h2 class="title">나의 리뷰</h2>
      <div class="divider"></div>

      <div class="review-tabs">
        <button class="tab-button ${type == 'writable' ? 'active' : ''}" onclick="location.href='${contextPath}/myReviewList?type=writable'">리뷰할 상품</button>
        <button class="tab-button ${type == 'written' ? 'active' : ''}" onclick="location.href='${contextPath}/myReviewList?type=written'">작성한 리뷰</button>
        <button class="tab-button ${type == 'myproduct' ? 'active' : ''}" onclick="location.href='${contextPath}/myReviewList?type=myproduct'">내 상품 리뷰</button>
      </div>

      <div class="tab-content-container">

        <c:choose>
          <c:when test="${empty list}">
            <p class="empty-text">
              <c:choose>
                <c:when test="${type == 'writable'}">리뷰할 상품이 없습니다.</c:when>
                <c:when test="${type == 'written'}">작성한 리뷰가 없습니다.</c:when>
                <c:when test="${type == 'myproduct'}">내 상품에 작성된 리뷰가 없습니다.</c:when>
              </c:choose>
            </p>
          </c:when>
          <c:otherwise>
            <div class="review-grid">
              <c:forEach var="item" items="${list}">
                <div class="review-card" onclick="location.href='${contextPath}/productDetail?no=${item.productNo}'">
                  <img src="${item.img}" alt="상품 이미지" class="product-img" />
                  <div class="product-info">
                    <h3 class="product-title">${item.title}</h3>

                    <c:choose>
                      <c:when test="${type == 'writable'}">
                        <p class="order-date">
                          주문일: 
                          <fmt:formatDate value="${item.orderDate}" pattern="yy년 MM월 dd일 HH:mm" />
                        </p>
                      </c:when>
                      <c:otherwise>
                        <p class="order-date">
                          작성일: 
                          <fmt:formatDate value="${item.date}" pattern="yy년 MM월 dd일 HH:mm" />
                        </p>
                        <p class="review-contents">내용: ${item.contents}</p>
                        <p class="review-score">⭐ ${item.score}점</p>
                      </c:otherwise>
                    </c:choose>

                  </div>
                </div>
              </c:forEach>
            </div>
          </c:otherwise>
        </c:choose>

      </div>

      <!-- 페이징 -->
      <div class="paging">
        <c:if test="${pageInfo.curPage > 1}">
          <a class="page-btn" href="${contextPath}/myReviewList?type=${type}&page=${pageInfo.curPage - 1}">&lt;</a>
        </c:if>

        <c:forEach var="page" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
          <c:choose>
            <c:when test="${page == pageInfo.curPage}">
              <a class="page-btn active" href="${contextPath}/myReviewList?type=${type}&page=${page}">${page}</a>
            </c:when>
            <c:otherwise>
              <a class="page-btn" href="${contextPath}/myReviewList?type=${type}&page=${page}">${page}</a>
            </c:otherwise>
          </c:choose>
        </c:forEach>

        <c:if test="${pageInfo.curPage < pageInfo.allPage}">
          <a class="page-btn" href="${contextPath}/myReviewList?type=${type}&page=${pageInfo.curPage + 1}">&gt;</a>
        </c:if>
      </div>

    </section>
  </div>
</div>

<jsp:include page="/JSP/Header/footer.jsp" />

</body>
</html>
