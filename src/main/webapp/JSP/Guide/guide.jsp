<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/guide/guide.css">
</head>
<body>
<jsp:include page="../Header/header.jsp"></jsp:include>
<form action="">
        <h2>이용 가이드</h2>
        <hr>
        <div class="guide-sub">
            도움항목을 선택하세요<br>
            <strong style="color: #999;">Re:NT 이용 가이드입니다.</strong>
        </div>

        <div class="guide-container">
            <a href="guideWrite.jsp" class="guide-card">
                <img src="https://cdn-icons-png.flaticon.com/512/1828/1828919.png" alt="글쓰기">
                글쓰기
            </a>
            <a href="guideService.jsp" class="guide-card">
                <img src="https://cdn-icons-png.flaticon.com/512/847/847969.png" alt="마이페이지">
                고객센터/마이페이지
            </a>
            <a href="guideManage.jsp" class="guide-card">
                <img src="https://cdn-icons-png.flaticon.com/512/1077/1077035.png" alt="구매관리">
                구매/대여 관리
            </a>
        </div>
    </form>
</body>
</html>