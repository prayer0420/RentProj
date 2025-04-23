<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>알림 모달</title>
  <link rel="stylesheet" href="${contextPath}/css/alarm.css" />
  <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>

<!-- 🔔 알림 모달 -->
<div id="alarmModal" class="alarm-modal">
  <div class="alarm-content">
    <div class="alarm-header">
      <span>🔔 알림</span>
      <div>
        <button class="clear-all-btn" onclick="clearAllAlarms()">전체삭제</button>
        <button class="close-btn" onclick="closeAlarmModal()">✕</button>
      </div>
    </div>
    <div class="divider"></div>

    <div class="alarm-list" id="alarmList">
      <!-- 실시간 알림이 여기에 추가됩니다 -->
    </div>
  </div>
</div>

<!-- Firebase FCM 알림 처리 -->
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/11.6.0/firebase-app.js";
  import { getMessaging, getToken, onMessage } from "https://www.gstatic.com/firebasejs/11.6.0/firebase-messaging.js";

  const firebaseConfig = {
    apiKey: "AIzaSyA5LKk4IXgwG57Z495sfLcHg1XA0ILokTU",
    authDomain: "test-6b1b7.firebaseapp.com",
    projectId: "test-6b1b7",
    storageBucket: "test-6b1b7.firebasestorage.app",
    messagingSenderId: "1066743702766",
    appId: "1:1066743702766:web:e765caafcc8ff1b7817fff",
    measurementId: "G-YTCKLHYEX2"
  };

  initializeApp(firebaseConfig);
  const messaging = getMessaging();

  const requestForToken = () => {
    getToken(messaging, {
      vapidKey: 'BKf2ZnmnAxGrBS6VogRScPinuISeM-n_I7Dn4k-4uSZ7FxAjeJCFxg7tJMFfZ0HvlKCeH4qv85F8L7r4rdweVT8'
    }).then((currentToken) => {
      if (currentToken) {
        $.ajax({
          url: 'fcmToken',
          type: 'POST',
          data: { fcmToken: currentToken },
          success: function (res) {
            console.log("FCM 토큰 저장 완료:", res);
          }
        });
      } else {
        console.log("토큰이 없습니다. 알림 권한이 필요합니다.");
      }
    }).catch((err) => {
      console.log("FCM 토큰 요청 실패", err);
    });

    onMessageListener(); // 알림 리스너 등록
  };

  const onMessageListener = () => {
    onMessage(messaging, (payload) => {
      console.log("알림 수신", payload);
      const alarm = payload.data;

      // 모달 자동 열기
      document.getElementById("alarmModal").style.display = "block";

      const alarmHTML = `
        <div class="alarm-card" data-num="${alarm.num}">
          <div class="alarm-top">
            <h4 class="alarm-title">${alarm.title}</h4>
            <button class="delete-btn" onclick="deleteAlarm(this)">✕</button>
          </div>
          <p class="alarm-body">${alarm.body}</p>
        </div>`;
      $("#alarmList").prepend(alarmHTML);
    });
  };

  requestForToken();
</script>

<!-- JS 이벤트 처리: 모달 동작, 삭제, 확인 처리 -->
<script>
  function closeAlarmModal() {
    document.getElementById("alarmModal").style.display = "none";
  }

  function deleteAlarm(button) {
    const card = button.closest('.alarm-card');
    const num = card.getAttribute('data-num');

    if (num) {
      $.ajax({
        url: 'alarmConfirm',
        type: 'POST',
        data: { num: num },
        success: function (result) {
          if (result === 'true') {
            card.remove();
          } else {
            alert("알림 확인 처리 실패");
          }
        },
        error: function () {
          alert("서버 오류: 알림 확인 실패");
        }
      });
    } else {
      card.remove(); // 알림 번호 없으면 그냥 제거
    }
  }

  function clearAllAlarms() {
    const list = document.getElementById('alarmList');
    list.innerHTML = "<p class='empty-text'>알림이 없습니다.</p>";
  }
</script>

</body>
</html>
