<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/service/serviceFAQ.css">
<script>
        window.onload = function () {
            const question = document.querySelector('.faq-question');
            const item = document.querySelector('.faq-item');

            question.addEventListener('click', () => {
                item.classList.toggle('active');
            });
        }
    </script>
</head>
<body>
<jsp:include page="../Header/header.jsp"></jsp:include>
  <form action="">
        <div class="container">
            <h2>FAQ</h2>
            <hr>
            <!-- 탭 메뉴 -->
            <div class="tabs">
                <div class="tab">주문/결제</div>
                <div class="tab">배송</div>
                <div class="tab">취소/환불</div>
                <div class="tab">반품/교환</div>
                <div class="tab">기타</div>
            </div>
            <!-- 검색 -->
            <div class="search-bar">
                <input type="text" placeholder="검색어를 입력해주세요">
            </div>
            <!-- 개수 -->
            <div class="faq-count">전체 1개</div>
            <!-- FAQ 항목 -->
            <div class="faq-item">
                <div class="faq-question">정산 수수료는 어떻게 되나요?</div>
                <div class="faq-answer">
                    <img src="" alt="사진">
                    <p>
                        판매자의 정산 수수료는 회원등급에 따라 다르게 적용됩니다.<br><br>
                        • 골드: 4%<br>
                        • 실버: 3.5%<br>
                        • 다이아: 3%<br><br>
                        구매자는 수수료가 부과되지 않으며 무료입니다.<br><br>
                        수수료가 적용되는 시점은 결제방식에 따라 다릅니다.<br>
                        구매결제: ‘구매자가 구매하기 버튼을 누른 시점’
                    </p>
                </div>
            </div>
        </div>
    </form>
</body>
</html>