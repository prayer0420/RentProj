<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/CSS/service/serviceFAQ.css">
<script>
let searchKeyword = '${searchKeyword}';
let filterNo = '${filterNo}';

window.onload = function () {
    const questions = document.querySelectorAll('.faq-question');
    const faqItems = document.querySelectorAll('.faq-item');

    questions.forEach((question) => {
        question.addEventListener('click', () => {
            const item = question.parentElement;
            item.classList.toggle('active');
        });
    });

    // ✅ 페이지 처음 로드할 때
    if (filterNo) {
        // 특정 번호만 보이게
        faqItems.forEach(item => {
            const itemNo = item.getAttribute('data-no');
            if (itemNo !== filterNo) {
                item.style.display = 'none';
            }
        });
    } else if (searchKeyword) {
        // 검색 키워드로 필터링
        faqItems.forEach(item => {
            const title = item.querySelector('.faq-question')?.innerText || "";
            if (!title.includes(searchKeyword)) {
                item.style.display = 'none';
            }
        });
    }
};

// 카테고리별 키워드
const categoryKeywords = {
    '주문/결제': ['주문', '결제'],
    '수수료': ['수수료'],
    '배송': ['배송'],
    '취소/환불': ['취소', '환불'],
    '반품/교환': ['반품', '교환'],
    '기타': []
};

// 카테고리 버튼 필터링
function filterFAQ(category) {
    const faqItems = document.querySelectorAll('.faq-item');
    faqItems.forEach(item => {
        item.style.display = 'block';
    });

    faqItems.forEach(item => {
        const title = item.querySelector('.faq-question')?.innerText || "";

        if (category === '전체') {
            item.style.display = 'block';
        } else if (category === '기타') {
            const allKeywords = Object.values(categoryKeywords).flat().filter(word => word);
            const hasAnyKeyword = allKeywords.some(keyword => title.includes(keyword));
            item.style.display = hasAnyKeyword ? 'none' : 'block';
        } else {
            const keywords = categoryKeywords[category] || [];
            const matchesCategory = keywords.some(keyword => title.includes(keyword));
            item.style.display = matchesCategory ? 'block' : 'none';
        }
    });
}

// 검색 기능
function searchFAQ() {
    const searchInput = document.getElementById('faqSearchInput').value.trim();
    const faqItems = document.querySelectorAll('.faq-item');

    faqItems.forEach(item => {
        const title = item.querySelector('.faq-question')?.innerText || "";

        if (title.includes(searchInput) || searchInput === "") {
            item.style.display = 'block';
        } else {
            item.style.display = 'none';
        }
    });
}
}
    </script>
</head>
<body>
	<jsp:include page="../Header/header.jsp"></jsp:include>
	<form action="">
		<div class="container">
			<h2>FAQ</h2>
			<hr>
			<br>
			<!-- 검색 -->
			<!-- 검색 -->
			<div class="search-bar">
				<input type="text" id="faqSearchInput" placeholder="검색어를 입력해주세요" oninput="searchFAQ()">
			</div>
			<!-- 탭 메뉴 -->
			<div class="tabs">
				<button type="button" class="tab" onclick="filterFAQ('전체')">전체</button>
				<button type="button" class="tab" onclick="filterFAQ('주문/결제')">주문/결제</button>
				<button type="button" class="tab" onclick="filterFAQ('수수료')">수수료</button>
				<button type="button" class="tab" onclick="filterFAQ('배송')">배송</button>
				<button type="button" class="tab" onclick="filterFAQ('취소/환불')">취소/환불</button>
				<button type="button" class="tab" onclick="filterFAQ('반품/교환')">반품/교환</button>
				<button type="button" class="tab" onclick="filterFAQ('기타')">기타</button>
			</div>
			<!-- 개수 -->
			<div class="faq-count">전체 1개</div>
			<!-- FAQ 항목 -->
			<c:forEach var="faq" items="${faqList}">
				<div class="faq-item" data-title="${faq.title}" 
         			 style="<c:if test='${not empty filterNo and faq.no ne filterNo}'>display:none;</c:if>">
					<div class="faq-question">${faq.title}</div>
					<div class="faq-answer">
						<img src="" alt="사진">
						<p>
							${faq.content}
							<!-- 
                        판매자의 정산 수수료는 회원등급에 따라 다르게 적용됩니다.<br><br>
                        • 골드: 4%<br>
                        • 실버: 3.5%<br>
                        • 다이아: 3%<br><br>
                        구매자는 수수료가 부과되지 않으며 무료입니다.<br><br>
                        수수료가 적용되는 시점은 결제방식에 따라 다릅니다.<br>
                        구매결제: ‘구매자가 구매하기 버튼을 누른 시점’
                     -->
						</p>
					</div>
				</div>
			</c:forEach>
		</div>
	</form>
</body>
<script>
function filterFAQ(category) {
    const faqItems = document.querySelectorAll('.faq-item');

    // ✅ 필터No가 적용된 초기상태를 풀기 위해 모든 FAQ를 다시 보여줄 준비
    faqItems.forEach(item => {
        item.style.display = 'block';
    });

    // ✅ 카테고리별 키워드 세팅
    const categoryKeywords = {
        '주문/결제': ['주문', '결제'],
        '수수료': ['수수료'],
        '배송': ['배송'],
        '취소/환불': ['취소', '환불'],
        '반품/교환': ['반품', '교환'],
        '기타': []  // 기타는 별도 처리
    };

    faqItems.forEach(item => {
        const title = item.querySelector('.faq-question')?.innerText || "";

        if (category === '전체') {
            item.style.display = 'block';
        } 
        else if (category === '기타') {
            const allKeywords = Object.values(categoryKeywords).flat().filter(word => word);
            const hasAnyKeyword = allKeywords.some(keyword => title.includes(keyword));
            item.style.display = hasAnyKeyword ? 'none' : 'block';
        }
        else {
            const keywords = categoryKeywords[category] || [];
            const matchesCategory = keywords.some(keyword => title.includes(keyword));
            item.style.display = matchesCategory ? 'block' : 'none';
        }
    });
}

function searchFAQ() {
    const searchInput = document.getElementById('faqSearchInput').value.trim();
    const faqItems = document.querySelectorAll('.faq-item');

    faqItems.forEach(item => {
        item.style.display = 'block'; // ✅ 초기화

        const title = item.querySelector('.faq-question')?.innerText || "";

        if (title.includes(searchInput) || searchInput === "") {
            item.style.display = 'block';
        } else {
            item.style.display = 'none';
        }
    });
}

</script>
</html>