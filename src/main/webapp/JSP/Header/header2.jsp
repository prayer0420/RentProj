<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>카테고리</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header/header2.css">
</head>
<body>

<section class="categories">

  <a href="${pageContext.request.contextPath}/list?categoryNo=1" class="category-item" data-categoryNo="1">
    <img src="https://cdn-icons-png.flaticon.com/512/1046/1046857.png" alt="의류/패션/악세사리">
    <span>의류/패션/악세사리</span>
  </a>

  <a href="${pageContext.request.contextPath}/list?categoryNo=2" class="category-item" data-categoryNo="2">
    <img src="https://cdn-icons-png.flaticon.com/512/2920/2920061.png" alt="PC/모바일">
    <span>PC/모바일</span>
  </a>

  <a href="${pageContext.request.contextPath}/list?categoryNo=3" class="category-item" data-categoryNo="3">
    <img src="https://cdn-icons-png.flaticon.com/512/149/149852.png" alt="가전 제품">
    <span>가전 제품</span>
  </a>

  <a href="${pageContext.request.contextPath}/list?categoryNo=4" class="category-item" data-categoryNo="4">
    <img src="https://cdn-icons-png.flaticon.com/512/2329/2329181.png" alt="뷰티/미용">
    <span>뷰티/미용</span>
  </a>

  <a href="${pageContext.request.contextPath}/list?categoryNo=5" class="category-item" data-categoryNo="5">
    <img src="https://cdn-icons-png.flaticon.com/512/2329/2329181.png" alt="캠핑/스포츠/레저">
    <span>캠핑/스포츠/레저</span>
  </a>

  <a href="${pageContext.request.contextPath}/list?categoryNo=6" class="category-item" data-categoryNo="6">
    <img src="https://cdn-icons-png.flaticon.com/512/1198/1198294.png" alt="생활/주방용품">
    <span>생활/주방용품</span>
  </a>

  <a href="${pageContext.request.contextPath}/list?categoryNo=7" class="category-item" data-categoryNo="7">
    <img src="https://cdn-icons-png.flaticon.com/512/3703/3703277.png" alt="가구인테리어">
    <span>가구인테리어</span>
  </a>

  <a href="${pageContext.request.contextPath}/list?categoryNo=8" class="category-item" data-categoryNo="8">
    <img src="https://cdn-icons-png.flaticon.com/512/929/929426.png" alt="유아동/출산">
    <span>유아동/출산</span>
  </a>

  <a href="${pageContext.request.contextPath}/list?categoryNo=9" class="category-item" data-categoryNo="9">
    <img src="https://cdn-icons-png.flaticon.com/512/3616/3616983.png" alt="애완동물용품">
    <span>애완동물용품</span>
  </a>

  <a href="${pageContext.request.contextPath}/list?categoryNo=10" class="category-item" data-categoryNo="10">
    <img src="https://cdn-icons-png.flaticon.com/512/3616/3616983.png" alt="기타">
    <span>기타</span>
  </a>

</section>

</body>
</html>
