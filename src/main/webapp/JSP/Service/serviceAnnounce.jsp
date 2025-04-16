<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/service/serviceAnnounce.css">
</head>
<body>
<jsp:include page="../Header/header.jsp"></jsp:include>
 <form action="">
        <div class="container">
            <h2>공지사항</h2>
            <hr>
            <div class="notice-box">
                <div class="title">[공지] 상품등록하고 커피쿠폰 받고~</div>
                <div class="meta">조회수 1,000 | 등록일 2025.04.01</div>
            </div>

            <div class="notice-image">
                <img src="<%= request.getContextPath() %>/img/coffee.jpg" alt="이벤트 이미지">
            </div>

            <div class="btn-wrap">
                <button type="button" class="back-btn"><a href="../service/service.jsp">목록</a></button>
            </div>
        </div>
    </form>
</body>
</html>