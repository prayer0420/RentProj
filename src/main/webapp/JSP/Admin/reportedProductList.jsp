<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>신고상품조회</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/common.css">
<!--     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> --> 
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>

    .search-box label,
    .search-box input,
    .search-box select,
    .search-box button {
      margin-right: 6px;
      font-size: 13px;
    }
    .search-box input[type="text"] {
      padding: 3px 6px;
      width: 120px; /* 날짜 포맷에 맞게 줄임 */
    }
    .search-box .radio-group {
      display: inline-block;
      margin: 0 10px;
    }
    .tab {
      margin-bottom: 10px;
    }
    .tab button {
      padding: 6px 12px;
      border: 1px solid #ccc;
      background: #f0f0f0;
      cursor: pointer;
      margin-right: 5px;
    }
    .tab button.active {
      background: #26c6da;
      color: white;
    }
    .total-count {
      font-size: 14px;
      margin: 10px 0;
    }
    .report-table {
      width: 100%;
      border-collapse: collapse;
    }
    .report-table th, .report-table td {
      border: 1px solid #ccc;
      padding: 6px;
      font-size: 13px;
      text-align: center;
    }
    .report-table th {
      background: #e0e6ed;
    }

    .badge {
      background: red;
      color: white;
      border-radius: 50%;
      padding: 0 6px;
      font-size: 12px;
      margin-left: 5px;
    }
  </style>
</head>
<script>
  document.addEventListener('DOMContentLoaded', function () {
    const rowCount = document.querySelectorAll('.report-table tbody tr').length;
    document.getElementById('reportCount').textContent = rowCount;
  });
</script>

<body>
	<%@ include file="header.jsp" %>
<div class="container">
  <aside>
    <h3>상품관리</h3>
    <div class="menu active"><a href="reportedProductList" style="color: inherit; text-decoration: none;">신고상품조회 <span class="badge">1</span></a></div>
  </aside>

  <main>
    <div class="breadcrumb">HOME > 상품관리 > 신고상품조회</div>

    <form action="reportedProductList" method="get">
    <div class="search-box">
      <div class="row">
		<label>신고유형:
			<input type="radio" name="report_type" value="전체"
			  ${param.report_type == '전체' || empty param.report_type ? 'checked' : ''}> 전체
			
			<input type="radio" name="report_type" value="금지품목"
			  ${param.report_type == '금지품목' ? 'checked' : ''}> 금지품목
			
			<input type="radio" name="report_type" value="사기의심"
			  ${param.report_type == '사기의심' ? 'checked' : ''}> 사기의심
			
			<input type="radio" name="report_type" value="콘텐츠부적절"
			  ${param.report_type == '콘텐츠부적절' ? 'checked' : ''}> 콘텐츠부적절
		</label>
      </div>
      <div class="row">
      <label class="ms-4">신고일자:
        <input type="date" id="startdate" name="startdate" value="${param.startdate}"> ~
        <input type="date"  id="enddate"  name="enddate" value="${param.enddate}">
      </label>
      <button class="btn-action" type="submit">검색</button>
      </div>
    </div>
	</form>
	
    <div class="total-count">총 <span id="reportCount"></span>건</div>

    <c:if test="${not empty list}">
      <!-- 🚀 액션 버튼 -->
      <div class="mb-3">
        <button class="btn-action" id="btnDelete">상품삭제</button>
        <button class="btn-action" id="btnHide">상품숨김</button>
        <button class="btn-action" id="btnActive">상품활성</button>
      </div>

    <table class="report-table">
      <thead>
        <tr>
          <th><input type="checkbox" id="chkAll"></th>
             <th>상품번호</th>
            <th>상품명</th>
            <th>거래방식</th>
            <th>회원번호</th>
            <th>신고번호</th>
            <th>신고유형</th>
            <th>신고일자</th>
            <th>상태</th>
        </tr>
      </thead>
      <tbody>
             <c:forEach var="item" items="${list}">
            <tr>
              <td><input type="checkbox" name="chk"
                         data-productno="${item.productNo}"
                         data-reportno="${item.reportNo}"></td>

              <!-- 상품번호 링크 -->
              <td><a href="productDetail?no=${item.productNo}">${item.productNo}</a></td>
              <td>${item.productTitle}</td>
              <td>${item.tradeType}</td>
              <td>${item.memberNo}</td>
              <td>${item.reportNo}</td>
              
              
              <!-- 신고유형 클릭 시 모달 열기 -->
              <td>
				<!-- 예: 신고유형 클릭 시 모달 띄우기 -->
				<button class="btn btn-link"
				        data-bs-toggle="modal"
				        data-bs-target="#modal"
				        data-title="${item.title}"
				        data-contents="${item.contents}">
				  ${item.type}
				</button>
              </td>
              
              <td>${item.date}</td>
              <td>
                <c:choose>
					<c:when test="${item.hide}">숨김</c:when>
                  <c:otherwise>노출</c:otherwise>
                </c:choose>
              </td>
            </tr>
            
            
            <tr>
		  <td><c:out value="${item.productNo}" /></td>
		  <td><c:out value="${item.productTitle}" /></td>
		  <td><c:out value="${item.type}" /></td>
		  <td><c:out value="${item.date}" /></td>
		</tr>
          </c:forEach>

      </tbody>
    </table>
   </c:if>
   
       <div class="notice">
      ※신고 상품 관리 시 새로운 신고 건 LNB 상에 뱃지 표시<br>
      ※조회하여 1건 체크 시 하단 선택 후 판매여부로 전환/중지처리 가능<br>
      ※상품번호 및 상품명 선택 시 해당 상품 게시글로 화면 이동
    </div>
    
  </main>
</div>
    
		<!-- 💡 스크립트 영역 -->
		<script>
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
		
		  // 상품 삭제
		  $("#btnDelete").click(function () {
		    const reportNos = getCheckedValues("reportno");
		    if (reportNos.length === 0) return alert("신고 항목을 선택하세요.");
		    $.post("reportDelete", { "reportNo[]": reportNos }, function (res) {
		      if (res === "true") location.reload();
		    });
		  });
		
		  // 상품 숨김
		  $("#btnHide").click(function () {
		    const productNos = getCheckedValues("productno");
		    if (productNos.length === 0) return alert("상품을 선택하세요.");
		    $.post("reportHide", { "productNo[]": productNos }, function (res) {
		      if (res === "true") location.reload();
		    });
		  });
		
		  // 상품 활성화
		  $("#btnActive").click(function () {
		    const productNos = getCheckedValues("productno");
		    if (productNos.length === 0) return alert("상품을 선택하세요.");
		    $.post("reportActive", { "productNo[]": productNos }, function (res) {
		      if (res === "true") location.reload();
		    });
		  });
		
		  // 모달 내용 세팅 (Bootstrap 5)
		  modalElement.addEventListener('show.bs.modal', function (event) {
		    const modal = event.target;
		
		    // 모달 ID가 modal인 경우에만 처리
		    if (modal && modal.id === 'modal') {
		      const button = event.relatedTarget;
		
		      // 버튼에서 data-* 속성으로 값 추출
		      const title = button.getAttribute('data-title');
		      const contents = button.getAttribute('data-contents');
		
		      // 모달 내부 요소에 값 주입
		      modal.querySelector('#modalTitle').textContent = title || '제목 없음';
		      modal.querySelector('#modalContents').textContent = contents || '내용 없음';
		    }
		  });
		</script>
		<!-- 모달 구조 -->
		<div class="modal fade" id="modal" tabindex="-1" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="modalTitle">제목</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
		      </div>
		      <div class="modal-body" id="modalContents">
		        
		      </div>
		    </div>
		  </div>
		</div>
		


</body>
</html>