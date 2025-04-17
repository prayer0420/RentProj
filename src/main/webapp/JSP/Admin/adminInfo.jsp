<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>관리자 정보 확인</title>
  <link rel="stylesheet" href="css/common.css">
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
<body>
	<%@ include file="header.jsp" %>
<div class="container">
  <aside>
    <h3>관리자정보</h3>
    <div class="menu active">관리자 정보 확인</div>
  </aside>

  <main>
    <div class="breadcrumb">HOME > 관리정보 > 관리자 정보 확인</div>

    <table class="user-info-table">
      <tr>
        <th>이름</th>
        <td><input type="text" value="홍길동"></td>
      </tr>
      <tr>
        <th>아이디</th>
        <td><input type="text" value="hong001"></td>
      </tr>
      <tr>
        <th>패스워드</th>
        <td><input type="text" value="hong001password"></td>
      </tr>
       <tr>
        <th>이메일</th>
        <td><input type="text" value="hong001@kosta.com"></td>
      </tr>     
    </table>

    <div class="save-button">
      <button>저장</button>
    </div>
  </main>
</div>

</body>
</html>