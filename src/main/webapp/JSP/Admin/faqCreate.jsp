<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>FAQ 등록</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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

    .modal {
      background-color: white;
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    }

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
        <button id="btnOpenCreateModal" data-bs-target="#faqDetailModal">+ 추가하기</button>
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
      		<td><button>수정</button></td>
      	</tr>
      </c:forEach>
      
    </thead>
  </table>

      <!-- 등록/수정 모달 (하나의 폼으로 통합) -->
      <div class="modal" id="faqDetailModal" tabindex="-1" aria-labelledby="faqDetailModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
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
                    <select name="categoryNo" id="faqType">
                      <c:forEach items="${categoryList}" var="category">
                      	<option value=${category.no }>${category.name }</option>
                      </c:forEach>
                    </select>
                  </td>
                </tr>
                <tr>
                  <th>제목</th>
                  <td><input type="text" id="faqTitle" class="form-control form-control-sm"></td>
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
                    <textarea id="faqContent" rows="4" class="form-control form-control-sm"></textarea>
                  </td>
                </tr>
              </table>
            </div>
            <div class="modal-footer">
			    <button class="btn btn-primary" type="submit" id="saveFaq">저장</button>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script>
    $(document).ready(function () {
      const modalInstance = new bootstrap.Modal(document.getElementById('faqDetailModal'));
      const contextPath = "${pageContext.request.contextPath}";

      // FAQ 목록 불러오기
function loadFaqList() {
 /*    $.ajax({
        url: contextPath + '/faq?ts=' + new Date().getTime(),  // <-- 이렇게
        method: 'GET',
        dataType: 'json', 
        success: function (data) {
            console.log("정상 데이터:", data);

        	$('#faqCount').text(data.length); // FAQ 목록의 개수
            let html = ''; // 테이블 내용 초기화

            // 각 FAQ 데이터를 테이블의 row로 생성
            data.forEach(function (faq) {
                let faqStr = JSON.parse(faq);
                console.log(faqStr)
                html += `<tr>
                            <td><input type="checkbox" class="chkFaq" value="${faq.no}"></td>
                            <td>${faq.no}</td>
                            <td>${faq.categoryName ? faq.categoryName : '카테고리없음'}</td>
                            <td>${faq.title}</td>
                            <td>${faq.createdAt ? faq.createdAt.substring(0, 10) : ''}</td>
                            <td>${faq.updatedAt ? faq.updatedAt.substring(0, 10) : ''}</td>
                            <td><button type="button" class="btn btn-sm btn-warning" onclick='openEditModal(${JSON.stringify(faq)})'>수정</button></td>
                        </tr>`;
            });

            // 생성한 HTML을 tbody에 삽입
            $('#faqListArea').html(html);
        },
        error: function () {
            alert('FAQ 조회 실패');
        }
    }); */
}

      // 최초 실행 시 FAQ 목록 불러오기
      loadFaqList();

/*       // 추가하기 버튼 클릭 이벤트
      $("#btnOpenCreateModal").click(function () {
        $("#modalMode").val("create");
        $("#faqNo").val("");
        $("#faqTitle, #faqContent").val(""); // 제목과 내용을 비우고
        $("#ifile").val("");
        modalInstance.show(); // 모달 표시
      });

      // 모달 열기 전 카테고리 리스트 불러오기
      $('#faqDetailModal').on('show.bs.modal', function () {
        console.log("카테고리 데이터를 불러오기 위한 요청 시작");
        $.ajax({
          url: contextPath + '/faq',  // 카테고리 목록을 가져오는 URL
          type: 'GET',
          data: { action: 'category' },  // 카테고리 목록 요청
          success: function (data) {
            console.log(data);  // 반환되는 데이터 확인
            var categorySelect = $('#faqType');
            categorySelect.empty();  // 기존 옵션을 비우기

            // 카테고리 데이터를 받아서 동적으로 옵션 추가
            data.forEach(function (category) {
              categorySelect.append('<option value="' + category.no + '">' + category.name + '</option>');
            });
          },
          error: function () {
            alert("카테고리 목록을 불러오는 데 실패했습니다.");
          }
        });
      }); */

      // 수정 모달 열기
      $(".open-modal").click(function () {
        const faqNo = $(this).data("no");
        $("#modalMode").val("edit");

        // 서버에서 수정할 FAQ 정보 가져오기
        $.ajax({
          url: contextPath + "/faqDetail", // 수정할 FAQ 데이터 조회
          method: "get",
          data: { no: faqNo },
          success: function (data) {
            $("#faqNo").val(data.no);
            $("#faqTitle").val(data.title);
            $("#faqContent").val(data.content);

            // 기존 이미지 파일명이 있을 경우 표시
            if (data.imgUrl) {
              $("#selected-file-name").text(data.imgUrl); // 파일명이 있을 경우 텍스트로 표시
            } else {
              $("#selected-file-name").text(""); // 없으면 빈칸 처리
            }

            modalInstance.show();
          }
        });
      });

      
      
      // 폼 제출 처리
      $('#faqCreateForm').submit(function (e) {
        e.preventDefault();  // 기본 폼 제출 방지
        console.log("폼 제출 트리거됨");

        let formData = new FormData(this);
        let modalMode = $("#modalMode").val(); // 'create' or 'edit'
        
        console.log("모드:", modalMode);
        console.log("전송할 데이터:", formData);

        let url = modalMode === "create" ? contextPath + '/faqCreate' : contextPath + '/faqModify';

        $.ajax({
          url: url,
          type: 'POST',
          data: formData,
          processData: false,
          contentType: false,
          success: function (result) {
              console.log("서버 응답:", result);  // 서버 응답을 콘솔에 출력
            if (result.success) {
              alert('FAQ가 성공적으로 ' + (modalMode === "create" ? '등록' : '수정') + '되었습니다.');
              location.reload(); // 페이지 새로 고침
            } else {
              alert('FAQ ' + (modalMode === "create" ? '등록' : '수정') + '에 실패했습니다.');
            }
          },
          error: function () {
              console.log("AJAX 에러:", status, error);  // 오류 확인
            alert('서버 오류 발생');
          }
        });
      });
    });
  </script>
</body>

</html>