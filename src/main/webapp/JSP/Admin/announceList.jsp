<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>공지사항 등록</title>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/common.css"> 

</head>
<body>
	<%@ include file="header.jsp" %>
  <div class="container">
    <aside>
      <h3 style='font-size: 19px;font-weight: bold;'>FAQ</h3>
      <div class="menu inactive"><a href="faqCategory" style="color: inherit; text-decoration: none;">FAQ 분류</a></div>
      <div class="menu inactive"><a href="faqCreate" style="color: inherit; text-decoration: none;">FAQ 등록</a></div>
      <div style="height: 10px;"></div>
      <h3 style='font-size: 19px;font-weight: bold;'>공지사항</h3>
      <div class="menu active"><a href="announceList" style="color: inherit; text-decoration: none;">공지사항 등록</a></div>
    </aside>

    <main>
      <div class="breadcrumb">HOME &gt; 고객지원 &gt; 공지사항</div>

      <div class="total-count-wrap">
        <div class="total-count">총 <strong><span id="count">${fn:length(announceList) }</span></strong>건</div>
      </div>

      <div class="action-top">
        <div class="action-buttons">
          <button id="deleteAnnounceBtn">선택삭제</button>
        </div>
        <button id="openCreateModal">+ 추가하기</button>
      </div>

      <table>
        <thead>
          <tr>
            <th><input type="checkbox"  id="chkAll"></th>
            <th>번호</th>
            <th>제목</th>
            <th>등록일</th>
            <th>조회수</th>
            <th></th>     
          </tr>
        </thead>
        <tbody>
            <!-- JSTL을 사용하여 공지사항 목록을 출력 -->
            <c:forEach var="announce" items="${announceList}">
                <tr>
                    <td><input type="checkbox" name="chk" class="announceCheckbox" value="${announce.no}"></td>
                    <td>${announce.no}</td>
                    <td>${announce.title}</td>
                    <td>${announce.regDate}</td>
                    <td>${announce.viewCount}</td>
                    <td><button class="open-modal" data-no="${announce.no}">수정</button></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </main>
  </div>
  
  <!-- 공지사항 모달 (재사용 구조) -->
  <div class="modal fade" id="announceDetailModal" tabindex="-1" aria-labelledby="announceDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="announceDetailModalLabel">공지사항 등록</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
        <!-- 신규/수정 모드 구분을 위한 숨겨진 필드 -->
        <input type="hidden" id="modalMode"> <!-- 'create' or 'edit' -->
        <input type="hidden" id="announceNo"> <!-- edit 시에만 사용 -->
        <table>
          <tr>
            <th style="background-color: #e6f0f8;">제목</th>
            <td>
              <input type="text" id="announceTitle" class="form-control form-control-sm">
            </td>
				<tr>
				    <th style="background-color: #e6f0f8;">이미지선택</th>
					  <td>
					    <!-- 커스텀 파일 선택 버튼 -->
					    <label for="ifile" class="btn btn-secondary btn-sm">파일 선택</label>
					
					    <!-- 실제 파일 인풋은 숨김 -->
					    <input type="file" name="ifile" id="ifile" style="display: none;">
					
					    <!-- 선택된 파일명 or 기존 파일명 표시 -->
					    <span id="selected-file-name" style="margin-left: 10px;">첨부파일 없음</span>
					
					    <!-- 기존 파일명을 서버에 넘길 hidden 필드 -->
					    <input type="hidden" name="existingImage" id="existingImage">
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
          <button class="btn btn-primary" id="saveAnnounce">저장</button>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script>
  $(document).ready(function () { 
      const modalInstance = new bootstrap.Modal(document.getElementById('announceDetailModal'));
	  // 전체 선택
	  $("#chkAll").click(function () {
	    $("input[name='chk']").prop("checked", this.checked);
	  });
	
	  // 체크된 값 가져오기
	  function getCheckedValues(attr) {
	    let arr = [];
	    $("input[name='chk']:checked").each(function () {
	      arr.push($(this).data(attr));
	    });
	    return arr;
	  }  
    
      // [1] +추가하기 버튼 클릭 시 (신규 작성 모드)
      $("#openCreateModal").click(function () {
        $("#modalMode").val("create");
        $("#announceNo").val("");
        $("#announceTitle, #announceContent").val("");
        $("#ifile").val(""); 
        modalInstance.show();
      });
      
  	 // 파일 선택 시 선택된 파일명 표시
      $("#ifile").change(function () {
        const fileName = $(this).val().split("\\").pop();
        $("#selected-file-name").text(fileName || "첨부파일 없음");
      });
    
      // [2] 제목 클릭 시 (수정 모드)
      $(".open-modal").click(function () {
        let no = $(this).data("no");
        $("#modalMode").val("edit");

        $.ajax({
          url: "${pageContext.request.contextPath}/announceDetail", // 수정용 공지사항 조회
          method: "get",
          data: { no },
          success: function (data) {
            $("#announceNo").val(data.no);
            $("#announceTitle").val(data.title);
            $("#announceContent").val(data.content);
            
            // 기존 이미지 파일명이 있을 경우 표시
			if (data.imgUrl) {
			  $("#selected-file-name").text(data.imgUrl);
			  $("#existingImage").val(data.imgUrl);  // ✅ 서버로 보낼 값
			} else {
			  $("#selected-file-name").text("첨부파일 없음");
			  $("#existingImage").val("");
			}
            
            modalInstance.show();
          }
        });
      });

      // [3] 저장 버튼 클릭 시 (create vs edit 구분)
      $("#saveAnnounce").click(function () {
        let mode = $("#modalMode").val();
        let url = mode === "create" ? "${pageContext.request.contextPath}/announceCreate" : "${pageContext.request.contextPath}/announceUpdate";

        
        let formData = new FormData();
        formData.append("no", $("#announceNo").val());
        formData.append("title", $("#announceTitle").val());
        formData.append("content", $("#announceContent").val());
        formData.append("ifile", $("#ifile")[0].files[0]);  // 이미지 파일 추가
        
        $.ajax({
            url: url,
            method: "post",
            data: formData,
            processData: false,  // FormData는 자동으로 데이터를 처리하므로 `processData`를 `false`로 설정
            contentType: false,  // `contentType`도 `false`로 설정
            success: function (result) {
                if (result.success) {
                    // alert("저장 완료");
                    location.reload();
                } else {
                    alert("저장 실패");
                }
            },
            error: function () {
                alert("서버 오류가 발생했습니다.");
            }
        });
    });
});
    
	  $("#deleteAnnounceBtn").click(function () {
		  const noList = [];

		  // 체크된 체크박스의 번호 추출
		  $("tbody input[type='checkbox']:checked").each(function () {
		    const no = $(this).closest("tr").find("td:eq(1)").text().trim(); // 두 번째 열: 알림 번호
		    if (no) noList.push(no);
		  });

		  if (noList.length === 0) {
		    alert("삭제할 항목을 선택해주세요.");
		    return;
		  }

		  // 삭제 확인
		  if (!confirm("정말 삭제하시겠습니까?")) return;

		    $.ajax({
		        url: "${pageContext.request.contextPath}/announceDelete",
		        method: "post",
		        traditional: true, // 배열 전송 방식을 설정
		        data: { "no[]": noList }, // 서버는 "no[]" 파라미터로 받음
		        success: function (result) {
		            if (result.success) {
		                // alert("삭제 완료");
		                location.reload(); // 페이지 새로고침
		            } else {
		                alert("삭제 실패");
		            }
		        },
		        error: function () {
		            alert("서버 오류가 발생했습니다.");
		        }
		    });
		});
	  
 
	</script>

</body>
</html>