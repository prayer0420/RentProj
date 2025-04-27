<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<c:set var = "contextPath" value="${pageContext.request.contextPath}"/>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/service/service.css">
</head>
<body>
<jsp:include page="../Header/header.jsp"></jsp:include>
  <form action="">
        <div class="container">
        	<input type="hidden" name="no" value="${faq.no}">
            <h2>고객센터</h2>
            <hr>
            <div class="intro">안녕하세요! <strong>Re:NT 고객센터입니다!</strong></div>
            <div class="intro">무엇을 도와드릴까요?</div>

            <div class="faq-search-box">
                <div class="text">
                    <strong>FAQ</strong><br>
                    Re:NT이용시 자주 물어보는 질문입니다.<br>
                    찾지 못한 질문은 우측의 1:1문의를 활용해 주세요!
                </div>
                <div>
                    <input type="text" placeholder="검색어를 입력해주세요">
                    <button>🔍</button>
                </div>
            </div>

            <div class="content-grid">
                <!-- 자주 묻는 질문 -->
                <div class="faq-section">
                    <div class="section-title">
                        <span>자주 묻는 질문 TOP 5</span>
                        <a href="serviceFAQ.jsp">더보기 ></a>
                    </div>
                    <c:forEach var="faq" items="${faqList}">
                    <ul class="faq-list">
                        <a href="${contextPath}/serviceFAQ?no=${faq.no}"><li>${faq.title}</li></a>
                    </ul>
                     </c:forEach>
                </div>

                <!-- 공지사항 -->
                <div class="notice-section">
                    <div class="section-title">
                        <span>공지사항</span>
                        <a href="serviceAnnounce.jsp">더보기 ></a>
                    </div>
                    <ul class="notice-list">
                    <c:forEach var="announce" items="${announceList}">
                        <a href="${contextPath}/serviceAnnounce?no=${announce.no}"><li><span>[공지]</span>${announce.title}</li></a>
                    </c:forEach>
                    </ul>
                </div>
            </div>
           
        </div>
    </form>
</body>
</html>