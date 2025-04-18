<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원정보</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> 
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/common.css">
<%-- 	<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/modal.css"> --%>

  
  
  <style>
  /* Inputs */
input[type="text"] {
  width: 140px;
  padding: 4px;
  font-size: 13px;
  text-align: left;
}

.modal-footer button {
  background-color: #26c6da;
  color: white;
  border: none;
  padding: 8px 20px;
  border-radius: 4px;
  font-size: 14px;
  cursor: pointer;
}
  
  </style>

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
		  <div class="total-count">총 회원 <span id="count">${fn:length(memberList)}</span>명</div>
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
		      <c:forEach var="member" items="${memberList}">
		        <tr>
		          <td>${member.no}</td>
		          <td>${member.gradeId}</td>
		          <td>
		            <a href="#" class="open-modal"
		               data-no="${member.no}"
		               data-gradeid="${member.gradeId}"
		               data-name="${member.name}"
		               data-id="${member.id}"
		               data-nickname="${member.nickname}"
		               data-phone="${member.phone}"
		               data-address1="${member.address1}"
		               data-address2="${member.address2}"
		               data-address3="${member.address3}"
		               data-region1="${member.region1}"
		               data-region2="${member.region2}"
		               data-region3="${member.region3}"
		               data-ordercount="${member.orderCount}"
		               data-regdate="${member.regDate}"
		               data-bs-toggle="modal" data-bs-target="#myModal">
		              ${member.name}
		            </a>
		          </td>
		          <td>
		            <a href="#" class="open-modal"
		               data-no="${member.no}"
		               data-gradeid="${member.gradeId}"
		               data-name="${member.name}"
		               data-id="${member.id}"
		               data-nickname="${member.nickname}"
		               data-phone="${member.phone}"
		               data-address1="${member.address1}"
		               data-address2="${member.address2}"
		               data-address3="${member.address3}"
		               data-region1="${member.region1}"
		               data-region2="${member.region2}"
		               data-region3="${member.region3}"
		               data-ordercount="${member.orderCount}"
		               data-regdate="${member.regDate}"
		               data-bs-toggle="modal" data-bs-target="#myModal">
		              ${member.id}
		            </a>
		          </td>
		          <td>${member.nickname}</td>
		          <td>${member.phone}</td>
		          <td>${member.region1}</td>
		          <td>${member.address1}</td>
		        </tr>
		      </c:forEach>
    		</tbody>
 		 </table>
 </c:if>
	 <br>
	<div id="paging">
		<c:choose>
			<c:when test="${pageInfo.curPage > 1}">
				<a href="list?page=${pageInfo.curPage-1 }">&lt;</a>
			</c:when>
			<c:otherwise>
				<a>&lt;</a>
			</c:otherwise>
		</c:choose>
		
		<c:forEach begin="${pageInfo.startPage }" end="${pageInfo.endPage }" step="1" var="page">
			<c:choose>
				<c:when test="${page eq pageInfo.curPage }">
					<a href="list?page=${page }" class="select">${page }</a>
				</c:when>
				<c:otherwise>
					<a href="list?page=${page }" class="btn">${page }</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:choose>
			<c:when test="${pageInfo.curPage<pageInfo.allPage }">
				<a href="list?page=${pageInfo.curPage+1 }">&gt;</a>
			</c:when>
			<c:otherwise>
				<a>&gt;</a>
			</c:otherwise>
		</c:choose>
	</div>
	
  </main>
</div>

  <!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">회원 정보 상세</h4>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <div><strong>회원번호:</strong> <span id="modalNo"></span></div>
          <div><strong>등급:</strong> <span id="modalGradeId"></span></div>
          <div><strong>이름:</strong> <span id="modalName"></span></div>
          <div><strong>아이디:</strong> <span id="modalId"></span></div>
          <div><strong>닉네임:</strong> <span id="modalNickname"></span></div>
          <div><strong>전화번호:</strong> <span id="modalPhone"></span></div>
          <div><strong>주소1:</strong> <span id="modalAddr1"></span></div>
          <div><strong>주소2:</strong> <span id="modalAddr2"></span></div>
          <div><strong>주소3:</strong> <span id="modalAddr3"></span></div>
          <div><strong>거래지역1:</strong> <span id="modalRegion1"></span></div>
          <div><strong>거래지역2:</strong> <span id="modalRegion2"></span></div>
          <div><strong>거래지역3:</strong> <span id="modalRegion3"></span></div>
          <div><strong>주문횟수:</strong> <span id="modalOrder"></span></div>
          <div><strong>가입일:</strong> <span id="modalRegDate"></span></div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn-confirm" data-bs-dismiss="modal">✔ 확인</button>
        </div>
      </div>
    </div>
</div>

  <script>
    document.addEventListener("DOMContentLoaded", function () {
      document.querySelectorAll(".open-modal").forEach(el => {
        el.addEventListener("click", function () {
          document.getElementById("modalNo").innerText = this.dataset.no;
          document.getElementById("modalGradeId").innerText = this.dataset.gradeid;
          document.getElementById("modalName").innerText = this.dataset.name;
          document.getElementById("modalId").innerText = this.dataset.id;
          document.getElementById("modalNickname").innerText = this.dataset.nickname;
          document.getElementById("modalPhone").innerText = this.dataset.phone;
          document.getElementById("modalAddr1").innerText =  this.dataset.address1;
          document.getElementById("modalAddr2").innerText =  this.dataset.address2;
          document.getElementById("modalAddr3").innerText =  this.dataset.address3;
          document.getElementById("modalRegion1").innerText = this.dataset.region1;
          document.getElementById("modalRegion2").innerText = this.dataset.region2;
          document.getElementById("modalRegion3").innerText = this.dataset.region3;
          document.getElementById("modalOrder").innerText = this.dataset.ordercount;
          document.getElementById("modalRegDate").innerText = this.dataset.regdate;
        });
      });
    });
  </script>


   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>