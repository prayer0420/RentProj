<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%-- <% String id = (String)session.getAttribute("id"); %> --%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page Side-Bar</title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/mypageSidebar.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

	<!-- 사이드바 -->
	<div class="sidebar">
          <!-- 사용자 프로필 -->
          <div class="profile-section" id="member">
	          <c:choose>
  				<c:when test="${sessionScope.id eq null}">
					<a href="${contextPath}/login">로그인</a>
	          	</c:when>
	          	<c:otherwise>
	          		<img src="${contextPath }/img/tiger.png" alt="사용자 이미지" />
		            <div class="user-id"><span><b>${sessionScope.id}</b></span>&nbsp;<span>님</span></div>
		            <div class="membership"><span>${grade.gradeName}</span>&nbsp;<span>회원</span></div>
		            <div class="total-count">총 거래 수: ${member.orderCount}회</div>
	          	</c:otherwise>
	          </c:choose>
            
          </div>

          <div class="divider"></div>

          <!-- 아코디언 메뉴: 구매상품 -->
          <div class="menu-item">
            <div class="menu-title" onclick="toggleSubmenu(this)">
              구매 상품
            </div>
            <div class="submenu">
              <div class="submenu-item"><a href="myOrder">> 구매한 상품</a></div>
              <div class="submenu-item"><a href="myRent">> 빌린 상품</a></div>
            </div>
          </div>

          <!-- 아코디언 메뉴: 판매상품 -->
          <div class="menu-item">
            <div class="menu-title" onclick="toggleSubmenu(this)">
              판매 상품
            </div>
            <div class="submenu">
              <div class="submenu-item"><a href="mySell">> 판매 상품</a></div>
              <div class="submenu-item"><a href="myLend">> 대여 상품</a></div>
            </div>
          </div>

          <!-- 일반 메뉴 항목 -->
          <div class="simple-item"><a href="myMarkList">찜한 상품</a></div>
          <div class="simple-item"><a href="noteList">쪽지함</a></div>
          <div class="simple-item"><a href="myReview">나의 리뷰</a></div>
          <div class="simple-item"><a href="myReport">나의 신고목록</a></div>
          <div class="simple-item"><a href="myAdAdmin">광고 관리</a></div>

          <div class="divider"></div>

          <div class="simple-item"><a href="${contextPath}/myInfoModify">개인정보 수정</a></div>
          <div class="simple-item"><a href="${contextPath}/myAddress">배송지 관리</a></div>
          
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