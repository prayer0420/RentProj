<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
  String location = "";
  String userId = (String) session.getAttribute("id");
  String cookieKey = "location_" + userId;

  Cookie[] cookies = request.getCookies();
  if (cookies != null && userId != null) {
    for (Cookie c : cookies) {
      if (cookieKey.equals(c.getName())) {
        location = java.net.URLDecoder.decode(c.getValue(), "UTF-8");
        break;
      }
    }
  }
  request.setAttribute("cookieLocation", location);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RE:NT</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header/header1.css">
</head>
<body>
<header class="top-nav">
  <div class="header-inner">
    <div class="logo-area">
      <a href="${pageContext.request.contextPath}/main" class="logo">RE:NT</a>
      <div class="product-add-wrapper">
        <c:set var="isLoggedIn" value="${not empty sessionScope.id}" />
        <button id="productRegisterBtn" class="product-add" data-logged-in="${isLoggedIn}">상품 등록</button>
      </div>
    </div>

    <form id="mainSearchForm" action="${pageContext.request.contextPath}/list" method="get" class="search-box">
      <input id="mainSearchInput" name="searchText" type="text"
             value="${fn:escapeXml(param.searchText)}" placeholder="검색어를 입력해주세요" />
      <button id="mainSearchBtn" type="submit">🔍</button>
    </form>

    <div class="header-actions">
      <button id="btn-location">📍 위치</button>
      <div class="location-display">
        <c:if test="${not empty cookieLocation}">
      <c:choose>
        <c:when test="${fn:indexOf(cookieLocation, '구') >= 0}">
          <c:set var="guIndex" value="${fn:indexOf(cookieLocation, '구')}" />
          <c:set var="guLocation" value="${fn:substring(cookieLocation, 0, guIndex + 3)}" />
          <c:choose>
            <c:when test="${fn:startsWith(guLocation, '서울')}">
              현재 위치: 서울시 ${fn:substring(guLocation, 2, fn:length(guLocation))}
            </c:when>
            <c:otherwise>
              현재 위치: ${guLocation}
            </c:otherwise>
          </c:choose>
        </c:when>
        <c:otherwise>
          현재 위치: ${cookieLocation}
        </c:otherwise>
      </c:choose>
    </c:if>
      </div>

      <button id="btn-alarm">🔔 알림
        <span id="headerAlarmBadge" style="display:none; background:red; color:white; font-size:11px; border-radius:8px; padding:1px 6px; margin-left:4px;">0</span>
      </button>

      <jsp:include page="/JSP/Header/alarm.jsp" />

      <a href="myOrder" class="my-page-btn">📄 마이페이지</a>
      <c:choose>
        <c:when test="${not empty sessionScope.id}">
          <button id="btn-logout">🚪 로그아웃</button>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/login"><button>🔑로그인</button></a>
        </c:otherwise>
      </c:choose>

      <c:if test="${sessionScope.adminNo == 1}">
        <button title="관리자 페이지">
          <a href="${pageContext.request.contextPath}/memberInfo" style="font-size: 18px;">⚙️</a>
        </button>
      </c:if>
    </div>
  </div>
</header>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $("#btn-location").click(function () {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(success, error);
    } else {
      alert("이 브라우저는 위치 정보를 지원하지 않습니다.");
    }

    function success(pos) {
      const lat = pos.coords.latitude;
      const lng = pos.coords.longitude;
      const userId = "${sessionScope.id}"; // 유저 ID

      $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/updateLocation",
        data: { lat: lat, lng: lng },
        dataType: "json",
        success: function (res) {
          const address = res.address;

          // 유저별 키로 쿠키 저장
          document.cookie = "latitude_" + userId + "=" + lat + "; path=/; max-age=604800";
          document.cookie = "longitude_" + userId + "=" + lng + "; path=/; max-age=604800";
          document.cookie = "location_" + userId + "=" + encodeURIComponent(address) + "; path=/; max-age=604800";

          alert("위치가 갱신되었어요! 😊");
          location.reload();
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

  // 로그아웃 (❌ 쿠키 삭제 안함!)
  $("#btn-logout").click(function () {
    if (confirm("정말 로그아웃 하시겠어요?")) {
      window.location.href = "${pageContext.request.contextPath}/logout";
    }
  });

  // 알림 모달 열기
  $("#btn-alarm").click(function () {
    $("#alarmModal").css("display", "flex");
  });

  // 상품 등록 버튼
  const registerBtn = document.getElementById("productRegisterBtn");
  if (registerBtn) {
    registerBtn.addEventListener("click", function () {
      const isLoggedIn = this.dataset.loggedIn === "true";
      if (isLoggedIn) {
        window.location.href = "${pageContext.request.contextPath}/productRegister";
      } else {
        alert("로그인이 필요한 서비스입니다.");
        window.location.href = "${pageContext.request.contextPath}/JSP/Login/login.jsp";
      }
    });
  }
</script>

</body>
</html>
