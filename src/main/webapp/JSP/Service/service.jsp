<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/service/service.css">
</head>
<body>
<jsp:include page="../Header/header.jsp"></jsp:include>
  <form action="">
        <div class="container">
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
                    <ul class="faq-list">
                        <li>정산 수수료는 어떻게 되나요?</li>
                        <li>정산 수수료는 어떻게 되나요?</li>
                        <li>정산 수수료는 어떻게 되나요?</li>
                        <li>정산 수수료는 어떻게 되나요?</li>
                        <li>정산 수수료는 어떻게 되나요?</li>
                    </ul>
                </div>

                <!-- 공지사항 -->
                <div class="notice-section">
                    <div class="section-title">
                        <span>공지사항</span>
                        <a href="serviceAnnounce.jsp">더보기 ></a>
                    </div>
                    <ul class="notice-list">
                        <li><span>[공지]</span> 정산 수수료는 어떻게 되나요?</li>
                    </ul>
                </div>
            </div>
        </div>
    </form>
</body>
</html>