<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>대여지연조회</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/common.css">

</head>
<body>
	<%@ include file="header.jsp" %>
<div class="container">
  <aside>
    <h3>정산관리</h3>
    <div class="menu inactive">전체주문조회</div>
    <div class="menu inactive">전체수익조회</div>
    <div class="menu inactive">판매정산</div>
    <div class="menu active">대여지연조회</div>
  </aside>

  <main>
    <div class="breadcrumb">HOME > 정산관리 > 대여지연조회</div>

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
    </div>

    <div class="total-count" id="delayCount"></div>

  <table>
  <thead>
    <tr>
      <th rowspan="2">no</th>
      <th rowspan="2">주문번호</th>
      <th rowspan="2">상품명</th>
      <th rowspan="2">구매자</th>
      <th rowspan="2">판매자</th>
      <th rowspan="2">거래유형</th>
      <th rowspan="2">배송유형</th>
      <th colspan="1">거래일자</th>
      <th colspan="3">결제금액</th>
      <th rowspan="2">결제수단</th>
      <th rowspan="2">거래 상태</th>
    </tr>
    <tr>
      <th>거래종료일</th>
      <th>물품가</th>
      <th>배송비</th>
      <th>보증금</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>ORD20240329</td>
      <td>aaa</td>
      <td>userA</td>
      <td>sellerA</td>
      <td>대여</td>
      <td>직접</td>
      <td>2025-03-31</td>
      <td>100000</td>
      <td>5000</td>
      <td>10000</td>
      <td>신용카드</td>
      <td>반납지연</td>
    </tr>
  </tbody>
</table>


    <div class="notice">
      * 구매자/판매자 선택 시 각 회원의 상세 정보 페이지 제공
    </div>
  </main>
</div>
</body>
</html>