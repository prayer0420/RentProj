<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>알림 등록</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/common.css"> 
  <style>
    .total-count-wrap {
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 1px solid #ccc;
      padding-bottom: 6px;
      margin-bottom: 10px;
    }

    .action-top {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 10px;
    }

    .action-buttons button,
    .action-top > button {
      background-color: #26c6da;
      color: white;
      padding: 4px 12px;
      border: none;
      border-radius: 3px;
      font-size: 13px;
      cursor: pointer;
      margin-right: 4px;
    }

    .action-buttons button:last-child,
    .action-top > button:last-child {
      margin-right: 0;
    }

    .info-note {
      font-size: 12px;
      color: #555;
      margin-top: 10px;
    }
  </style>
</head>
<body>
	<%@ include file="header.jsp" %>
  <div class="container">
    <aside>
      <h3>알림관리</h3>
      <div class="menu active">알림등록</div>
    </aside>

    <main>
      <div class="breadcrumb">HOME &gt; 알림관리 &gt; 알림등록</div>

      <div class="total-count-wrap">
        <div class="total-count">총 <strong>3</strong>건</div>
      </div>

      <div class="action-top">
        <div class="action-buttons">
          <button>알림삭제</button>
        </div>
		<button class="btn btn-success" id="openCreateModal">+ 추가하기</button>
      </div>

      <table>
        <thead>
          <tr>
            <th><input type="checkbox" /></th>
            <th>번호</th>
            <th>유형</th>
            <th>메시지</th>
            <th>비고</th>
          </tr>
        </thead>
        <tbody>
          <tr>
		    <c:forEach var="alarm" items="${alarmList}">
		      <tr>
		        <td><input type="checkbox" /></td>
		        <td>${alarm.no}</td>
		        <td>
		          <a href="#" class="open-modal" data-no="${alarm.no}" data-bs-toggle="modal" data-bs-target="#alarmDetailModal">
		            ${alarm.title}
		          </a>
		        </td>
		        <td>${alarm.type}</td>
		      </tr>
		    </c:forEach>
		  </tbody>
		</table>
      <div class="info-note">
        * 메시지내용 선택 시 상세 화면 이동
      </div>
    </main>
  </div>
  
  <div class="container mt-5">
    <!-- 모달 열기 버튼 -->
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#alarmDetailModal">
      알림 상세 보기
    </button>
  </div>

  <!-- 알림 상세 모달 (재사용 구조) -->
  <div class="modal fade" id="alarmDetailModal" tabindex="-1" aria-labelledby="alarmDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="alarmDetailModalLabel">알림 상세</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
        <!-- 신규/수정 모드 구분을 위한 숨겨진 필드 -->
        <input type="hidden" id="modalMode"> <!-- 'create' or 'edit' -->
  		<input type="hidden" id="alarmNo"> <!-- edit 시에만 사용 -->
  		
			  <!-- 스타일 적용된 테이블 구조 -->
			  <table class="table table-bordered align-middle" style="width:100%;">
			    <tr>
			      <th style="width: 20%; background-color: #e6f0f8;">알림유형</th>
			      <td>
			        <input type="text" id="alarmType" class="form-control form-control-sm">
			      </td>
			    </tr>
			    <tr>
			      <th style="background-color: #e6f0f8;">제목</th>
			      <td>
			        <input type="text" id="alarmTitle" class="form-control form-control-sm">
			      </td>
			    </tr>
			    <tr>
			      <th style="background-color: #e6f0f8; vertical-align: top;">내용</th>
			      <td style="background-color: #f0fafa;">
			        <textarea id="alarmContent" rows="4" class="form-control form-control-sm"></textarea>
			      </td>
			    </tr>
			    <tr>
			      <th style="background-color: #e6f0f8;">비고</th>
			      <td>
			        <input type="text" id="alarmRemark" class="form-control form-control-sm">
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
	
	<script>
	  // [1] +추가하기 버튼 클릭 시 (신규 작성 모드)
	  $("#openCreateModal").click(function () {
	    $("#modalMode").val("create");
	    $("#alarmNo").val("");
	    $("#alarmType, #alarmTitle, #alarmContent, #alarmRemark").val("");
	    $("#alarmType").prop("readonly", false); // 유형 입력 가능
	    $("#alarmDetailModal").modal("show");
	  });
	
	  // [2] 제목 클릭 시 (수정 모드)
	  $(".open-modal").click(function () {
	    let no = $(this).data("no");
	    $("#modalMode").val("edit");
	
	    $.ajax({
	      url: "/alarmMessageDetail",
	      method: "get",
	      data: { no },
	      success: function (data) {
	        $("#alarmNo").val(data.no);
	        $("#alarmType").val(data.type).prop("readonly", true); // 수정불가
	        $("#alarmTitle").val(data.title);
	        $("#alarmContent").val(data.content);
	        $("#alarmRemark").val(data.remark);
	        $("#alarmDetailModal").modal("show");
	      }
	    });
	  });
	
	  // [3] 저장 버튼 클릭 시 (create vs edit 구분)
	  $("#saveAlarm").click(function () {
	    let mode = $("#modalMode").val();
	    let url = mode === "create" ? "/alarmMessageCreate" : "/alarmMessageUpdate";
	
	    $.ajax({
	      url: url,
	      method: "post",
	      data: {
	        no: $("#alarmNo").val(),
	        type: $("#alarmType").val(),
	        title: $("#alarmTitle").val(),
	        content: $("#alarmContent").val(),
	        remark: $("#alarmRemark").val()
	      },
	      success: function (result) {
	        if (result === "true") {
	          alert("저장 완료");
	          location.reload();
	        } else {
	          alert("저장 실패");
	        }
	      }
	    });
	  });
	</script>


  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
