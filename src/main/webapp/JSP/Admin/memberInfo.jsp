<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원정보</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/common.css">
  <style>
  /* Inputs */
input[type="text"] {
  width: 140px;
  padding: 4px;
  font-size: 13px;
  text-align: left;
}
  
  </style>
<script>


</script>

</head>
<body>
	<%@ include file="header.jsp" %>
  <div class="container">
    <aside>
      <h3>회원관리</h3>
      <div class="menu active">회원정보</div>
      <div class="menu inactive">회원등급</div>
    </aside>
    <main>
      <div class="breadcrumb">HOME > 회원관리 > 회원정보관리</div>
      <form action="memberInfo" method="post">
      <div class="search-box">
        <label>검색어
          <select name="type">
            <option value="name">회원명</option>
            <option value="id">아이디</option>
            <option value="phone">핸드폰번호</option>

          </select>
        </label>
        <input type="text" name="word">
        <input type="submit" value="검색">
        <br><br>
        회원등급:
        <label><input type="radio" name="gradeId" value="" checked> 전체</label>
        <label><input type="radio" name="gradeId" value="bronze" > 브론즈</label>
        <label><input type="radio" name="gradeId" value="silver"> 실버</label>
        <label><input type="radio" name="gradeId" value="gold"> 골드</label>
        <label><input type="radio" name="gradeId" value="platinum"> 플래티넘</label>
        <label><input type="radio" name="gradeId" value="dia"> 다이아</label>
        <label><input type="radio" name="gradeId" value="rent"> Re:NT</label>
      </div>
      </form>
  <c:if test="${not empty memberList}">
  <div class="total-count">총 회원<span id="count">${fn:length(memberList) }</span>명</div>
      <table id="adminListTable" border="1">
        <thead>
          <tr>
            <th>번호</th>
            <th>등급</th>
            <th>회원명</th>
            <th>아이디</th>
            <th>닉네임</th>
            <th>핸드폰번호</th>
            <th>거래지역1</th>
            <th>배송지1</th>
          </tr>
        </thead>
        <tbody id="adminListBody">
        
		<c:if test="${not empty memberList}">
		  <c:forEach var="member" items="${memberList}">
		    <tr>
		      <td>${member.no}</td>
		      <td>${member.gradeId}</td>
		      <td>${member.name}</td>
		      <td>${member.id}</td>
		      <td>${member.nickname}</td>
		      <td>${member.phone}</td>
		      <td>${member.region1}</td>
		      <td>${member.address1}</td>
		    </tr>
		  </c:forEach>
		</c:if>
        </tbody>
      </table>
      <!-- 페이징 처리 추가 예정 -->
		<div class="pagination">
		  <button class="prev">이전</button>
		  <span class="page-numbers">1 2 3 4 5</span>
		  <button class="next">다음</button>
		</div>
      </c:if>
    </main>
  </div>
</body>
</html>