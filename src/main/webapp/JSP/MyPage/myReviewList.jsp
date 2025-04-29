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

    <!-- 사이드바 -->
    <jsp:include page="/JSP/MyPage/mypageSidebar.jsp" />

    <!-- 메인 콘텐츠 -->
    <section class="content">
      <h2 class="title">나의 리뷰</h2>
      <div class="divider"></div>

      <!-- 탭 메뉴 -->
      <div class="review-tabs">
        <button class="tab-button active" data-tab="tab1">리뷰할 상품</button>
        <button class="tab-button" data-tab="tab2">작성한 리뷰</button>
        <button class="tab-button" data-tab="tab3">내 상품 리뷰</button>
      </div>

      <div class="tab-content-container">

        <!-- 탭 1: 리뷰할 상품 -->
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
                        <fmt:formatDate value="${order.date}" pattern="yy년 MM월 dd일 HH:mm" />
                      </p>
                    </div>
                  </div>
                </c:forEach>
              </div>

              <!-- writable 페이징 -->
              <div class="paging">
                <c:if test="${writablePageInfo.curPage > 1}">
                  <a class="page-btn" href="${contextPath}/myReviewList?writablePage=${writablePageInfo.curPage - 1}">&lt;</a>
                </c:if>
                <c:forEach var="page" begin="${writablePageInfo.startPage}" end="${writablePageInfo.endPage}">
                  <a class="page-btn ${page == writablePageInfo.curPage ? 'active' : ''}" href="${contextPath}/myReviewList?writablePage=${page}">${page}</a>
                </c:forEach>
                <c:if test="${writablePageInfo.curPage < writablePageInfo.allPage}">
                  <a class="page-btn" href="${contextPath}/myReviewList?writablePage=${writablePageInfo.curPage + 1}">&gt;</a>
                </c:if>
              </div>

            </c:otherwise>
          </c:choose>
        </div>

        <!-- 탭 2: 내가 작성한 리뷰 -->
        <div id="tab2" class="tab-content">
          <c:choose>
            <c:when test="${empty writtenList}">
              <p class="empty-text">작성한 리뷰가 없습니다.</p>
            </c:when>
            <c:otherwise>
              <div class="review-grid">
                <c:forEach var="review" items="${writtenList}">
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

              <!-- written 페이징 -->
              <div class="paging">
                <c:if test="${writtenPageInfo.curPage > 1}">
                  <a class="page-btn" href="${contextPath}/myReviewList?writtenPage=${writtenPageInfo.curPage - 1}">&lt;</a>
                </c:if>
                <c:forEach var="page" begin="${writtenPageInfo.startPage}" end="${writtenPageInfo.endPage}">
                  <a class="page-btn ${page == writtenPageInfo.curPage ? 'active' : ''}" href="${contextPath}/myReviewList?writtenPage=${page}">${page}</a>
                </c:forEach>
                <c:if test="${writtenPageInfo.curPage < writtenPageInfo.allPage}">
                  <a class="page-btn" href="${contextPath}/myReviewList?writtenPage=${writtenPageInfo.curPage + 1}">&gt;</a>
                </c:if>
              </div>

            </c:otherwise>
          </c:choose>
        </div>

        <!-- 탭 3: 내 상품 리뷰 -->
        <div id="tab3" class="tab-content">
          <c:choose>
            <c:when test="${empty myProductList}">
              <p class="empty-text">내 상품에 작성된 리뷰가 없습니다.</p>
            </c:when>
            <c:otherwise>
              <div class="review-grid">
                <c:forEach var="review" items="${myProductList}">
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

              <!-- myProduct 페이징 -->
              <div class="paging">
                <c:if test="${myProductPageInfo.curPage > 1}">
                  <a class="page-btn" href="${contextPath}/myReviewList?myProductPage=${myProductPageInfo.curPage - 1}">&lt;</a>
                </c:if>
                <c:forEach var="page" begin="${myProductPageInfo.startPage}" end="${myProductPageInfo.endPage}">
                  <a class="page-btn ${page == myProductPageInfo.curPage ? 'active' : ''}" href="${contextPath}/myReviewList?myProductPage=${page}">${page}</a>
                </c:forEach>
                <c:if test="${myProductPageInfo.curPage < myProductPageInfo.allPage}">
                  <a class="page-btn" href="${contextPath}/myReviewList?myProductPage=${myProductPageInfo.curPage + 1}">&gt;</a>
                </c:if>
              </div>

            </c:otherwise>
          </c:choose>
        </div>

      </div> <!-- tab-content-container 끝 -->

    </section>
  </div>
</div>

<jsp:include page="/JSP/Header/footer.jsp" />

<!-- 탭 전환 스크립트 -->
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
