<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>판매정산</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/common.css">

</head>
<body>
	<%@ include file="header.jsp" %>
<div class="container">
  <aside>
    <h3>정산관리</h3>
    <div class="menu inactive">전체주문조회</div>
    <div class="menu active">주문정산</div>
    <div class="menu inactive">대여지연조회</div>
  </aside>

  <main>
    <div class="breadcrumb">HOME > 정산관리 > 주문정산</div>

    <div class="search-box">
      <div class="row">
        <label>검색어
          <select>
            <option>주문번호</option>
          </select>
          <input type="text">
        </label>
        <button>검색</button>
      </div>

      <div class="row">
        <label>기간검색</label>
        <input type="text" placeholder="YYYYMMDD"> ~
        <input type="text" placeholder="YYYYMMDD">
      </div>

      <div class="row">
        <label>거래유형:</label>
        <label><input type="radio" name="type" checked> 전체</label>
        <label><input type="radio" name="type"> 판매</label>
        <label><input type="radio" name="type"> 대여</label>
      </div>
    </div>

    <div class="section-title">
      <span id="count"></span>
      <div class="summary-box">
        <div class="line">
          <span>total</span>
          <span style="font-weight: bold; color: #0097a7">5,000원</span>
        </div>
      </div>
    </div>

		<div style="margin-bottom:10px; font-weight:bold;">
		    🔍 검색된 총 정산 건수: <span style="color:#007bff;">${not empty settlementList ? fn:length(settlementList) : 0}</span>건
		</div>

    <div class="table-container">
      <table>
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
          <th>결제 방법</th>
          <th>정산일</th>
          <th>정산상태</th>
          <th></th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td>1</td>
          <td>ORD20240329</td>
          <td>aaa</td>
          <td>userA</td>
          <td>sellerA</td>
          <td>판매</td>
          <td>100000</td>
          <td>5000</td>
          <td>신용카드</td>
          <td>20250410</td>
          <td>정산진행예정</td>
          <td><button disabled>✓ 정산하기</button></td>
        </tr>
        <tr>
          <td>2</td>
          <td>ORD20240330</td>
          <td>bbb</td>
          <td>userB</td>
          <td>sellerB</td>
          <td>대여</td>
          <td>100000</td>
          <td>5000</td>
          <td>신용카드</td>
          <td>20250409</td>
          <td>정산완료</td>
         <td><button disabled>✓ 정산완료</button></td>
        </tr>

        </tbody>
      </table>
    </div>
  </main>
</div>
</body>
</html>