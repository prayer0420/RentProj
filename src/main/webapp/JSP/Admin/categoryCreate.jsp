<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>카테고리등록</title>
  <link rel="stylesheet" href="CSS/Admin/common.css">
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
<script src="https://code.jquery.com/jquery-3.7.1.js"></script> 
<script>
  
  $(function() {
	$("input:checkbox").click(function() {
		let checked = $(this).is(":checked");
		if(checked==true) {
			$(this).prev().val("false")
		} else {
			$(this).prev().val("true")
		}
	})		  
	
	$("#regCategory").click(function() {
		$.ajax({
			url:"categoryCreate",
			method:"post",
			data:{name:$("#categoryName").val()},
			success:function(result) {
				let category = JSON.parse(result);
				console.log(category);
				$("table>tbody").append($(`<tr>
							<td><input type="text" value="\${category.no }" name="no"></td>
				        	<td><input type="text" value="\${category.name }" name="name"></td>
				        	<td><input type="hidden"  name="isActive" value="false"/><input type="checkbox">카테고리 숨김</td>
				        	<td><div class="sort-buttons"><button class="btn-up">위로↑</button><button class="btn-down">아래로↓</button></div></td>
				        	</tr>`))
				console.log($("#count").text())
				$("#count").text(+$("#count").text()+1);
			}
		})
	})
  }) 
  
 function moveUp(el){
	var $tr = $(el).parent().parent().parent(); // 클릭한 버튼이 속한 tr 요소
	$tr.prev().before($tr); // 현재 tr 의 이전 tr 앞에 선택한 tr 넣기
 }

 function moveDown(el){
	var $tr = $(el).parent().parent().parent(); // 클릭한 버튼이 속한 tr 요소
	$tr.next().after($tr); // 현재 tr 의 다음 tr 뒤에 선택한 tr 넣기
 }
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
        <button class="btn-save" id="regCategory" >✔ 등록</button>
      </div>
    </div>
    
	<form  action="categoryUpdate" method="post">
    <div class="category-count">총 <span id="count">${fn:length(categoryList) }</span>개<button class="btn-save" style="margin-left: 10px;">✔ 저장</button></div>

	
    <table class="category-table">
      <thead>
      <tr>
        <th>번호</th>
        <th>카테고리명</th>
        <th>숨김 여부</th>
        <th>정렬</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach items="${categoryList}" var="category">
           <tr>
        	<td><input type="text" value="${category.no }" name="no" readonly="readonly"></td>
	        <td>
    	      <input type="text" value="${category.name }" name="name">
        	</td>
        	<td>
         	<c:choose>
        		<c:when test="${category.isActive==true }">
        			<input type="hidden"  name="isActive" value="true" />
        			<input type="checkbox" >
        		</c:when>
        		<c:otherwise>
        			<input type="hidden"  name="isActive" value="false"/>
        			<input type="checkbox" checked="checked">
        		</c:otherwise>
        	</c:choose> 
        	카테고리 숨김</td>
        	<td>
	          <div class="sort-buttons">
    	        <button class="btn-up" onclick="moveUp(this)">위로↑</button>
        	    <button class="btn-down"onclick="moveDown(this)">아래로↓</button>
          	</div>
        	</td>
      	</tr>
      </c:forEach>
 

      </tbody>
    </table>
    </form>
  </main>
</div>
</body>
</html>