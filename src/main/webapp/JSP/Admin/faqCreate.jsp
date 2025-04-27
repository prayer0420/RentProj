<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
      
	.modal-overlay {
	  display: block;  /* 모달을 보이게 하는 CSS */
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
	
	.modal-body th, .modal-body td {
	    padding: 10px;
	    vertical-align: middle;
	}
	
	.modal-body th {
	    background-color: #e6f0f8;
	    width: 120px;
	}
	
	.modal-body td input, .modal-body td select, .modal-body td textarea {
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
      <div class="menu inactive">FAQ 분류</div>
      <div class="menu active">FAQ 등록</div>
      <div style="height: 10px;"></div>
      <h3>공지사항</h3>
      <div class="menu inactive">공지사항 등록</div>
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
      <button id="btnOpenCreateModal">+ 추가하기</button>
    </div>
	<table>
        <thead>
          <tr>
            <th><input type="checkbox"  id="chkAll" /></th>
            <th>번호</th>
            <th>유형</th>
            <th>제목</th>
            <th>등록일</th>
            <th>수정일</th>
            <th>수정</th>
          </tr>
        </thead>
        <tbody>
		    <c:forEach var="faq" items="${faqList}">
		      <tr>
		        <td><input type="checkbox"  name="chk"/></td>
		        <td>${faq.no}</td>
		        <td>${faq.categoryName}</td>
		        <td>${faq.title}</td>
		        <td>${faq.createdAt}</td>
		        <td>${faq.updatedAt}</td>
                <td><button class="open-modal" data-no="${faq.no}">수정</button></td>
		      </tr>
		    </c:forEach>
		  </tbody>
		</table>
  	</main>
	</div>

	<!-- 등록/수정 모달 -->
  <div class="modal fade" id="faqDetailModal" tabindex="-1" aria-labelledby="faqDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="announceDetailModalLabel">FAQ 등록</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
		  <!-- <form id="faqForm" enctype="multipart/form-data">    -->     
        <div class="modal-body">
        <!-- 신규/수정 모드 구분을 위한 숨겨진 필드 -->
        <input type="hidden" id="modalMode"> <!-- 'create' or 'edit' -->
        <input type="hidden" id="announceNo"> <!-- edit 시에만 사용 -->
	      <table>
	        <tr>
            <th style="background-color: #e6f0f8;">유형</th>
	          <td>
	            <select id="faqType" name="categoryNo">
	              <!-- 카테고리 옵션은 ajax로 동적 생성 -->
	            </select>
	          </td>
	        </tr>
	        <tr>
	          <th>제목</th>
	         <input type="text" id="faqTitle" class="form-control form-control-sm"></td>
	        </tr>
				<tr>
				    <th style="background-color: #e6f0f8;">이미지선택</th>
				    <td>
				        <!-- 파일 선택 input 필드 -->
				        <input type="file" name="ifile" id="ifile" class="form-control form-control-sm">
				        
				        <!-- 기존 파일명이 있을 경우 -->
				        <c:if test="${not empty faq.imgUrl}">
				            <!-- 선택된 파일명을 보여주는 텍스트 필드 -->
				            <div id="file-name-display" style="margin-top: 10px;">
				                이미지 파일: <span id="selected-file-name">${faq.imgUrl}</span>
				            </div>
				        </c:if>
				    </td>
				</tr>
            <th style="background-color: #e6f0f8; vertical-align: top;">내용</th>
            <td style="background-color: #f0fafa;">
              <textarea id="announceContent" rows="4" class="form-control form-control-sm"></textarea>
            </td>
          </tr>
        </table>
        </div>
        <div class="modal-footer">
        	<button class="btn btn-primary" id="saveAlarm">저장</button>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script>
	$(document).ready(function () { 
	    const modalInstance = new bootstrap.Modal(document.getElementById('faqDetailModal'));
	    const contextPath = "${pageContext.request.contextPath}";

	    // FAQ 목록 불러오기
	    function loadFaqList() {
	        $.ajax({
	            url: contextPath + '/faq',
	            method: 'GET',
	            success: function(data) {
	                $('#faqCount').text(data.length);  // FAQ 목록의 개수
	                let html = '<table class="table table-bordered"><thead><tr><th><input type="checkbox" id="selectAll"></th><th>번호</th><th>분류명</th><th>제목</th><th>등록일</th><th>수정</th></tr></thead><tbody>';
	                
	                data.forEach(function(faq) {
	                    html += `<tr>
	                        <td><input type="checkbox" class="chkFaq" value="${faq.no}"></td>
	                        <td>${faq.no}</td>
	                        <td>${faq.categoryName || '카테고리없음'}</td>
	                        <td>${faq.title}</td>
	                        <td>${faq.createdAt ? faq.createdAt.substring(0, 10) : ''}</td>
	                        <td>${faq.updatedAt ? faq.updatedAt.substring(0, 10) : ''}</td>
	                        <td><button type="button" class="btn btn-sm btn-warning" onclick='openEditModal(${JSON.stringify(faq)})'>수정</button></td>
	                    </tr>`;
	                });
	                html += '</tbody></table>';
	                $('#faqListArea').html(html);  // 데이터가 들어갈 부분
	            },
	            error: function() {
	                alert('FAQ 조회 실패');
	            }
	        });
	    }

	    // 최초 실행 시 FAQ 목록 불러오기
	    loadFaqList();

	    // 추가하기 버튼 클릭 이벤트
	    $("#btnOpenCreateModal").click(function() {
	        $("#modalMode").val("create");
	        $("#announceNo").val("");
	        $("#faqTitle, #announceContent").val(""); // 제목과 내용을 비우고
	        $("#ifile").val(""); 
	        modalInstance.show();  // 모달 표시
	    });

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
	                $("#announceNo").val(data.no);
	                $("#faqTitle").val(data.title);
	                $("#announceContent").val(data.content);

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

	    // 모달 열기 전 카테고리 리스트 불러오기
	    $('#faqDetailModal').on('show.bs.modal', function() {
	        $.ajax({
	            url: contextPath + '/faq',  // 카테고리 목록을 가져오는 URL
	            type: 'GET',
	            data: { action: 'category' },  // 카테고리 목록 요청
	            success: function(data) {
	                var categorySelect = $('#faqType');
	                categorySelect.empty();  // 기존 옵션을 비우기

	                // 카테고리 데이터를 받아서 동적으로 옵션 추가
	                data.forEach(function(category) {
	                    categorySelect.append('<option value="' + category.no + '">' + category.name + '</option>');
	                });
	            },
	            error: function() {
	                alert("카테고리 목록을 불러오는 데 실패했습니다.");
	            }
	        });
	    });
	    
	    // 선택 삭제 버튼 클릭 이벤트
	    $("#btnDeleteSelected").click(function () {
	        const noList = [];

	        $("tbody input[type='checkbox']:checked").each(function () {
	            const no = $(this).closest("tr").find("td:eq(1)").text().trim(); // 번호 가져오기
	            noList.push(no);
	        });

	        if (noList.length === 0) {
	            alert("삭제할 항목을 선택해주세요.");
	            return;
	        }

	        if (!confirm("정말 삭제하시겠습니까?")) return;

	        $.ajax({
	            url: contextPath + "/faqDelete",
	            method: "post",
	            traditional: true,
	            data: { "no[]": noList },
	            success: function (result) {
	                if (result.success) {
	                    alert("삭제 완료");
	                    location.reload(); // 페이지 새로고침
	                } else {
	                    alert("삭제 실패");
	                }
	            },
	            error: function () {
	                alert("서버 오류 발생");
	            }
	        });
	    });

	    // 전체 선택
	    $(document).on('click', '#chkAll', function() {
	        $('.chkFaq').prop('checked', this.checked);
	    });
	});
</script>
		
		
		</body>
		</html>