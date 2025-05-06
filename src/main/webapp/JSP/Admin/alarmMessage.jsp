<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

  </style>
</head>
<body>
	<%@ include file="header.jsp" %>
  <div class="container">
    <aside>
      <h3 style='font-size: 19px;font-weight: bold;'>알림관리</h3>
      <div class="menu active"><a href="alarmMessage" style="color: inherit; text-decoration: none;">알림등록</a></div>
    </aside>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script> 
    <main>
      <div class="breadcrumb">HOME &gt; 알림관리 &gt; 알림등록</div>

      <div class="total-count-wrap">
        <div class="total-count">총 <strong><span id="count">${fn:length(alarmList) }</span></strong>건</div>
      </div>

      <div class="action-top">
        <div class="action-buttons">
          <button id="deleteAlarmBtn">알림삭제</button>
        </div>
		<button class="btn btn-success" id="openCreateModal">+ 추가하기</button>
      </div>

      <table>
        <thead>
          <tr>
            <th><input type="checkbox"  id="chkAll" /></th>
            <th>번호</th>
            <th>유형</th>
            <th>메시지</th>
            <th>비고</th>
          </tr>
        </thead>
        <tbody>
		    <c:forEach var="alarm" items="${alarmList}">
		      <tr>
		        <td><input type="checkbox"  name="chk"/></td>
		        <td>${alarm.no}</td>
		        <td>${alarm.type}</td>
		        <td>
		          <a href="#" class="open-modal" data-no="${alarm.no}" data-bs-toggle="modal" data-bs-target="#alarmDetailModal">
		        ${alarm.title}
		          </a>
		        </td>
		        <td>${alarm.remark}</td>
		      </tr>
		    </c:forEach>
		  </tbody>
		</table>
      <div class="info-note">
        ※메시지 선택 시, 타이틀 및 콘텐츠 내용 확인 가능
      </div>
    </main>
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
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
	document.addEventListener("DOMContentLoaded", function () {	
    const modalInstance = new bootstrap.Modal(document.getElementById('alarmDetailModal'));
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
	    $("#alarmNo").val("");
	    $("#alarmType, #alarmTitle, #alarmContent, #alarmRemark").val("");
	    $("#alarmType").prop("readonly", false); // 유형 입력 가능
	    modalInstance.show();
	  });
	
	  // [2] 제목 클릭 시 (수정 모드)
	  $(".open-modal").click(function () {
	    let no = $(this).data("no");
	    $("#modalMode").val("edit");
	
	    $.ajax({
	      url: "${pageContext.request.contextPath}/alarmMessageDetail",
	      method: "get",
	      data: { no },
	      success: function (data) {
	        $("#alarmNo").val(data.no);
	        $("#alarmType").val(data.type).prop("readonly", true); // 수정불가
	        $("#alarmTitle").val(data.title);
	        $("#alarmContent").val(data.content);
	        $("#alarmRemark").val(data.remark);
	        modalInstance.show();
	      }
	    });
	  });
	
	  // [3] 저장 버튼 클릭 시 (create vs edit 구분)
	  $("#saveAlarm").click(function () {
	    let mode = $("#modalMode").val();
	    let url = mode === "create" ? "${pageContext.request.contextPath}/alarmMessageCreate" : "${pageContext.request.contextPath}/alarmMessageUpdate";
	
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
	          //alert("저장 완료");
	          location.reload();
	        } else {
	          alert("저장 실패");
	        }
	      }
	    });
	  });
	  
	  $("#deleteAlarmBtn").click(function () {
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

		  // Ajax로 삭제 요청
		  $.ajax({
		    url: "${pageContext.request.contextPath}/alarmMessageDelete",
		    method: "post",
		    traditional: true, // 배열 전송 방식 설정
		    data: { no: noList }, // 서버는 "no" 파라미터로 받음
		    success: function (result) {
		      if (result === "true") {
		        //alert("삭제 완료");
		        location.reload();
		      } else {
		        alert("삭제 실패");
		      }
		    },
		    error: function () {
		      alert("서버 오류가 발생했습니다.");
		    }
		  });
		});
	  
	});  
	</script>



</body>
</html>
