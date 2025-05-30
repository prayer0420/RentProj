<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>판매정산</title>	
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/common.css">

</head>
<body>
	<%@ include file="header.jsp" %>
<div class="container">
  <aside>
    <h3>정산관리</h3>
    <div class="menu inactive"><a href="orderList" style="color: inherit; text-decoration: none;">전체주문조회</a></div>
    <div class="menu active"><a href="settlementList" style="color: inherit; text-decoration: none;">주문정산</a></div>
    <div class="menu inactive"><a href="rentalDelayList" style="color: inherit; text-decoration: none;">대여지연조회</a></div>
  </aside>

  <main>
    <div class="breadcrumb">HOME > 정산관리 > 주문정산</div>

    <!-- 검색 폼 -->
    <form action="${pageContext.request.contextPath}/settlementList" method="post" class="search-box" style="display: flex; flex-wrap: wrap; gap: 10px; align-items: center; margin-bottom: 20px;">
	  <label>
	    <b>정산 상태:</b>
	    <select name="searchFeeStatus">
	      <option value="">전체</option>
	      <option value="PENDING" <c:if test="${searchMap.searchFeeStatus == 'PENDING'}">selected</c:if>>대기</option>
	      <option value="COMPLETE" <c:if test="${searchMap.searchFeeStatus == 'COMPLETE'}">selected</c:if>>완료</option>
	    </select>
	  </label>
	
	  <label>
	    <b>판매/대여 구분:</b>
	    <select name="searchRevenueType">
	      <option value="">전체</option>
	      <option value="판매" <c:if test="${searchMap.searchRevenueType == '판매'}">selected</c:if>>판매</option>
	      <option value="대여" <c:if test="${searchMap.searchRevenueType == '대여'}">selected</c:if>>대여</option>
	    </select>
	  </label>
		
	  <label>
	    <b>정산완료 시작:</b>
	    <input type="datetime-local" name="completedStart" value="${searchMap.completedStart}" />
	  </label>
	
	  <label>
	    <b>정산완료 종료:</b>
	    <input type="datetime-local" name="completedEnd" value="${searchMap.completedEnd}" />
	  </label>
	
	  <button type="submit">검색</button>
	</form>


    <div class="section-title">
      <span id="count"></span>
      <div class="summary-box">
		<div style="margin-bottom:10px; font-weight:bold;">
		    🔍 검색된 총 정산 건수: <span style="color:#007bff;">${pageInfo.totalCount != null ? pageInfo.totalCount : 0}</span>건
		</div>
		
		<!-- 총 수수료 금액 표시 -->
		<div style="display: flex; justify-content: flex-end; margin: 10px 0;">
		    <div style="padding: 10px 20px; background: #f8f9fa; border: 1px solid #ddd; border-radius: 6px; font-weight: bold;">
		    총 수수료 금액: <span style="color: #007bff;"><fmt:formatNumber value="${totalFeeAmount}" type="number" /></span> 원
		  	</div>
		</div>
      </div>
    </div>


<!-- 정산 리스트 테이블 -->
<table class="table table-striped table-bordered">
  <thead class="table-light">
    <tr>
      <th>정산번호</th>
      <th>주문번호</th>
      <th>거래구분</th>
      <th>회원번호</th>
      <th>상품번호</th>
      <th>상품명</th>
      <th>결제일</th>
      <th>물품가</th>
      <th>배송비</th>
      <th>보증금</th>
      <th>수수료율(%)</th>
      <th>수수료금액</th>
      <th>최종정산금액</th>
      <th>정산완료시간</th>
      <th>정산처리</th>
    </tr>
  </thead>
  <tbody>
    <c:choose>
      <c:when test="${not empty settlementList}">
        <c:forEach var="settle" items="${settlementList}">
          <tr>
            <td>${settle.settlementNo}</td>
            <td>${settle.orderNo}</td>
            <td>${settle.revenueType}</td>
            <td>${settle.sellerMemberNo}</td>
            <td>${settle.productNo}</td>
            <td>${settle.productTitle}</td>
            <td>${fn:substringBefore(settle.payTime, ' ')}</td>
            <td><fmt:formatNumber value="${settle.price}" type="number" /> 원</td>
            <td><fmt:formatNumber value="${settle.deliveryPrice}" type="number" /> 원</td>
            <td><fmt:formatNumber value="${settle.secPrice}" type="number" /> 원</td>
            <td><fmt:formatNumber value="${settle.gradeRate}" maxFractionDigits="2" /> %</td>
            <td><fmt:formatNumber value="${settle.feeAmount}" type="number" /> 원</td>
            <td><fmt:formatNumber value="${settle.finalSettleAmount}" type="number" /> 원</td>
            <td id="completedAt-${settle.settlementNo}" 
			    title="<fmt:formatDate value='${settle.settlementCompletedAt}' pattern='yyyy-MM-dd HH:mm:ss' />"> <!-- 툴팁 추가 -->
			    <fmt:formatDate value="${settle.settlementCompletedAt}" pattern="yyyy-MM-dd HH:mm:ss" />
			</td>
          <td>
            <c:choose>
              <c:when test="${settle.feeStatus == 'PENDING'}">
                <button type="button" class="btn-do-settlement" 
                        data-settlement-no="${settle.settlementNo}" 
                        style="padding: 6px 12px; background: #26c6da; color: white; border: none; border-radius: 4px;">
                  정산하기
                </button>
              </c:when>
              <c:otherwise>
                <button type="button" disabled
                        style="padding: 6px 12px; background: #d3d3d3; color: white; border: none; border-radius: 4px; cursor: default;">
                  ✔ 정산완료
                </button>
              </c:otherwise>
            </c:choose>
          </td>

          </tr>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <tr>
          <td colspan="15" class="text-center">데이터가 없습니다.</td>
        </tr>
      </c:otherwise>
    </c:choose>
  </tbody>
</table>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
  $(document).ready(function() {
    $(".btn-do-settlement").click(function() {
      if (!confirm("정산을 진행하시겠습니까?")) {
        return;
      }

      const settlementNo = $(this).data("settlement-no");
      const button = $(this);

      $.ajax({
        url: "${pageContext.request.contextPath}/doSettlement",
        method: "POST",
        data: { settlementNo: settlementNo },
        success: function(data) {
          if (data.success) {
            button.prop("disabled", true);
            button.text("✔ 정산완료");
            button.css({
              "background": "#d3d3d3",
              "cursor": "default"
            });

            // 정산 완료 시간 즉시 화면에 표시
            $("#completedAt-" + settlementNo).text(data.completedAt);
          }
        }
      });
    });
  });
</script>

<c:if test="${not empty pageInfo}">
    <div class="pagination" style="margin: 20px 0; text-align: center;">
        <c:if test="${pageInfo.startPage > 1}">
            <form method="post" style="display:inline;">
                <input type="hidden" name="page" value="${pageInfo.startPage - 1}" />
                <c:forEach var="entry" items="${searchMap}">
                    <input type="hidden" name="${entry.key}" value="${entry.value}" />
                </c:forEach>
                <button type="submit">이전</button>
            </form>
        </c:if>

        <!-- 페이지 번호들 -->
        <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
            <form method="post" style="display:inline;">
                <input type="hidden" name="page" value="${i}" />
                <c:forEach var="entry" items="${searchMap}">
                    <input type="hidden" name="${entry.key}" value="${entry.value}" />
                </c:forEach>
                <button type="submit"
                    <c:if test="${pageInfo.curPage == i}">style="font-weight:bold; background-color:#007bff; color:white;"</c:if>
                >${i}</button>
            </form>
        </c:forEach>

        <!-- 다음 블록 -->
        <c:if test="${pageInfo.endPage < pageInfo.allPage}">
            <form method="post" style="display:inline;">
                <input type="hidden" name="page" value="${pageInfo.endPage + 1}" />
                <c:forEach var="entry" items="${searchMap}">
                    <input type="hidden" name="${entry.key}" value="${entry.value}" />
                </c:forEach>
                <button type="submit">다음</button>
            </form>
        </c:if>
    </div>
</c:if>

</main>
</div>

</body>
</html>