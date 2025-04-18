<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>관리자 정보 확인</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/common.css">
  <style>

    .user-info-table {
      width: 40%;  
      margin-bottom: 30px;
      border-collapse: collapse;
    }

    .user-info-table th, .user-info-table td {
      padding: 10px;
      border: 1px solid #ccc;
      text-align: left;
    }

    .user-info-table th {
      background-color: #f0f0f0;
      font-weight: bold;
    }

    .save-button {

    display: flex; 
  	justify-content: flex-start; /* 왼쪽 정렬 */
    margin-top: 20px;
    }

    .save-button button {
      background-color: #26c6da;
      color: white;
      padding: 8px 20px;
      border: none;
      border-radius: 3px;
      cursor: pointer;
      font-size: 14px;
    }
  </style>
</head>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script> 
<script>
	$("#updateAdmin").click(function() {
	$.ajax({
		url:"adminInfo",
		method:"post",
		data:{
			name:$("# ").val()},
		}
</script>

<body>
	<%@ include file="header.jsp" %>
<div class="container">
  <aside>
    <h3>관리자정보</h3>
    <div class="menu active">관리자 정보 확인</div>
  </aside>

  <main>
    <div class="breadcrumb">HOME > 관리정보 > 관리자 정보 확인</div>

    <table class="user-info-table" border="1">
    <tr><th>아이디</th><td>${admin.id}</td></tr>
    <tr><th>비밀번호</th><td>${admin.password}</td></tr>
    <tr><th>이름</th><td>${admin.name}</td></tr>
    <tr><th>닉네임</th><td>${admin.nickname}</td></tr>

  </table>

    <div class="save-button">
      <button id="updateAdmin">저장</button>
    </div>
  </main>
</div>

</body>
</html>