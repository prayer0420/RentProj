<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>오류 발생</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      padding: 40px;
      background-color: #f9f9f9;
      text-align: center;
    }
    .error-box {
      display: inline-block;
      padding: 30px 50px;
      background: #fff;
      border: 1px solid #ddd;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }
    h2 {
      color: #d9534f;
      margin-bottom: 20px;
    }
    p {
      font-size: 16px;
      color: #555;
      margin-bottom: 30px;
    }
    a {
      display: inline-block;
      padding: 10px 20px;
      background: #26c6da;
      color: #fff;
      text-decoration: none;
      border-radius: 4px;
      font-size: 14px;
    }
    a:hover {
      background: #1b9faf;
    }
  </style>
</head>
<body>

  <div class="error-box">
    <h2>⚠ 오류가 발생했습니다</h2>
    <p>${errorMessage}</p>
    <a href="${pageContext.request.contextPath}${returnUrl}">목록으로 돌아가기</a>
  </div>

</body>
</html>
