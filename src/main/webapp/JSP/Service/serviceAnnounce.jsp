<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" href="${contextPath}/CSS/service/serviceAnnounce.css">
</head>
<body>
<jsp:include page="../Header/header.jsp" />

<div class="container">
    <h2>공지사항</h2>
    <hr>
    <div class="notice-box">
        <div class="title">[공지] ${announce.title}</div>
        <div class="meta">조회수 ${announce.viewCount} | 등록일 ${announce.regDate}</div>
    </div>
        <div>${announce.content}</div>

    <div class="btn-wrap">
        <button type="button" class="back-btn" onclick="location.href='${contextPath}/service';">목록</button>
    </div>
</div>

</body>
</html>
