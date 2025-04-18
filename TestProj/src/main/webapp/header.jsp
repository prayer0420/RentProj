<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>카테고리 페이지</title>
    <link rel="stylesheet" href="css/header.css" />
</head>
<body>

<jsp:include page="alarm.jsp" />

    <header class="top-nav">
        <div class="left-header">
            <div class="logo">RE:NT</div>
            <a href="" class="product-add">상품 등록</a>
        </div>
        <div class="search-box">
            <input type="text" placeholder="검색어를 입력해주세요" />
        </div>
        <div class="header-actions">
            <button>📍 위치</button>
            <button onclick="openAlarmModal()" class="alarm-bell">🔔 알림</button>
            <button>📄 마이페이지</button>
            <span style="display: none;">닉네임</span>
            <span style="display: none;">로그아웃</span>
        </div>
    </header>

    <section class="categories">
        <div class="category-item">
            <img src="https://cdn-icons-png.flaticon.com/512/1046/1046857.png" alt="즉시">
            <span>의류/패션/악세사리</span>
        </div>
        <div class="category-item">
            <img src="https://cdn-icons-png.flaticon.com/512/2920/2920061.png" alt="PC">
            <span>PC/모바일</span>
        </div>
        <div class="category-item">
            <img src="https://cdn-icons-png.flaticon.com/512/149/149852.png" alt="가전">
            <span>가전 제품</span>
        </div>
        <div class="category-item">
            <img src="https://cdn-icons-png.flaticon.com/512/2329/2329181.png" alt="레저">
            <span>뷰티/미용</span>
        </div>
        <div class="category-item">
            <img src="https://cdn-icons-png.flaticon.com/512/2329/2329181.png" alt="레저">
            <span>캠핑/스포츠/레저</span>
        </div>
        <div class="category-item">
            <img src="https://cdn-icons-png.flaticon.com/512/1198/1198294.png" alt="운송">
            <span>생활/주방용품</span>
        </div>
        <div class="category-item">
            <img src="https://cdn-icons-png.flaticon.com/512/3703/3703277.png" alt="운동">
            <span>가구인테리어</span>
        </div>
        <div class="category-item">
            <img src="https://cdn-icons-png.flaticon.com/512/929/929426.png" alt="육아">
            <span>유아동/출산</span>
        </div>
        <div class="category-item">
            <img src="https://cdn-icons-png.flaticon.com/512/3616/3616983.png" alt="의류">
            <span>애완동물용품</span>
        </div>
        <div class="category-item">
            <img src="https://cdn-icons-png.flaticon.com/512/3616/3616983.png" alt="의류">
            <span>기타</span>
        </div>
    </section>
    

    <script>
    function openAlarmModal() {
        document.getElementById("alarmModal").style.display = "flex";
      }
      function closeAlarmModal() {
        document.getElementById("alarmModal").style.display = "none";
      }
    </script>
    

</body>
</html>
