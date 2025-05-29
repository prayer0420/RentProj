<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/service/serviceFAQ.css">
</head>
<body>
<jsp:include page="../Header/header.jsp"></jsp:include>
<form action="">
  <div class="container">
    <h2>FAQ</h2>
    <hr><br>

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


    <!-- FAQ 항목 -->
    <c:forEach var="faq" items="${faqList}">
      <div class="faq-item" data-no="${faq.no}" data-title="${faq.title}">
        <div class="faq-question">${faq.title}</div>
        <div class="faq-answer">
          <p>${faq.content}</p>
        </div>
      </div>
    </c:forEach>
  </div>
</form>

<script>
const filterNo = '${filterNo}' === 'null' ? null : '${filterNo}';
const searchKeyword = '${searchKeyword}' === 'null' ? null : '${searchKeyword}';

const categoryKeywords = {
  '주문/결제': ['주문', '결제'],
  '수수료': ['수수료'],
  '배송': ['배송'],
  '취소/환불': ['취소', '환불'],
  '반품/교환': ['반품', '교환'],
  '기타': []
};

// FAQ 펼치기 기능 + 초기 필터링
document.addEventListener('DOMContentLoaded', function () {
  const faqItems = document.querySelectorAll('.faq-item');

  // 펼치기 토글
  document.querySelectorAll('.faq-question').forEach(q => {
    q.addEventListener('click', () => {
      const item = q.closest('.faq-item');
      item.classList.toggle('active');
    });
  });

  // filterNo 적용 시: 특정 번호만 표시
  if (filterNo !== null && filterNo.trim() !== '') {
    faqItems.forEach(item => {
      const itemNo = item.getAttribute('data-no');
      item.style.display = (itemNo === filterNo) ? 'block' : 'none';
    });
  } else if (searchKeyword !== null && searchKeyword.trim() !== '') {
    faqItems.forEach(item => {
      const title = item.querySelector('.faq-question')?.innerText || "";
      item.style.display = title.includes(searchKeyword) ? 'block' : 'none';
    });
  } else {
    // 아무 필터도 없는 경우 → 전체 보여주기
    faqItems.forEach(item => {
      item.style.display = 'block';
    });
  }

  updateFAQCount();
});

function filterFAQ(category) {
  const faqItems = document.querySelectorAll('.faq-item');

  faqItems.forEach(item => {
    const title = item.querySelector('.faq-question')?.innerText || "";

    if (category === '전체') {
      item.style.display = 'block';
    } else if (category === '기타') {
      const allKeywords = Object.values(categoryKeywords).flat().filter(k => k);
      const hasAnyKeyword = allKeywords.some(keyword => title.includes(keyword));
      item.style.display = hasAnyKeyword ? 'none' : 'block';
    } else {
      const keywords = categoryKeywords[category] || [];
      const match = keywords.some(keyword => title.includes(keyword));
      item.style.display = match ? 'block' : 'none';
    }
  });

  updateFAQCount();
}

function searchFAQ() {
  const keyword = document.getElementById('faqSearchInput').value.trim();
  const faqItems = document.querySelectorAll('.faq-item');

  faqItems.forEach(item => {
    const title = item.querySelector('.faq-question')?.innerText || "";
    item.style.display = (keyword === '' || title.includes(keyword)) ? 'block' : 'none';
  });

  updateFAQCount();
}

function updateFAQCount() {
  const faqItems = document.querySelectorAll('.faq-item');
  let visibleCount = 0;

  faqItems.forEach(item => {
    const style = window.getComputedStyle(item);
    if (style.display !== 'none') visibleCount++;
  });

  const countBox = document.getElementById('faqCount');
  if (countBox) {
    countBox.textContent = `전체 ${visibleCount}개`;
  }
}
</script>
</body>
</html>
