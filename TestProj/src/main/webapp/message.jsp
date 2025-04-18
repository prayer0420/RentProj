<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지함</title>
<link rel="stylesheet" href="css/message.css" />
</head>
<body>
<div class="mypage-container">
  <!-- 사이드바 -->
  <aside class="mypage-sidebar">
    <div class="profile">
      <img src="img/profile_tiger.png" alt="프로필" class="profile-img" />
      <div class="profile-info">
        <strong>닉네임 님</strong>
        <span class="grade">회원등급</span>
        <span class="summary">총 거래 수: 25회</span>
      </div>
    </div>

    <ul class="menu">
      <li><a href="#">구매관리</a></li>
      <li><a href="#">판매관리</a></li>
      <li><a href="#">광고관리</a></li>
      <li><a href="#">나의 리뷰</a></li>
      <li><a href="#">나의 신고목록</a></li>
      <li class="active"><a href="#">쪽지함</a></li>
      <li><a href="#">개인정보 수정</a></li>
      <li><a href="#">배송지 관리</a></li>
    </ul>
  </aside>

  <!-- 본문 -->
  <section class="mypage-main">
    <div class="message-tabs">
      <button class="active" onclick="showTab('buy')">구매 쪽지함</button>
      <button onclick="showTab('sell')">판매 쪽지함</button>
    </div>

    <button class="message-delete">삭제</button>

    <!-- 구매 쪽지함 -->
    <div id="message-buy" class="message-box">
      <table class="message-table">
        <thead>
          <tr>
            <th><input type="checkbox" /></th>
            <th>받는 사람</th>
            <th>상품명</th>
            <th>내용</th>
            <th>보낸 시간</th>
            <th>비고</th>
          </tr>
        </thead>
        <tbody>
          <tr class="message-row" onclick="toggleMessageDetail(this)">
            <td><input type="checkbox" /></td>
            <td><strong>애옹이</strong></td>
            <td>갤럭시20 프로 256gb</td>
            <td>독산역 가능하신가요?</td>
            <td>2025-04-02 13:05</td>
            <td>판매 <span class="toggle-icon">▼</span></td>
          </tr>
          <tr class="message-detail" style="display: none;">
            <td colspan="6">
              <div class="message-detail-inner">
                <strong>상세내용</strong><br />
                독산역 가능하신가요? 독산역 가능하신가요? 네네네?네네네?
                <br /><br />
                <button onclick="openMessageModal()" class="btn-reply">답장</button>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- 판매 쪽지함 -->
    <div id="message-sell" class="message-box" style="display: none;">
      <table class="message-table">
        <thead>
          <tr>
            <th><input type="checkbox" /></th>
            <th>보낸 사람</th>
            <th>상품명</th>
            <th>내용</th>
            <th>받은 시간</th>
            <th>비고</th>
          </tr>
        </thead>
        <tbody>
          <tr class="message-row" onclick="toggleMessageDetail(this)">
            <td><input type="checkbox" /></td>
            <td><strong>멍멍이</strong></td>
            <td>갤럭시20 프로 256gb</td>
            <td>택배거래만 합니다</td>
            <td>2025-04-02 13:07</td>
            <td>답장 <span class="toggle-icon">▼</span></td>
          </tr>
          <tr class="message-detail" style="display: none;">
            <td colspan="6">
              <div class="message-detail-inner">
                <strong>상세내용</strong><br />
                택배거래만 합니다. 택배거래만 합니다. 택배만요 네네.
                <br /><br />
                <button onclick="openMessageModal()" class="btn-reply">답장</button>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </section>
</div>

<jsp:include page="messageModal.jsp"></jsp:include>


<script>
  function showTab(tab) {
    document.querySelectorAll('.message-tabs button').forEach(btn => btn.classList.remove('active'));
    document.querySelectorAll('.message-box').forEach(box => box.style.display = 'none');

    if (tab === 'buy') {
      document.querySelector('.message-tabs button:nth-child(1)').classList.add('active');
      document.getElementById('message-buy').style.display = 'block';
    } else {
      document.querySelector('.message-tabs button:nth-child(2)').classList.add('active');
      document.getElementById('message-sell').style.display = 'block';
    }
  }

  function toggleMessageDetail(row) {
    const detailRow = row.nextElementSibling;
    const icon = row.querySelector('.toggle-icon');
    const isOpen = detailRow.style.display === 'table-row';

    document.querySelectorAll('.message-detail').forEach(d => d.style.display = 'none');
    document.querySelectorAll('.message-row').forEach(r => r.classList.remove('active'));
    document.querySelectorAll('.toggle-icon').forEach(i => i.textContent = '▼');

    if (!isOpen) {
      detailRow.style.display = 'table-row';
      row.classList.add('active');
      icon.textContent = '▲';
    }
  }

  function openMessageModal() {
    document.getElementById('messageModal').style.display = 'flex';
  }

  function closeMessageModal() {
    document.getElementById('messageModal').style.display = 'none';
  }
</script>
</body>
</html>
