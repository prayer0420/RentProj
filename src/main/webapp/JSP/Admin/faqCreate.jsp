<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<head>
  <meta charset="UTF-8">
  <title>FAQ 등록</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/common.css"> 
  <style>
    .action-top {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-top: 10px;
      margin-bottom: 10px;
    }

    .action-buttons button {
      background-color: #26c6da;
      color: white;
      padding: 4px 12px;
      border: none;
      border-radius: 3px;
      font-size: 13px;
      cursor: pointer;
      margin-right: 4px;
    }

    .action-buttons button:last-child {
      margin-right: 0;
    }

    .total-count-wrap {
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 1px solid #ccc;
      padding-bottom: 6px;
      margin-bottom: 10px;
    }

    .total-count {
      font-weight: bold;
    }
  </style>
</head>
<body>
	<%@ include file="header.jsp" %>
  <div class="container">
    <aside>
      <h3>FAQ</h3>
      <div class="menu inactive">FAQ 분류</div>
      <div class="menu active">FAQ 등록</div>
      <div style="height: 10px;"></div>
      <h3>공지사항</h3>
      <div class="menu inactive">공지사항 등록</div>
    </aside>

    <main>
      <div class="breadcrumb">HOME &gt; 고객지원 &gt; FAQ</div>

      <div class="total-count-wrap">
        <div class="total-count">전체 <strong>1</strong>건</div>
      </div>

      <div class="action-top">
        <div class="action-buttons">
          <button>선택수정</button>
          <button>선택삭제</button>
        </div>
        <button>+ 추가하기</button>
      </div>

      <table>
        <thead>
          <tr>
            <th><input type="checkbox"></th>
            <th>번호</th>
            <th>분류명</th>
            <th>제목</th>
            <th>등록일</th>
            <th>최종수정일</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><input type="checkbox"></td>
            <td>1</td>
            <td>주문/결제</td>
            <td>상품 등록 이용가이드</td>
            <td>2025-04-03</td>
            <td>2025-04-03</td>
          </tr>
        </tbody>
      </table>
    </main>
  </div>
</body>
</html>