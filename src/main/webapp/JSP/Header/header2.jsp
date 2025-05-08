<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header/header2.css">

<!-- 카테고리 이름 / 아이콘 JSTL 배열로 정의 -->
<c:set var="categoryNames" value="${fn:split('전체,의류/패션/악세사리,PC/모바일,가전 제품,뷰티/미용,캠핑/스포츠/레저,생활/주방용품,가구인테리어,유아동/출산,애완동물용품,기타', ',')}" />

<c:set var="categoryIcons" value="${fn:split('img/category/all.png,img/category/clothes.png,img/category/packaging.png,img/category/homeAppliance.png,img/category/beauty.png,img/category/etc.png,img/category/kitchen.png,img/category/cookware.png,img/category/baby.png,img/category/pet.png,img/category/profileImage.png', ',')}" />

<!-- 카테고리 UI 렌더링 -->
<section class="categories">
  <c:forEach var="category" items="${categoryList}">
    <a href="${pageContext.request.contextPath}/list?categoryNo=${category.no}"
       class="category-item ${param.categoryNo == category.no ? 'active' : ''}"
       data-categoryNo="${category.no}">
      <img src="${pageContext.request.contextPath}/${category.imgFilename}" alt="${category.name} 아이콘" loading="lazy" />
      <span>${category.name}</span>
    </a>
  </c:forEach>
</section>