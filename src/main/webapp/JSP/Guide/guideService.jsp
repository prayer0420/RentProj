<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/guide/guideService.css">
</head>
<body>
<jsp:include page="../Header/header.jsp"></jsp:include>
<form action="">
        <h2>고객센터/마이페이지</h2>
        <hr>
        <div class="button-list">
            <button type="button"
                onclick="document.getElementById('mypage').scrollIntoView({ behavior: 'smooth' })">마이페이지</button>
            <button type="button"
                onclick="document.getElementById('QA').scrollIntoView({ behavior: 'smooth' })">1:1문의</button>
            <button type="button"
                onclick="document.getElementById('announce').scrollIntoView({ behavior: 'smooth' })">공지사항</button>
        </div>
        <div class="container">
            <h2 id="mypage">마이페이지</h2>
            <hr>
            <div class="text">마이페이지에서 개인정보 및 상품관리,배송지 관리등을 할 수 있습니다.</div>
            <img src="" alt="">
            <h2 id="QA">1:1문의</h2>
            <hr>
            <div class="text">Re:NT를 이용하시면서 궁금하신점을 1:1문의를 통해서 물어보실 수 있습니다.</div>
            <img src="" alt="">
            <h2 id="announce">공지사항</h2>
            <hr>
            <div class="text">공지사항을 통해서 Re:NT의 새로운 소식을 전달받을 수 있습니다.</div>
            <img src="" alt="">
        </div>
    </form>
</body>
</html>