<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
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

    <!-- 사이드바 -->
    <jsp:include page="/JSP/MyPage/mypageSidebar.jsp" />

    <!-- 메인 콘텐츠 -->
    <section class="content">
      <h2 class="title">나의 리뷰</h2>
      <div class="divider"></div>

      <div class="review-tabs">
        <button class="tab-button active" data-tab="tab1">리뷰할 상품</button>
        <button class="tab-button" data-tab="tab2">작성한 리뷰</button>
        <button class="tab-button" data-tab="tab3">내 상품 리뷰</button>
      </div>

      <div class="tab-content-container">

        <!-- 리뷰할 상품 -->
        <div id="tab1" class="tab-content active">
          <c:choose>
            <c:when test="${empty writableList}">
              <p class="empty-text">리뷰할 상품이 없습니다.</p>
            </c:when>
            <c:otherwise>
              <div class="review-grid">
                <c:forEach var="order" items="${writableList}">
                  <div class="review-card" onclick="location.href='${contextPath}/productDetail?no=${order.productNo}'">
                    <img src="${order.img}" alt="상품 이미지" class="product-img" />
                    <div class="product-info">
                      <h3 class="product-title">${order.title}</h3>
                      <p class="order-date">
                        주문일: 
                        <fmt:formatDate value="${order.orderDate}" pattern="yy년 MM월 dd일 HH:mm" />
                      </p>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- 내가 작성한 리뷰 -->
        <div id="tab2" class="tab-content">
          <c:choose>
            <c:when test="${empty myReviewList}">
              <p class="empty-text">작성한 리뷰가 없습니다.</p>
            </c:when>
            <c:otherwise>
              <div class="review-grid">
                <c:forEach var="review" items="${myReviewList}">
                  <div class="review-card" onclick="location.href='${contextPath}/productDetail?no=${review.productNo}'">
                    <img src="${review.img}" alt="상품 이미지" class="product-img" />
                    <div class="product-info">
                      <h3 class="product-title">${review.title}</h3>
                      <p class="order-date">
                        작성일: 
                        <fmt:formatDate value="${review.date}" pattern="yy년 MM월 dd일 HH:mm" />
                      </p>
                      <p class="review-contents">내용: ${review.contents}</p>
                      <p class="review-score">⭐ ${review.score}점</p>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- 내 상품 리뷰 -->
        <div id="tab3" class="tab-content">
          <c:choose>
            <c:when test="${empty myProductReviewList}">
              <p class="empty-text">내 상품에 작성된 리뷰가 없습니다.</p>
            </c:when>
            <c:otherwise>
              <div class="review-grid">
                <c:forEach var="review" items="${myProductReviewList}">
                  <div class="review-card" onclick="location.href='${contextPath}/productDetail?no=${review.productNo}'">
                    <img src="${review.img}" alt="상품 이미지" class="product-img" />
                    <div class="product-info">
                      <h3 class="product-title">${review.title}</h3>
                      <p class="order-date">
                        작성일: 
                        <fmt:formatDate value="${review.date}" pattern="yy년 MM월 dd일 HH:mm" />
                      </p>
                      <p class="review-contents">내용: ${review.contents}</p>
                      <p class="review-score">⭐ ${review.score}점</p>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </c:otherwise>
          </c:choose>
        </div>

      </div>

    </section>
  </div>
</div>

<jsp:include page="/JSP/Header/footer.jsp" />

<script>
$(function() {
  $(".tab-button").click(function() {
    const target = $(this).data("tab");
    $(".tab-button").removeClass("active");
    $(this).addClass("active");

    $(".tab-content").removeClass("active");
    $("#" + target).addClass("active");
  });
});
</script>

</body>
</html>
