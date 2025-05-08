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

  <jsp:include page="/JSP/Header/header.jsp" />

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
</body>
</html>
