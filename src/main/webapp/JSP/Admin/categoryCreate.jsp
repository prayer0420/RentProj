<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>카테고리등록</title>
  <link rel="stylesheet" href="css/common.css">
  <style>
    .category-section {
      border: 1px solid #ccc;
      padding: 10px;
      margin-bottom: 20px;
    }

    .category-row {
      margin-bottom: 10px;
    }

    .category-row.inline {
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .category-row label {
      font-size: 14px;
    }

    .search-input {
      width: 180px;
      padding: 4px;
      font-size: 13px;
    }

    .category-table {
      width: 100%;
      border-collapse: collapse;
    }

    .category-table th, .category-table td {
      border: 1px solid #ccc;
      padding: 6px;
      font-size: 13px;
      text-align: center;
    }

    .category-table th {
      background: #e0e6ed;
    }

    .category-table input[type="text"],
    .category-table select {
      width: 90%;
      padding: 4px;
    }

    .category-table input[type="checkbox"] {
      transform: scale(1.2);
    }

    .btn-save, .btn-file, .btn-up, .btn-down {
      background-color: #26c6da;
      color: white;
      padding: 5px 12px;
      border: none;
      border-radius: 3px;
      font-size: 13px;
      cursor: pointer;
    }

    .sort-buttons {
      display: flex;
      justify-content: center;
      gap: 4px;
    }

    .file-label {
      margin-left: 10px;
      font-size: 13px;
      color: #333;
    }

    .category-count {
      margin-bottom: 5px;
      font-size: 13px;
    }
  </style>
</head>
<script>
  // DOM이 로드되면 실행
  document.addEventListener('DOMContentLoaded', function () {
    const tbody = document.querySelector('.category-table tbody');
    const totalCountEl = document.querySelector('.category-count');

    if (tbody && totalCountEl) {
      const rowCount = tbody.querySelectorAll('tr').length;
      totalCountEl.innerHTML = `총 개수 ${rowCount} <button class="btn-save" style="margin-left: 10px;">✔ 저장</button>`;
    }
  });
</script>
<body>
	<%@ include file="header.jsp" %>
<div class="container">
  <aside>
    <h3>카테고리</h3>
    <div class="menu active">카테고리등록</div>
  </aside>
  <main>
    <div class="breadcrumb">HOME > 카테고리 > 카테고리등록</div>

    <div class="category-section">
      <div class="category-row inline">
        <label for="categoryName">카테고리명</label>
        <input type="text" class="search-input" id="categoryName">
        <button class="btn-save">✔ 저장</button>
      </div>
    </div>

    <div class="category-count">총 개수 0 <button class="btn-save" style="margin-left: 10px;">✔ 저장</button></div>

    <table class="category-table">
      <thead>
      <tr>
        <th>번호</th>
        <th>정렬</th>
        <th>카테고리명</th>
        <th>숨김 여부</th>
      </tr>
      </thead>
      <tbody>
      <tr>
        <td>001</td>
        <td>
          <div class="sort-buttons">
            <button class="btn-up">위로↑</button>
            <button class="btn-down">아래로↓</button>
          </div>
        </td>
        <td>
          <input type="text" value="의류/패션/악세사리">
        </td>
        <td><input type="checkbox"> 카테고리 숨김</td>
      </tr>
      <!-- 반복 항목 추가 가능 -->
      </tbody>
    </table>
  </main>
</div>
</body>
</html>