<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RE:NT 메인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Main/main.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<jsp:include page="../Header/header1.jsp"/>
<jsp:include page="../Header/header2.jsp"/>

<!-- 🔹 위치 정보 없을 때 자동 요청 -->
<script>
document.addEventListener("DOMContentLoaded", function() {
  const lat = "${member.latitude}";
  const lng = "${member.longitude}";
  function success(pos) {
    $.ajax({
      type: "POST",
      url: "${pageContext.request.contextPath}/updateLocation",
      data: {
        lat: pos.coords.latitude,
        lng: pos.coords.longitude
      },
      success: function(res) {
        alert("위치가 저장되었습니다: " + res.address);
        location.reload();
      },
      error: function() {
        alert("위치 저장에 실패했어요.");
      }
    });
  }

  function error(err) {
    alert("위치 정보를 불러올 수 없어요.");
    console.error(err);
  }
});
</script>

<!-- 🔸 배너 영역 -->
<section class="banner">
  <div class="banner-container">
    <h2>RE:NT에서 렌트하세요!</h2>
    <a href="../Service/service.jsp"><button>이용가이드 &gt;</button></a>
  </div>
  <div class="banner-img">
    <img src="${pageContext.request.contextPath}/img/rent.jpg" alt="이벤트 이미지">
  </div>
</section>

<!-- 🔸 추천 상품 -->
<section>
  <div class="section-title">오늘의 인기 상품이에요!</div>
  <div class="product-grid">
    <c:forEach var="p" items="${popularList}">
      <div class="product-card">
        <img src="${p.img}" alt="">
        <div class="product-name">${p.title}</div>
        <div class="product-price">
          <c:if test="${not empty p.salePrice}">
            <span class="sale">판매가 ${p.salePrice}원</span><br/>
          </c:if>
          <c:if test="${not empty p.rentPrice}">
            <span class="rent">대여 ${p.rentPrice}원</span><br/>
          </c:if>
        </div>
        <div class="product-type ${p.tradeType}">${p.tradeType}</div>
      </div>
    </c:forEach>
  </div>
</section>

<!-- 🔸 내 동네 상품 -->
<section>
  <div class="section-title">내 동네에서 이런 것도 빌릴 수 있어요!</div>
  <div class="product-grid">
    <c:forEach var="p" items="${localList}">
      <div class="product-card">
        <img src="${p.img}" alt="">
        <div class="product-name">${p.title}</div>
        <div class="product-price">
          <c:if test="${not empty p.salePrice}">
            <span class="sale">판매가 ${p.salePrice}원</span><br/>
          </c:if>
          <c:if test="${not empty p.rentPrice}">
            <span class="rent">대여 ${p.rentPrice}원</span><br/>
          </c:if>
        </div>
        <div class="product-type ${p.tradeType}">${p.tradeType}</div>
      </div>
    </c:forEach>
  </div>
</section>

<jsp:include page="../Header/footer.jsp"/>

</body>
</html>
