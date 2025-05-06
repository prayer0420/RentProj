<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>신고상품조회</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/common.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <style>

.btn-link {
  color: inherit !important; /* 링크 텍스트 색을 부모와 동일하게 */
}

  </style>
</head>


<body>
	<%@ include file="header.jsp" %>
<div class="container">
  <aside style="width: 200px; border-right: 1px solid #ccc; background: #f9f9f9; flex-shrink: 0;">
    <h3 style='font-size: 19px;font-weight: bold;'>상품관리</h3>
    <div class="menu active"><a href="reportedProductList" style="color: inherit; text-decoration: none;">신고상품조회 
    <span class="badge">${newReportsCount}</span></a></div> <!-- 신고상품의 'new' 상태 카운트 표시 -->
  </aside>

  <main>
    <div class="breadcrumb">HOME > 상품관리 > 신고상품조회</div>

    <form action="reportedProductList" method="post">
    <div class="search-box">
      <div class="row">
		<label><b>신고유형:</b>&nbsp;&nbsp;
			<input type="radio" name="report_type" value="전체" checked="checked"
			  ${param.report_type == '전체' || empty param.report_type ? 'checked' : ''}> 전체
			
			<input type="radio" name="report_type" value="금지품목"
			  ${param.report_type == '금지품목' ? 'checked' : ''}> 금지품목
			
			<input type="radio" name="report_type" value="사기의심"
			  ${param.report_type == '사기의심' ? 'checked' : ''}> 사기의심
			
			<input type="radio" name="report_type" value="콘텐츠부적절"
			  ${param.report_type == '콘텐츠부적절' ? 'checked' : ''}> 콘텐츠부적절
		</label>
      </div>
      <div class="row" style="display: flex; align-items: center; gap: 6px;">
      <label><b>신고일자:</b>&nbsp;&nbsp;
        <input type="date" id="startdate" name="startdate" value="${param.startdate}"> ~
        <input type="date"  id="enddate"  name="enddate" value="${param.enddate}">
	  	<button class="btn-action" type="submit" style="height: 30px;">검색</button>
      </label>
      </div>
    </div>
	</form>
	
    <div style="margin-bottom:10px; font-weight:bold;">
		 🔍 검색된 신고: <span style="color:#007bff;">${not empty list ? fn:length(list) : 0}</span>건
	</div>

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
            <th>상품상태</th>
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
              
              
              <!-- 신고유형 (모달 버튼으로 title/contents 전달) -->
              <td>
				<button class="btn btn-link"
				        data-bs-toggle="modal"
				        data-bs-target="#modal"
		        		data-title="${item.title}"
		        		data-contents="${fn:escapeXml(item.contents)}">
				  ${item.type}
				</button>
              </td>
              
            <!-- 상품 상태(노출 여부)를 표시 -->
			<!-- ReportedProduct 객체의 boolean hide 필드를 기반으로 상태 출력 -->
              <td>${item.date}</td>
              <td>
					<c:choose>
				  <c:when test="${item.actuallyHidden}">
				    숨김
				  </c:when>
				  <c:otherwise>
				    노출
				  </c:otherwise>
				</c:choose>
              </td>
            </tr>
          </c:forEach>

      </tbody>
    </table>
   </c:if>
   
      <div class="info-note">
      ※리스트 조회 전, 새로운 신고 건 뱃지 표시<br>
      ※상품번호 선택 시, 해당 상품 게시글로 화면 이동
    </div>
    
  </main>
</div>
			<!-- 모달 구조 -->
			<div class="modal fade" id="modal" tabindex="-1" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			    
			      <!-- ✅ Modal Header -->
			      <div class="modal-header">
			        <h5 class="modal-title">신고 정보 상세</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
			      </div>
			
			      <!-- ✅ Modal Body -->
			      <div class="modal-body" id="modalContents">
			        <!-- 자바스크립트에서 데이터가 들어올 부분 -->
			      </div>
			
			      <!-- ✅ Modal Footer -->
			      <div class="modal-footer">
			        <button type="button" class="btn btn-info" data-bs-dismiss="modal">확인</button>
			      </div>
			
			    </div>
			  </div>
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
			const modal = document.getElementById('modal');

				modal.addEventListener('show.bs.modal', function (event) {
				  const button = event.relatedTarget;
				  if (!button) return;
				
				  const title = button.getAttribute('data-title') || '제목 없음';
				  const contents = button.getAttribute('data-contents') || '내용 없음';
				  const html = `
				    <div>
				      <strong>신고 제목:</strong>
				      <div style="margin-bottom: 10px;">\${title}</div>
				      <strong>신고 내용:</strong>
				      <div>\${contents}</div>
				    </div>
				  `;
					
				  console.log(modal.querySelector('#modalContents'))
				  modal.querySelector('#modalContents').innerHTML = html;
				});
		</script>

		

</body>
</html>