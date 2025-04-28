<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>개인정보 수정</title>
  <link rel="stylesheet" href="${contextPath}/CSS/mypage/myInfoModify.css">
</head>
<body>
 	<c:if test="${not empty sessionScope.message}">
	  <script>
	    alert("${sessionScope.message}");
	  </script>
	  <c:remove var="message" scope="session" />
	</c:if> 
	
	
	
  <div class="wrapper">
    <div class="container">
      <!-- 사이드바 -->
      <jsp:include page="/JSP/MyPage/mypageSidebar.jsp" />

      <!-- 콘텐츠 영역 -->
      <section class="content">
        <div class="page-header">
          <h2>개인정보 수정</h2>
          <div class="divider"></div>
        </div>

        <div class="form-box-wrapper">
          <form action="${contextPath}/myInfoModify" method="post" enctype="multipart/form-data">
            <div class="form-group">
              <label>아이디</label>
              <input type="text" name="id" value="${member.id}" readonly />
            </div>
			
            <div class="form-group">
              <label>비밀번호</label>
              <input type="password" name="password" placeholder="비밀번호를 입력하세요" />
            </div>

            <div class="form-group">
              <label>비밀번호 확인</label>
              <input type="password" name="confirmPassword" placeholder="비밀번호를 다시 입력하세요" />
            </div>
            
            <div class="form-group">
            <label for="name">이름</label>
        		<input type="text" id="name" name="name"  value="${member.name}" placeholder="이름을 입력하세요">
			</div>
			
            <div class="form-group">
              <label>닉네임</label>
              <input type="text" name="nickname" value="${member.nickname}" placeholder="닉네임 입력" />
            </div>

            <div class="form-group">
              <label>휴대폰번호</label>
              <input type="tel" name="phone" value="${member.phone}" placeholder="010-1234-5678" />
            </div>

            <div class="form-group">
              <label>거래지역</label>
              <button type="button" id="postSearch">➕ 주소 검색</button>
              <div id="regionList"></div>
              <input type="hidden" name="region1" id="region1" value="${member.region1}" />
              <input type="hidden" name="region2" id="region2" value="${member.region2}" />
              <input type="hidden" name="region3" id="region3" value="${member.region3}" />
            </div>

            <div class="form-group">
              <label>프로필 이미지</label>
              <div class="profile-upload">
                <img src="${member.profileImage}" alt="프로필 이미지" />
                <input type="file" name="profileImage" />
              </div>
            </div>

            <div class="btn-row">
              <button type="submit" class="btn confirm">수정하기</button>
            </div>
          </form>
        </div>
      </section>
    </div>
  </div>

  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
  // 1) 초기 세션 값을 JS 배열로
  const selectedRegions = [
    <c:if test="${not empty member.region1}">"${member.region1}",</c:if>
    <c:if test="${not empty member.region2}">"${member.region2}",</c:if>
    <c:if test="${not empty member.region3}">"${member.region3}",</c:if>
  ];

  // 2) 페이지 로드 시 기존 지역 보여주기
  window.addEventListener('DOMContentLoaded', () => {
    updateRegionList(); // 초기 값이 있으면 표시
  });

  // 3) 주소 검색 버튼 클릭 시 새 주소 추가
  document.getElementById("postSearch").addEventListener("click", function() {
    new daum.Postcode({
      oncomplete: function(data) {
        const region = data.sido + " " + data.sigungu;
        if (selectedRegions.includes(region)) {
          alert("이미 등록된 지역입니다.");
          return;
        }
        if (selectedRegions.length >= 3) {
          alert("최대 3개까지만 등록할 수 있습니다.");
          return;
        }
        selectedRegions.push(region);
        updateRegionList();
      }
    }).open();
  });

  // 4) 지역 목록 렌더링 함수
  function updateRegionList() {
    const regionList = document.getElementById("regionList");
    regionList.innerHTML = ""; // 초기화

    selectedRegions.forEach((region, i) => {
      const div = document.createElement("div");
      div.textContent = region;

      const btn = document.createElement("button");
      btn.textContent = "❌";
      btn.className = "delete-btn";
      btn.onclick = () => removeRegion(i);

      div.appendChild(btn);
      regionList.appendChild(div);
    });

    // input 값 갱신
    for (let j = 0; j < 3; j++) {
      document.getElementById("region" + (j + 1)).value = selectedRegions[j] || "";
    }
  }

  // 5) 제거 함수
  function removeRegion(index) {
    selectedRegions.splice(index, 1);
    updateRegionList();
  }
</script>


</body>
</html>
