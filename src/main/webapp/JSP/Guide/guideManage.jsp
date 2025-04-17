<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/guide/guideManage.css">
</head>
<body>
<jsp:include page="../Header/header.jsp"></jsp:include>
  <form action="">
        <h2>구매/대여 관리</h2>
        <hr>
        <div class="button-list">
            <button type="button"
                onclick="document.getElementById('purchase-manage').scrollIntoView({ behavior: 'smooth' })">구매관리</button>
            <button type="button"
                onclick="document.getElementById('sale-manage').scrollIntoView({ behavior: 'smooth' })">판매관리</button>
            <button type="button"
                onclick="document.getElementById('prod-purchase').scrollIntoView({ behavior: 'smooth' })">상품구매관리</button>
            <button type="button"
                onclick="document.getElementById('prod-sale').scrollIntoView({ behavior: 'smooth' })">상품판매관리</button>
        </div>
        <div class="container">
            <h2 id="purchase-manage">Re:NT구매관리</h2>
            <hr>
            <div class="text">주문취소 - 상품을 주문하고 판매자가 상품준비중이라면 취소가 가능해요.</div>
            <img src="" alt="">
            <h2 id="sale-manage">Re:NT판매관리</h2>
            <hr>
            <div class="text">자신이 판매한 물품에 대한 정보를 얻을 수 있고, 게시물을 관리할 수 있어요.</div>
            <img src="" alt="">
            <h2 id="prod-purchase">상품구매관리</h2>
            <hr>
            <div class="text">자신이 구매한 물품에대한 정보를 얻을 수 있고, 물품의 배달진행상태를 볼 수 있어요.</div>
            <img src="" alt="">
            <h2 id="prod-sale">상품판매관리</h2>
            <hr>
            <div class="text">자신이 구매한 물품에대한 정보를 얻을 수 있고, 물품의 배달진행상태를 볼 수 있어요.</div>
            <img src="" alt="">
        </div>
    </form>
</body>
</html>