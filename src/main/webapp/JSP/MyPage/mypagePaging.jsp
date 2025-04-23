<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Paging</title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/mypagePaging.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>
<!-- 페이징 처리 --> 
          <br>
          <c:set var="curPage" value="${param.baseUrl }" />
          
			<div id="paging">
				<c:choose>
					<c:when test="${pageInfo.curPage>1 }">
						<a href="${baseUrl}?page=${pageInfo.curPage-1 }">&lt;</a>
					</c:when>
					<c:otherwise>
						<a>&lt;</a>
					</c:otherwise>
				</c:choose>
					<c:forEach begin="${pageInfo.startPage }" end="${pageInfo.endPage }" step="1" var="page">
						<c:choose>
							<c:when test="${page eq pageInfo.curPage }">
								<a href="${baseUrl}?page=${page }" class="select">${page}</a>
							</c:when>
							<c:otherwise>
								<a href="${baseUrl}?page=${page }" class="btn">${page}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
							
					<c:choose>
						<c:when test="${pageInfo.curPage<pageInfo.allPage }">
							<a href="${baseUrl}?page=${pageInfo.curPage+1 }">&gt;</a>
						</c:when>
						<c:otherwise>
							<a>&gt;</a>
						</c:otherwise>
					</c:choose>
			</div>

</body>
</html>