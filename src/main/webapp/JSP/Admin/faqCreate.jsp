<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>FAQ 등록</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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

     .modal-overlay {
      display: block;
    }

/*     .modal {
      background-color: white;
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    }
 */
    .modal-body table {
      width: 100%;
      border-spacing: 0;
      margin-bottom: 20px;
    }

    .modal-body th,
    .modal-body td {
      padding: 10px;
      vertical-align: middle;
    }

    .modal-body th {
      background-color: #e6f0f8;
      width: 120px;
    }

    .modal-body td input,
    .modal-body td select,
    .modal-body td textarea {
      width: 100%;
      padding: 8px;
      margin-top: 5px;
    } 
  </style>

</head>
<body>
  <%@ include file="header.jsp" %>
  <div class="container">
    <aside>
      <h3>FAQ</h3>
      <div class="menu inactive"><a href="faqCategory" style="color: inherit; text-decoration: none;">FAQ 분류</a></div>
      <div class="menu active"><a href="faqCreate" style="color: inherit; text-decoration: none;">FAQ 등록</a></div>
      <div style="height: 10px;"></div>
      <h3>공지사항</h3>
      <div class="menu inactive"><a href="announceList" style="color: inherit; text-decoration: none;">공지사항 등록</a></div>
    </aside>

    <main>
      <div class="breadcrumb">HOME &gt; 고객지원 &gt; FAQ</div>

      <div class="total-count-wrap">
        <div class="total-count">전체 <strong id="faqCount">0</strong>건</div>
      </div>

      <div class="action-top">
        <div class="action-buttons">
          <button id="btnDeleteSelected">선택삭제</button>
        </div>
        <button id="btnOpenCreateModal" data-bs-toggle="modal" data-bs-target="#faqDetailModal">+ 추가하기</button>
      </div>

  <table>
    <thead>
      <tr>
        <th><input type="checkbox" id="chkAll" /></th>
        <th>번호</th>
        <th>유형</th>
        <th>제목</th>
        <th>등록일</th>
        <th>수정일</th>
        <th>수정</th>
      </tr>
      <c:forEach items="${faqList }" var="faq">
      	<tr>
      		<td><input type="checkbox" class="delCheck" /></td>
      		<td>${faq.no }</td>
      		<td>${faq.categoryName }</td>
      		<td>${faq.title }</td>
      		<td>${faq.createdAt }</td>
      		<td>${faq.updatedAt }</td>
      		<td><button type="button" data-bs-toggle="modal" data-bs-target="#faqDetailModal" data-faq-no="${faq.no}">수정</button></td>
      	</tr>
      </c:forEach>
      
    </thead>
  </table>

      <!-- 등록/수정 모달 (하나의 폼으로 통합) -->
      <div class="modal" id="faqDetailModal" tabindex="-1" aria-labelledby="faqDetailModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <form action="${pageContext.request.contextPath}/faqCreate" method="post" enctype="multipart/form-data">
          <div class="modal-content">            
          
            <div class="modal-header">
              <h5 class="modal-title" id="faqDetailModalLabel">FAQ 등록</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <input type="hidden" id="modalMode"> <!-- 'create' or 'edit' -->
              <input type="hidden" id="faqNo"> <!-- edit 시에만 사용 -->
              <table>
                <tr>
                  <th style="background-color: #e6f0f8;">유형</th>
                  <td>
                    <select name="categoryNo" id="faqType" name="categoryNo">
                      <c:forEach items="${categoryList}" var="category">
                      	<option value=${category.no }>${category.name }</option>
                      </c:forEach>
                    </select>
                  </td>
                </tr>
                <tr>
                  <th>제목</th>
                  <td><input type="text" id="faqTitle" class="form-control form-control-sm" name="title"></td>
                </tr>
                <tr>
                  <th style="background-color: #e6f0f8;">이미지선택</th>
                  <td>
                    <input type="file" name="ifile" id="ifile" class="form-control form-control-sm">
                    <c:if test="${not empty faq.imgUrl}">
                      <div id="file-name-display" style="margin-top: 10px;">
                        이미지 파일: <span id="selected-file-name">${faq.imgUrl}</span>
                      </div>
                    </c:if>
                  </td>
                </tr>
                <tr>
                  <th style="background-color: #e6f0f8; vertical-align: top;">내용</th>
                  <td style="background-color: #f0fafa;">
                    <textarea id="faqContent" rows="4" class="form-control form-control-sm" name="content"></textarea>
                  </td>
                </tr>
              </table>
            </div>
            <div class="modal-footer">
			    <button class="btn btn-primary" id="saveFaq">저장</button>
            </div>
          </div>
          </form>
          
        </div>
      </div>
    </main>
  </div>

  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script>
  	$("#saveFaq").click(function() {
  		
  	})
  </script>
</body>

</html>