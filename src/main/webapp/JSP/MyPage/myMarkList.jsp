<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찜한 상품</title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/myMarkList.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<!-- 헤더 -->
<jsp:include page="/JSP/Header/header.jsp" />

<div class="wrapper">
  <div class="container">
  
    <!-- 사이드바 -->
    <jsp:include page="/JSP/MyPage/mypageSidebar.jsp" />

    <!-- 메인 콘텐츠 -->
    <section class="content">
      <h2 class="title">찜한 상품</h2>
      <div class="divider"></div>

      <div class="action-bar">
        <div class="left-action">
          <label><input type="checkbox" id="checkAll"> 전체 선택</label>
        </div>
        <div class="right-action">
          <button type="submit" form="deleteForm" class="delete-selected-btn">선택 삭제</button>
        </div>
      </div>

      <form id="deleteForm" action="${contextPath}/myMarkList" method="post">
        <c:choose>
          <c:when test="${empty marklist}">
            <p class="empty-text">찜한 상품이 없습니다.</p>
          </c:when>
          <c:otherwise>
            <div class="marklist-grid">
              <c:forEach var="item" items="${marklist}">
                <div class="marklist-card" onclick="location.href='${contextPath}/productDetail?no=${item.productNo}'">
                  <input type="checkbox" class="check-item" name="marklistIds" value="${item.productNo}" onclick="event.stopPropagation();">
                  <a href="${contextPath}/productDetail?no=${item.productNo}" class="product-img">
                    <img src="${item.productImage}" alt="상품 이미지">
                  </a>

                  <div class="product-info">
                    <p class="product-no">상품번호: ${item.productNo}</p>
                    <h3 class="product-title">${item.productTitle}</h3>
                    
                    <c:if test="${item.salePrice != null}">
                      <p class="product-price sale">판매가: <fmt:formatNumber value="${item.salePrice}" type="number"/>원</p>
                    </c:if>
                  
                    <c:if test="${item.rentPrice != null}">
                      <p class="product-price rent">대여가: <fmt:formatNumber value="${item.rentPrice}" type="number"/>원</p>
                    </c:if>
                  
                    <c:if test="${item.secPrice != null}">
                      <p class="product-price deposit">보증금: <fmt:formatNumber value="${item.secPrice}" type="number"/>원</p>
                    </c:if>
                  
                    <p class="product-location">${item.productLocation}</p>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:otherwise>
        </c:choose>
      </form>

      <!-- 페이징 -->
      <div class="paging">
        <c:if test="${pageInfo.curPage > 1}">
          <a class="page-btn" href="${contextPath}/myMarkList?page=${pageInfo.curPage - 1}">&lt;</a>
        </c:if>

        <c:forEach var="page" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
          <c:choose>
            <c:when test="${page == pageInfo.curPage}">
              <a class="page-btn active" href="${contextPath}/myMarkList?page=${page}">${page}</a>
            </c:when>
            <c:otherwise>
              <a class="page-btn" href="${contextPath}/myMarkList?page=${page}">${page}</a>
            </c:otherwise>
          </c:choose>
        </c:forEach>

        <c:if test="${pageInfo.curPage < pageInfo.allPage}">
          <a class="page-btn" href="${contextPath}/myMarkList?page=${pageInfo.curPage + 1}">&gt;</a>
        </c:if>
      </div>

    </section>
  </div>
</div>

<!-- 푸터 -->
<jsp:include page="/JSP/Header/footer.jsp" />

<script>
$(function() {
  $("#checkAll").on("change", function () {
    $(".check-item").prop("checked", $(this).prop("checked"));
  });

  $("#deleteForm").submit(function (e) {
    if ($(".check-item:checked").length == 0) {
      alert("삭제할 상품을 선택하세요.");
      e.preventDefault();
    } else if (!confirm("선택한 상품을 삭제하시겠습니까?")) {
      e.preventDefault();
    }
  });
});
</script>

</body>
</html>
