<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<head>
  <meta charset="UTF-8">
  <title>FAQ 등록</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/common.css"> 
  <style>
    .action-top {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-top: 10px;
      margin-bottom: 10px;
    }

    .action-buttons button {
      background-color: #26c6da;
      color: white;
      padding: 4px 12px;
      border: none;
      border-radius: 3px;
      font-size: 13px;
      cursor: pointer;
      margin-right: 4px;
    }

    .action-buttons button:last-child {
      margin-right: 0;
    }

    .total-count-wrap {
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 1px solid #ccc;
      padding-bottom: 6px;
      margin-bottom: 10px;
    }

    .total-count {
      font-weight: bold;
    }
  </style>
</head>
<body>
	<%@ include file="header.jsp" %>
  <div class="container">
    <aside>
      <h3>FAQ</h3>
      <div class="menu inactive">FAQ 분류</div>
      <div class="menu active">FAQ 등록</div>
      <div style="height: 10px;"></div>
      <h3>공지사항</h3>
      <div class="menu inactive">공지사항 등록</div>
    </aside>

    <main>
      <div class="breadcrumb">HOME &gt; 고객지원 &gt; FAQ</div>

      <div class="total-count-wrap">
        <div class="total-count">전체 <strong>1</strong>건</div>
      </div>

      <div class="action-top">
        <div class="action-buttons">
          <button>선택삭제</button>
        </div>
        <button>+ 추가하기</button>
      </div>

      <table>
        <thead>
          <tr>
            <th><input type="checkbox"></th>
            <th>번호</th>
            <th>분류명</th>
            <th>제목</th>
            <th>등록일</th>
            <th>최종수정일</th>
            <th> </th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><input type="checkbox"></td>
            <td>1</td>
            <td>주문/결제</td>
            <td>상품 등록 이용가이드</td>
            <td>2025-04-03</td>
            <td>2025-04-03</td>
            <td><button>수정하기</button></td>
          </tr>
        </tbody>
      </table>
    </main>
  </div>
  
  <!-- 모달 -->
<div class="modal-overlay" id="faqModal">
  <div class="modal">
    <div class="modal-header">
      <span id="modalTitle">FAQ 등록</span>
      <span class="close-btn" onclick="closeModal()">×</span>
    </div>
    <table>
      <tr>
        <th>유형</th>
        <td>
          <select id="faqType">
            <option>주문/결제</option>
            <option>배송</option>
            <option>취소/환불</option>
            <option>반품/교환</option>
            <option>기타</option>
          </select>
        </td>
      </tr>
      <tr>
        <th>제목</th>
        <td><input type="text" id="faqTitleInput" placeholder="FAQ 제목 입력"></td>
      </tr>
      <tr>
        <th>이미지선택</th>
        <td>
          <button type="button">+ 파일선택</button>
          <span class="file-label">선택된 파일 없음</span>
        </td>
      </tr>
      <tr>
        <th>내용</th>
        <td><textarea id="faqContentInput" placeholder="FAQ 상세 내용을 입력하세요."></textarea></td>
      </tr>
    </table>
    <div class="modal-footer">
      <button id="submitBtn" onclick="handleSubmit()">✔ 저장</button>
    </div>
  </div>
</div>

	<script>
	  let isEditMode = false;
	  let editingFaqId = null;
	
	  // 등록 모드로 열기
	  function openCreateModal() {
	    isEditMode = false;
	    editingFaqId = null;
	    document.getElementById('modalTitle').textContent = "FAQ 등록";
	    document.getElementById('faqTitleInput').value = "";
	    document.getElementById('faqContentInput').value = "";
	    document.getElementById('submitBtn').textContent = "✔ 저장";
	    document.getElementById('faqModal').style.display = 'flex';
	  }
	
	  // 수정 모드로 열기 (데이터 전달 받음)
	  function openEditModal(faq) {
	    isEditMode = true;
	    editingFaqId = faq.id;
	    document.getElementById('modalTitle').textContent = "FAQ 수정";
	    document.getElementById('faqType').value = faq.type;
	    document.getElementById('faqTitleInput').value = faq.title;
	    document.getElementById('faqContentInput').value = faq.content;
	    document.getElementById('submitBtn').textContent = "✔ 수정";
	    document.getElementById('faqModal').style.display = 'flex';
	  }
	
	  function closeModal() {
	    document.getElementById('faqModal').style.display = 'none';
	  }
	
	  function handleSubmit() {
	    const title = document.getElementById('faqTitleInput').value.trim();
	    const content = document.getElementById('faqContentInput').value.trim();
	    const type = document.getElementById('faqType').value;
	
	    if (!title || !content) {
	      alert("제목과 내용을 모두 입력해주세요.");
	      return;
	    }
	
	    if (isEditMode) {
	      console.log("수정 요청:", { id: editingFaqId, type, title, content });
	      // TODO: AJAX로 수정 요청
	    } else {
	      console.log("등록 요청:", { type, title, content });
	      // TODO: AJAX로 등록 요청
	    }
	
	    closeModal();
	  }
	

	</script>
  
  
</body>
</html>