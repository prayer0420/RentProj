<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>FAQ 분류</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/common.css"> 
  <style>
    .category-box {
      border: 1px solid #ccc;
      padding: 12px;
      margin-bottom: 20px;
      font-size: 13px;
      background: #f9f9f9;
    }

    .category-box input[type="text"] {
      width: 200px;
      padding: 4px;
    }

    .category-box button {
      background-color: #26c6da;
      color: white;
      border: none;
      padding: 4px 10px;
      font-size: 13px;
      border-radius: 3px;
      cursor: pointer;
    }

    .section-gap {
      margin-bottom: 20px;
    }

    .btn-modify {
      background-color: #26c6da;
      color: white;
      padding: 3px 8px;
      font-size: 12px;
      border: none;
      border-radius: 3px;
      cursor: pointer;
    }

    .total-count {
      font-size: 14px;
      margin-bottom: 10px;
      font-weight: bold;
    }
  </style>
</head>
<body>
	<%@ include file="header.jsp" %>
<div class="container">
  <aside>
    <h3>FAQ</h3>
    <div class="menu active"><a href="faqCategory" style="color: inherit; text-decoration: none;">FAQ 분류</a></div>
    <div class="menu inactive"><a href="faqCreate" style="color: inherit; text-decoration: none;">FAQ 등록</a></div>
    <div class="section-gap"></div>
    <h3>공지사항</h3>
    <div class="menu inactive"><a href="announceList" style="color: inherit; text-decoration: none;">공지사항 등록</a></div>
  </aside>

  <main>
    <div class="breadcrumb">HOME &gt; 고객지원 &gt; FAQ</div>

    <div class="category-box">
      <label><b>분류명</b>&nbsp;&nbsp;<input type="text" id="categoryName"></label>
      <button onclick="addCategory()">추가</button>
    </div>

    <div class="total-count">
      총 <strong><span id="count">${not empty faqCategoryList ? fn:length(faqCategoryList) : 0}</span></strong>건
    </div>

    <table id="categoryTable" style="width: 400px;">
      <thead>
        <tr>
          <th>번호</th>
          <th>분류명</th>
        </tr>
      </thead>
     <tbody>
        <c:forEach var="cat" items="${faqCategoryList}" varStatus="status">
          <tr>
 		    <td>${cat.no}</td>
            <td>${cat.name}</td>
          </tr>
        </c:forEach>
	</tbody>
    </table>
  </main>
</div>


<script>
  function addCategory() {
    const name = document.getElementById("categoryName").value.trim();
    if (!name) {
      alert("분류명을 입력하세요.");
      return;
    }

    fetch("${pageContext.request.contextPath}/faqCategoryCreate", {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: "name=" + encodeURIComponent(name)
    })
    .then(res => res.json())
    .then(data => {
      if (data.success) {
        // alert("카테고리가 추가되었습니다.");
        document.getElementById("categoryName").value = "";
        refreshCategoryList(); // 새로 불러옴
      } else {
        alert("추가 실패 또는 중복된 이름입니다.");
      }
    });
  }

  function refreshCategoryList() {
    fetch("${pageContext.request.contextPath}/faqCategoryCreate")
      .then(res => res.json())
      .then(data => {
        const tbody = document.querySelector("#categoryTable tbody");
        const count = document.getElementById("count");

        // 기존 목록 초기화
        while (tbody.firstChild) {
          tbody.removeChild(tbody.firstChild);
        }

        // 새로 추가
        data.forEach(cat => {
          const tr = document.createElement("tr");

          const tdNo = document.createElement("td");
          tdNo.textContent = cat.no;

          const tdName = document.createElement("td");
          tdName.textContent = cat.name;

          tr.appendChild(tdNo);
          tr.appendChild(tdName);
          tbody.appendChild(tr);
        });

        count.textContent = data.length;
      });
  }

</script>

</body>
</html>