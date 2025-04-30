<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
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

<div class="sidebar">
  <div class="profile-section" id="member">
    <c:choose>
      <c:when test="${sessionScope.id eq null}">
        <a href="${contextPath}/login">로그인</a>
      </c:when>
      <c:otherwise>
        <img src="${contextPath}/img/tiger.png" alt="사용자 이미지" />
        <div class="user-id"><span><b>${sessionScope.id}</b></span>&nbsp;<span>님</span></div>
        <div class="membership"><span>${session.gradeName}</span>&nbsp;<span>회원</span></div>
        <div class="total-count">총 거래 수: ${session.orderCount}회</div>
      </c:otherwise>
    </c:choose>
  </div>

  <div class="divider"></div>

  <!-- 구매 상품 메뉴 (hover 확장 + 클릭시 이동) -->
  <div class="menu-item hover-expand">
    <div class="menu-title" onclick="location.href='myOrder';">
      구매 상품
    </div>
    <div class="submenu">
      <div class="submenu-item"><a href="myOrder">> 구매한 상품</a></div>
      <div class="submenu-item"><a href="myRent">> 빌린 상품</a></div>
    </div>
  </div>

  <!-- 판매 상품 메뉴 (hover 확장만 적용) -->
  <div class="menu-item hover-expand">
    <div class="menu-title">판매 상품</div>
    <div class="submenu">
      <div class="submenu-item"><a href="mySell">> 판매 상품</a></div>
      <div class="submenu-item"><a href="myLend">> 대여 상품</a></div>
    </div>
  </div>

  <!-- 단일 메뉴 -->
  <div class="simple-item"><a href="myMarkList">찜한 상품</a></div>
  <div class="simple-item"><a href="myNoteList">쪽지함</a></div>
  <div class="simple-item"><a href="myReviewList">나의 리뷰</a></div>
  <div class="simple-item"><a href="myReportList">나의 신고목록</a></div>
  <div class="simple-item"><a href="myAdAdmin">광고 관리</a></div>

  <div class="divider"></div>

  <div class="simple-item"><a href="${contextPath}/myInfoModify">개인정보 수정</a></div>
  <div class="simple-item"><a href="${contextPath}/myAddress">배송지 관리</a></div>
</div>

<script>
  // 기존 클릭 토글용 JS (hover 확장 메뉴 외 메뉴 대응)
  $(function () {
    $('.menu-title').on('click', function () {
      const $submenu = $(this).next('.submenu');
      if ($submenu.is(':visible')) {
        $submenu.slideUp(200);
        $(this).parent().removeClass('active');
      } else {
        $('.submenu:visible').slideUp(200);
        $('.menu-item').removeClass('active');
        $submenu.slideDown(200);
        $(this).parent().addClass('active');
      }
    });
  });
</script>
</body>
</html>
