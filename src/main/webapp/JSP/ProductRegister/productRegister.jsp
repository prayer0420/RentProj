<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/productRegister/productRegister.css">
</head>
<body>
<jsp:include page="../Header/header.jsp"></jsp:include>
<form action="">
        <div class="container">
          <h2>상품등록</h2>
          <hr>
            <div class="type-filter">
                <a href="productRegisterSell.jsp" class="type-link type-sell">판매</a>
                <a href="productRegisterRent.jsp" class="type-link type-rent">대여</a>
                <a href="productRegisterRentSell.jsp" class="type-link type-both">판매/대여</a>
                <a href="productRegisterFree.jsp" class="type-link type-free">무료나눔</a>
              </div>
        </div>
      </form>
</body>
</html>