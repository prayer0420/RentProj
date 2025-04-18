<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>마이페이지</title>
  <link rel="stylesheet" href="css/header.css" />
  <link rel="stylesheet" href="css/myPage.css" />
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="mypage-container">
  <!-- 사이드바 -->
  <aside class="mypage-sidebar">
    <div class="profile">
      <img src="img/profile_tiger.png" alt="프로필" class="profile-img" />
      <div class="profile-info">
        <strong>홍길동 님</strong>
        <span class="grade">Silver 회원</span>
        <span class="summary">총 거래 수: 25회</span>
      </div>
    </div>

    <ul class="menu">
      <li><a href="#" class="menu-link" data-page="myPurchase.jsp">구매 상품</a></li>
      <li><a href="#" class="menu-link" data-page="wishList.jsp">찜한 상품</a></li>
      <li><a href="#" class="menu-link" data-page="message.jsp">쪽지함</a></li>
      <li><a href="#" class="menu-link" data-page="myReview.jsp">나의 리뷰</a></li>
      <li><a href="#" class="menu-link" data-page="reportList.jsp">나의 신고목록</a></li>
      <li><a href="#" class="menu-link" data-page="adManage.jsp">광고 관리</a></li>
      <li><a href="#" class="menu-link" data-page="myInfoEdit.jsp">개인정보 수정</a></li>
      <li><a href="#" class="menu-link" data-page="myAddress.jsp">배송지 관리</a></li>
    </ul>
  </aside>

  <!-- 콘텐츠 영역 (AJAX로 변경되는 부분) -->
  <section class="mypage-main" id="mainContent">
    <p>원하는 메뉴를 클릭하세요.</p>
  </section>
</div>

<script>
  $(document).ready(function () {
    $('.menu-link').on('click', function (e) {
      e.preventDefault();
      const page = $(this).data('page');

      $('#mainContent').load(page, function (response, status, xhr) {
        if (status == "error") {
          $('#mainContent').html("<p>페이지 로딩 중 오류가 발생했습니다.</p>");
        }
      });

      // 메뉴 active 표시
      $('.menu-link').parent().removeClass('active');
      $(this).parent().addClass('active');
    });
  });
</script>
</body>
</html>
