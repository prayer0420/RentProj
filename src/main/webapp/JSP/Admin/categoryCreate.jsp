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
	
    $("#imgFile").change(function () {
      const fileName = this.files.length > 0 ? this.files[0].name : "선택된 파일 없음";
      $("#fileNameLabel").text(fileName);
    });
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
		<form action="categoryCreate" id="regCategoryForm" enctype="multipart/form-data" method="post">			
		  <!-- 카테고리명 입력 -->
		  <div class="category-row inline">
		    <label for="categoryName"><b>카테고리명</b></label>
		    <input type="text" class="search-input" id="categoryName" name="name" required="required">
		    <button class="btn-save" id="regCategory">✔ 추가</button>
		  </div>
		
		  <!-- 이미지 선택 -->
		  <div class="category-row inline">
		    <label><b>이미지선택</b></label>
		    <label class="btn-file">
		      + 파일선택
		      <input type="file" name="img" id="imgFile" style="display: none;">
		    </label>
		    <span id="fileNameLabel" class="file-label">선택된 파일 없음</span>
		  </div>
		</form>
		</div>
	
    
	<form  action="categoryUpdate" method="post" enctype="multipart/form-data">
    <div class="category-count">총 <span id="count">${fn:length(categoryList) }</span>개<button class="btn-save" style="margin-left: 10px;">✔ 저장</button></div>

	
    <table class="category-table">
      <thead>
      <tr>
        <th>번호</th>
        <th>카테고리명</th>
        <th>이미지파일</th>
        <th>숨김 여부</th>
        <th>정렬</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach items="${categoryList}" var="category" varStatus="status">
           <tr>
        	<td><input type="text" value="${category.no }" name="no" readonly="readonly"></td>
	        <td>
    	      <input type="text" value="${category.name }" name="name">
        	</td>
        	<td><label class="input-file-button" for="input-file${status.index }">
        		${(category.imgFilename eq null || category.imgFilename eq '')? '파일선택':category.imgFilename }  </label>
        		<input type="file" class="imgFile" id="input-file${status.index }" name="imgfilename${status.index }"  style='display:none'>
        		<input type="hidden" name="oldFilename" value="${category.imgFilename}">	
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
    	        <span class="btn-up" onclick="moveUp(this)">위로↑</span>
        	    <span class="btn-down"onclick="moveDown(this)">아래로↓</span>
          	</div>
        	</td>
      	</tr>
      </c:forEach>
 

      </tbody>
    </table>
    </form>
  </main>
</div>
<script>
 	$(".imgFile").change(function(e) {
		$(this).prev().text(e.target.files[0].name)
	})
</script>
</body>
</html>