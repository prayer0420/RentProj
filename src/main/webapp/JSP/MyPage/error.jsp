<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f9f9f9;
      }
      .wrapper {
        max-width: 1200px;
        width: 100%;
        margin: 0 auto;
        padding: 20px;
        box-sizing: border-box;
      }
      .container {
        display: flex;
        margin: 0 auto;
        padding: 20px;
      }
      .content {
        flex: 1;
        margin-left: 30px;
      }
</style>
</head>

<body>
<!-- 헤더 (로고 + 검색창 + 카테고리) -->
  <jsp:include page="/JSP/Header/header.jsp" />
  
  <div class="wrapper">
      <div class="container">
        <!-- 사이드바 -->
        <jsp:include page="/JSP/MyPage/mypageSidebar.jsp" />
        <section class="content">
		<%= request.getAttribute("err") %>
		</section>
	</div>
 </div>
<!-- 푸터 -->
  <jsp:include page="/JSP/Header/footer.jsp" />
</body>
</html>