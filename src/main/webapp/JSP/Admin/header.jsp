<%@ page contentType="text/html; charset=UTF-8" %>
<header>
  <div class="logo-nav">
    <!-- 로고 버튼 (로고 크기 조정) -->
    <button class="logo-btn" title="로고" onclick="location.href='${pageContext.request.contextPath}/main'">
      <img src="${pageContext.request.contextPath}/JSP/Admin/image/logo.png" alt="RE:NT Logo">
      
    </button>
    <nav>
      <div><a href="memberInfo">회원관리</a></div>
      <div><a href="categoryCreate">카테고리관리</a></div>
      <div><a href="reportedProductList">상품관리</a></div>
      <div><a href="orderList">정산관리</a></div>
      <div><a href="faqCategory">고객지원</a></div>
      <div><a href="alarmMessage">알림관리</a></div>
    </nav>
  </div>
  
  <!-- 프로필 버튼 -->
  <div class="profile-container">
    <button class="profile-btn" title="프로필" onclick="toggleProfileDropdown()">
      <i class="fas fa-user-circle"></i> <!-- FontAwesome 아이콘 -->
    </button>
    
    <!-- 드롭다운 메뉴 -->
    <div class="dropdown">
      <a href="adminInfo">내정보관리</a>
      <a href="logout">로그아웃</a>
    </div>
  </div>
</header>

<!-- 스타일 추가 -->
<style>
  header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 14px 30px;
    border-bottom: 1px solid #ccc;
    background: white;
  }

  .logo-nav {
    display: flex;
    align-items: center;
    gap: 40px;
  }

  .logo-btn {
    background: none;
    border: none;
    padding: 0;
    cursor: pointer;
    display: flex;
    align-items: center;
  }

  .logo-btn img {
    height: 55px; /* 로고 크기 확대 */
    max-height: 60px;
  }

  nav {
    display: flex;
    gap: 40px;
    font-weight: bold;
    font-size: 15px;
  }
  
  nav a {
  color: black;
  text-decoration: none; /* 밑줄 제거 */
}

  .profile-container {
    position: relative;
  }

  .profile-btn {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    border: none;
    cursor: pointer;
    padding: 0;
    overflow: hidden;
    background: none;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px; /* 아이콘 크기 조정 */
  }

  /* FontAwesome 아이콘 크기 */
  .profile-btn i {
    font-size: 24px;
    color: #333; /* 아이콘 색상 */
  }

  /* 드롭다운 메뉴 스타일 */
  .dropdown {
    display: none;
    position: absolute;
    right: 0;
    top: 40px;
    background-color: #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    width: 150px;
    padding: 10px 0;
    border-radius: 4px;
  }

  .dropdown a {
    display: block;
    padding: 8px 20px;
    color: #333;
    text-decoration: none;
  }

  .dropdown a:hover {
    background-color: #f4f4f4;
  }

</style>

<!-- 자바스크립트 추가 -->
<script>
  // 프로필 버튼 클릭 시 드롭다운 토글
  function toggleProfileDropdown() {
    const dropdown = document.querySelector('.dropdown');
    dropdown.style.display = (dropdown.style.display === 'block') ? 'none' : 'block';
  }
</script>

<!-- FontAwesome CDN 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
