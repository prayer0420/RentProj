<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>전체수익조회</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/common.css">


</head>
	<%@ include file="header.jsp" %>
<body>
<div class="container">
  <aside>
    <h3>정산관리</h3>
    <div class="menu inactive">전체주문조회</div>
    <div class="menu active">전체수익조회</div>
    <div class="menu inactive">주문정산</div>
    <div class="menu inactive">대여지연조회</div>
  </aside>

  <main>
    <div class="breadcrumb">HOME > 정산관리 > 전체 수익 조회</div>

    <div class="search-section">
      <div class="search-box">
        <div class="row">
          <label>기간검색</label>
          <input type="text" placeholder="YYYYMMDD"> ~
          <input type="text" placeholder="YYYYMMDD">
          <button>당일</button>
          <button>당월</button>
          <button>전월</button>
          <button>검색</button>
        </div>
        <div class="row">
          <label>거래유형:</label>
          <label><input type="radio" name="type" checked> 전체</label>
          <label><input type="radio" name="type"> 판매수수료</label>
          <label><input type="radio" name="type"> 대여수수료</label>
        </div>
      </div>

      <div class="summary-box">
        <h4>수익합계</h4>
        <div class="line"><strong>Total</strong><strong>55,000원</strong></div>
      </div>
    </div>

    <div class="section-title">수수료 수익 <span id="feeCount"></span></div>
    <div class="table-container">
      <table id="feeTable">
        <thead>
          <tr>
            <th>NO</th>
            <th>주문번호</th>
            <th>상품명</th>
            <th>구매자</th>
            <th>판매자</th>
            <th>거래유형</th>
            <th>물품가</th>
            <th>수수료</th>
            <th>결제방식</th>
            <th>거래상태</th>
            <th>수수료획득</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>1</td><td>ORD20240329</td><td>aaa</td><td>userA</td><td>sellerA</td><td>판매</td><td>100000</td><td>5000</td><td>신용카드</td><td>구매확정</td><td>정산 완료</td>
          </tr>
          <tr>
            <td>2</td><td>ORD20240330</td><td>bbb</td><td>userB</td><td>sellerB</td><td>대여</td><td>100000</td><td>5000</td><td>신용카드</td><td>발송완료</td><td>정산 진행 예정</td>
          </tr>
        </tbody>
      </table>
    </div>

</main> 
</body>
</html>