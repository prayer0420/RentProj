<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!--l-->
<%
String type = "";
String cookieId = "";
String password = "";
String cookieHeader = request.getHeader("Cookie");

if (cookieHeader != null) {
	Cookie[] cookies = request.getCookies();
	for (Cookie cookie : cookies) {
		System.out.println(cookie.getName());
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

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="login-container">
		<h1 class="title">로그인</h1>
		<p class="subtitle">
			로그인 및 회원가입을<br>시작합니다.
		</p>

		<div class="social-buttons">
			<button class="social-btn kakao">
				<img src="https://cdn-icons-png.flaticon.com/512/2111/2111615.png"
					alt="Kakao"> 카카오로 로그인하기
			</button>
			<button class="social-btn naver">
				<img
					src="https://upload.wikimedia.org/wikipedia/commons/2/2e/Naver_Logotype.svg"
					alt="Naver"> 네이버로 로그인하기
			</button>
		</div>

		<p class="switch-login" onclick="toggleForm()">일반 회원으로 이용하기 ▼</p>

		<div class="basic-form" id="basicForm">
			<input type="text" placeholder="아이디/닉네임" id="username"> <input
				type="password" placeholder="비밀번호" id="password">

			<div class="remember">
				<input type="checkbox" id="remember"> <label for="remember">아이디저장</label>
			</div>

			<button class="signup-btn">
				<a href="join.jsp"> 회원가입 </a>
			</button>
			<button class="login-btn" onclick="login()">로그인</button>
		</div>
	</div>

	<script>
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

		function login() {
			const username = document.getElementById("username").value;
			const password = document.getElementById("password").value;
			if (!username || !password) {
				alert("아이디와 비밀번호를 입력해주세요.");
				return;
			}
			// 실제 로그인 처리 로직은 서버와 연결 필요
			alert(`환영합니다, ${username}님!`);
		}
	</script>
</body>
</html>