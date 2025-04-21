<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header/header2.css">

<!-- 1. 카테고리 이름 / 아이콘 JSTL 배열로 정의 -->
<c:set var="categoryNames" value="${fn:split('전체,의류/패션/악세사리,PC/모바일,가전 제품,뷰티/미용,캠핑/스포츠/레저,생활/주방용품,가구인테리어,유아동/출산,애완동물용품,기타', ',')}" />
<c:set var="categoryIcons" value="${fn:split(
  &quot;https://cdn-icons-png.flaticon.com/512/1046/1046857.png,
  https://cdn-icons-png.flaticon.com/512/892/892458.png,
  https://cdn-icons-png.flaticon.com/512/2920/2920061.png,
  https://cdn-icons-png.flaticon.com/512/149/149852.png,
  https://cdn-icons-png.flaticon.com/512/3095/3095583.png,
  https://cdn-icons-png.flaticon.com/512/2329/2329181.png,
  https://cdn-icons-png.flaticon.com/512/1198/1198294.png,
  https://cdn-icons-png.flaticon.com/512/3703/3703277.png,
  https://cdn-icons-png.flaticon.com/512/929/929426.png,
  https://cdn-icons-png.flaticon.com/512/1998/1998611.png,
  https://cdn-icons-png.flaticon.com/512/3616/3616983.png&quot;, ',')}" 
 />

<!-- 2. 카테고리 UI 렌더링 -->
<section class="categories">
  <c:forEach var="i" begin="0" end="10">
    <a href="${pageContext.request.contextPath}/list?categoryNo=${i}"
       class="category-item ${param.categoryNo == i ? 'active' : ''}" data-categoryNo="${i}">
      <img src="${categoryIcons[i]}" alt="${categoryNames[i]} 아이콘" />
      <span>${categoryNames[i]}</span>
    </a>
  </c:forEach>
</section>
