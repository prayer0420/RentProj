<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/header/header1.css">
</head>
<body>
	<header class="top-nav">
		<div class="header-inner">

			<div class="logo-area">
				<a href="${pageContext.request.contextPath}/main"
					class="logo">RE:NT</a> <a
					href="${pageContext.request.contextPath}/JSP/ProductRegister/productRegister.jsp"
					class="product-add">상품 등록</a>
			</div>

			<form id="mainSearchForm"
				action="${pageContext.request.contextPath}/list" method="get"
				class="search-box">
				<input id="mainSearchInput" name="searchText" type="text"
					value="${fn:escapeXml(param.searchText)}" placeholder="검색어를 입력해주세요" />
				<button id="mainSearchBtn" type="submit">🔍</button>
			</form>

			<div class="header-actions">
				<button id="btn-location">📍 위치</button>
				<div class="location-display">
					<c:if test="${not empty member.location}">
    					현재 위치:	${fn:substring(member.location, 0, fn:indexOf(member.location, "구") + 1)}
  					</c:if>
				</div>

				<button id="btn-alarm">🔔 알림</button>
				<button><a href="myOrder">📄 마이페이지</a></button>
				<c:choose>
					<c:when test="${not empty member}">
						<button id="btn-logout">🚪 로그아웃</button>
					</c:when>
					<c:otherwise>
						<a href="${pageContext.request.contextPath}/login">
							<button>🔑로그인</button></a>
					</c:otherwise>
				</c:choose>
			</div>


		</div>
	</header>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

  //위치
  $("#btn-location").click(function () {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(success, error);
    } else {
      alert("이 브라우저는 위치 정보를 지원하지 않습니다.");
    }

    function success(pos) {
      $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/updateLocation",
        data: {
            lat: pos.coords.latitude,
            lng: pos.coords.longitude
        },
        success: function () {
          alert("위치가 갱신되었어요! 😊");
          location.reload(); // 새로고침해서 내 동네 상품 반영
        },
        error: function () {
          alert("위치 저장에 실패했어요 😥");
        }
      });
    }

    function error(err) {
      alert("위치 정보를 가져올 수 없어요 😥");
      console.error(err);
    }
  });
  
  
  // 로그아웃 처리
  $("#btn-logout").click(function () {
    if (confirm("정말 로그아웃 하시겠어요?")) {
      window.location.href = "${pageContext.request.contextPath}/logout";
    }
  });
</script>

<!--알림 관련 코드-->
<div id="alarmModalContainer"></div>

<script>
$("#btn-alarm").click(function () {
	  $.ajax({
	    url: "${pageContext.request.contextPath}/alarmList",
	    method: "GET",
	    success: function (html) {
	      // 이전 모달 제거 (중복 방지)
	      $("#alarmModalContainer").html(""); 
	      $("#alarmModalContainer").html(html);

	      // 모달 보이기
	      $("#alarmModal").css("display", "flex");
	    },
	    error: function () {
	      alert("알림을 불러오는 데 실패했습니다 😥");
	    }
	  });
	});

</script>

</body>
</html>