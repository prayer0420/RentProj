<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page Side-Bar</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypageSidebar.css">
</head>
<body>

	<!-- 사이드바 -->
	<div class="sidebar">
          <!-- 사용자 프로필 -->
          <div class="profile-section">
            <img src="${contextPath }/img/tiger.png" alt="사용자 이미지" />
            <div class="user-id">홍길동 님</div>
            <div class="membership">Silver 회원</div>
            <div class="total-count">총 거래 수: 25회</div>
          </div>

          <div class="divider"></div>

          <!-- 아코디언 메뉴: 구매상품 -->
          <div class="menu-item">
            <div class="menu-title" onclick="toggleSubmenu(this)">
              구매 상품
            </div>
            <div class="submenu">
              <div class="submenu-item">> 구매한 상품</div>
              <div class="submenu-item">> 대여한 상품</div>
            </div>
          </div>

          <!-- 아코디언 메뉴: 판매상품 -->
          <div class="menu-item">
            <div class="menu-title" onclick="toggleSubmenu(this)">
              판매 상품
            </div>
            <div class="submenu">
              <div class="submenu-item">> 판매 상품</div>
              <div class="submenu-item">> 대여 상품</div>
            </div>
          </div>

          <!-- 일반 메뉴 항목 -->
          <div class="simple-item">찜한 상품</div>
          <div class="simple-item">쪽지함</div>
          <div class="simple-item">나의 리뷰</div>
          <div class="simple-item">나의 신고목록</div>
          <div class="simple-item">광고 관리</div>

          <div class="divider"></div>

          <div class="simple-item">개인정보 수정</div>
          <div class="simple-item">배송지 관리</div>
        </div>

</body>
<script>
function toggleSubmenu(clickedTitle) {
    const menuItem = clickedTitle.parentElement;

    if (menuItem.classList.contains("active")) {
      menuItem.classList.remove("active");
    } else {
      document
        .querySelectorAll(".menu-item")
        .forEach((item) => item.classList.remove("active"));
      menuItem.classList.add("active");
    }
  }
</script>
</html>