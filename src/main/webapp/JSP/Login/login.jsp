<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 쿠키에서 자동 로그인 관련 정보(id, password, type)를 읽어오는 로직 --%>
<%
String type = "";
String cookieId = "";
String password = "";
String cookieHeader = request.getHeader("Cookie");

if (cookieHeader != null) {
	Cookie[] cookies = request.getCookies();
	for (Cookie cookie : cookies) {
		if (cookie.getName().equals("type")) {
			type = cookie.getValue();
		} else if (cookie.getName().equals("id")) {
			cookieId = cookie.getValue();
		} else if (cookie.getName().equals("password")) {
			password = cookie.getValue();
		}
	}
}
%>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
<%-- 외부 CSS 파일 연결 --%>
<link rel="stylesheet" href="${contextPath}/CSS/Login/login.css" />
	<meta charset="UTF-8">
	<title>로그인</title>
</head>
<body>
	<div class="login-container">
		<h1 class="title">로그인</h1>
		<p class="subtitle">로그인 및 회원가입을<br>시작합니다.</p>

		<%-- 소셜 로그인 영역 (카카오 / 네이버) --%>
		<div class="social-buttons">
			<a href="https://kauth.kakao.com/oauth/authorize?client_id=26cbd2829d45a2e79ba779ab7d6c059c&redirect_uri=http://localhost:8080/rent/kakao&response_type=code">
				<img src="${contextPath}/img/kakao_login_medium_narrow.png" alt="Kakao">
			</a>
			<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=F6Q5T61yYsZTND6Hay0F&redirect_uri=http://localhost:8080/rent/naver&state=7564">
				<img src="${contextPath}/img/btnG_naver.png" width="120px" alt="Naver">
			</a>
		</div>

		<%-- 일반 로그인 폼 토글 버튼 --%>
		<p class="switch-login" onclick="toggleForm()">일반 회원으로 이용하기 ▼</p>

		<%-- 일반 로그인 폼 (POST 방식으로 /login 서블릿에 전송) --%>
		<form action="${contextPath}/login" method="post" class="basic-form" id="basicForm" onsubmit="return validateForm()">
			<%-- 아이디/닉네임 입력 (쿠키 값 있을 시 자동 입력) --%>
			<input type="text" placeholder="아이디/닉네임" name="id" id="username" value="<%=cookieId%>" />
			<%-- 비밀번호 입력 (쿠키 값 있을 시 자동 입력) --%>
			<input type="password" placeholder="비밀번호" name="password" id="password" value="<%=password%>" />

			<%-- 자동 로그인 체크박스 (쿠키 값이 autologin이면 checked, 아니면 "") --%>
			<div class="remember">
				<input type="checkbox" name="type" value="autologin" id="remember"
				<%= "autologin".equals(type) ? "checked" : "" %> />
				<label for="remember">아이디 저장</label>
			</div>

			<%-- 회원가입 버튼 (join 서블릿으로 이동) --%>
			<button type="button" class="signup-btn" onclick="location.href='${contextPath}/join'">회원가입</button>

			<%-- 로그인 버튼 (form submit) --%>
			<button type="submit" class="login-btn">로그인</button>
		</form>
	</div>

	<%-- 자바스크립트 영역 --%>
	<script>
		// 일반 로그인 폼 표시/숨김 전환
		function toggleForm() {
			const form = document.getElementById("basicForm");
			const toggleText = document.querySelector(".switch-login");
			if (form.style.display === "flex") {
				form.style.display = "none";
				toggleText.innerText = "일반 회원으로 이용하기 ▼";
			} else {
				form.style.display = "flex";
				toggleText.innerText = "소셜 로그인으로 이용하기 ▲";
			}
		}

		// 로그인 시 아이디/비밀번호 입력 여부 확인
		function validateForm() {
			const username = document.getElementById("username").value;
			const password = document.getElementById("password").value;
			if (!username || !password) {
				alert("아이디와 비밀번호를 입력해주세요.");
				return false;
			}
			return true;
		}
	</script>
</body>
</html>
