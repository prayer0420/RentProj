<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 알림 발송 테스트</title>
  <style>
    body { font-family: 'Noto Sans KR', sans-serif; padding: 2rem; }
    label { display: block; margin-top: 1rem; }
    input, textarea, button { width: 300px; padding: 0.5rem; margin-top: 0.5rem; }
    button { background: #26c6da; color: white; border: none; cursor: pointer; }
    .response { margin-top: 2rem; color: green; }
  </style>
</head>
<body>

<h2>🔔 관리자 알림 발송</h2>

<form id="alarmForm">
  <label>수신자 ID (recvId):
    <input type="text" id="recvId" name="recvId" required />
  </label>

  <label>알림 제목:
    <input type="text" id="title" name="title" value="테스트 알림입니다." required />
  </label>

  <label>알림 내용:
    <textarea id="content" name="content" rows="4">이 알림은 관리자 테스트용입니다.</textarea>
  </label>

  <button type="submit">알림 발송</button>
</form>

<div class="response" id="responseMessage"></div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $("#alarmForm").on("submit", function(e) {
    e.preventDefault();

    $.ajax({
      url: "${pageContext.request.contextPath}/adminSendAlarm", // 서블릿으로 보내는 경로
      type: "POST",
      data: {
        recvId: $("#recvId").val(),
        title: $("#title").val(),
        content: $("#content").val()
      },
      success: function(res) {
        $("#responseMessage").text("✅ 알림 전송 성공!");
      },
      error: function(err) {
        $("#responseMessage").text("❌ 알림 전송 실패!");
        console.error(err);
      }
    });
  });
</script>

</body>
</html>
