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

    .admin-info-table {
      width: 40%;  
      margin-bottom: 30px;
      border-collapse: collapse;
    }

    .admin-info-table th, .admin-info-table td {
      padding: 10px;
      border: 1px solid #ccc;
      text-align: left;
    }

    .admin-info-table th {
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
$(document).ready(function () {
	  $("#updateAdmin").click(function () {
	    $.ajax({
	      url: "adminInfo",
	      method: "post",
	      data: {
	        id: $("#adminId").val(),
	        password: $("#adminPassword").val(),
	        name: $("#adminName").val(),
	        nickname: $("#adminNickname").val()
	      },
	      success: function (response) {
	          alert(response);  // 서버에서 보낸 메시지 출력
	        },
	        error: function (xhr) {
	          alert(xhr.responseText);  // 서버 에러 메시지 출력
	        }
	    });
	  });
	});
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

	<form id="adminForm">
	  <table class="admin-info-table">
	    <tr>
	      <th>아이디</th>
	      <td><input type="text" id="adminId" name="id" value="${admin.id}" readonly /></td>
	    </tr>
	    <tr>
	      <th>비밀번호</th>
	      <td><input type="password" id="adminPassword" name="password" value="${admin.password}" /></td>
	    </tr>
	    <tr>
	      <th>이름</th>
	      <td><input type="text" id="adminName" name="name" value="${admin.name}" /></td>
	    </tr>
	    <tr>
	      <th>닉네임</th>
	      <td><input type="text" id="adminNickname" name="nickname" value="${admin.nickname}" /></td>
	    </tr>
	  </table>
	
	  <div class="save-button">
	    <button type="button" id="updateAdmin">저장</button>
	  </div>
	</form>
  </main>
</div>

</body>
</html>