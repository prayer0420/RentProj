<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 신고함</title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/myReportList.css" />
</head>
<body>

<jsp:include page="/JSP/Header/header.jsp" />

<div class="wrapper">
  <div class="container">
    <jsp:include page="/JSP/MyPage/mypageSidebar.jsp" />

    <section class="content">
      <h2 class="title">나의 신고함</h2>
      <div class="divider"></div>

      <c:choose>
        <c:when test="${empty reportList}">
          <p class="empty-text">신고한 내역이 없습니다.</p>
        </c:when>
        <c:otherwise>
          <div class="report-grid">
            <!-- 카드 반복문 부분만 수정 -->
			<c:forEach var="report" items="${reportList}">
			  <div class="report-card">
			    <div class="report-info">
			      <h3 class="report-title">${report.title}</h3> 
			      <p class="report-type">사유: ${report.type}</p> 
			      <p class="report-date"> 신고일자:
			        <fmt:formatDate value="${report.date}" pattern="yyyy년 MM월 dd일 HH:mm" />
			      </p>
			      <p class="report-contents">신고내용: ${report.contents}</p> 
			      <p class="product-title">상품명: ${report.productTitle}</p>
			
			      <!-- 🔥 상품 상세보기 버튼 추가 -->
			      <button class="go-detail-btn" onclick="location.href='${contextPath}/productDetail?no=${report.productNo}'">
			        상품 상세보기
			      </button>
			    </div>
			  </div>
			</c:forEach>
          </div>
        </c:otherwise>
      </c:choose>

      <!-- 페이징 -->
      <div class="paging">
        <c:if test="${pageInfo.curPage > 1}">
          <a class="page-btn" href="${contextPath}/myReportList?page=${pageInfo.curPage - 1}">&lt;</a>
        </c:if>
        <c:forEach var="page" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
          <c:choose>
            <c:when test="${page == pageInfo.curPage}">
              <a class="page-btn active" href="${contextPath}/myReportList?page=${page}">${page}</a>
            </c:when>
            <c:otherwise>
              <a class="page-btn" href="${contextPath}/myReportList?page=${page}">${page}</a>
            </c:otherwise>
          </c:choose>
        </c:forEach>
        <c:if test="${pageInfo.curPage < pageInfo.allPage}">
          <a class="page-btn" href="${contextPath}/myReportList?page=${pageInfo.curPage + 1}">&gt;</a>
        </c:if>
      </div>

    </section>
  </div>
</div>

<jsp:include page="/JSP/Header/footer.jsp" />

</body>
</html>