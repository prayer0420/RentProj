<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<link rel="stylesheet" href="${contextPath}/CSS/header/alarm.css" />
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<!-- 🔔 알림 모달 -->
<div id="alarmModal" class="alarm-modal" onclick="backgroundClick(event)">
  <div class="alarm-content">
    <!-- 헤더 -->
    <div class="alarm-header">
            <span>🔔 알림 <span id="alarmBadge" class="alarm-badge" style="display:none; background-color: red; color: white; font-size: 12px; padding: 2px 6px; border-radius: 12px;">0</span></span>
      <div>
        <button class="close-btn" onclick="closeAlarmModal()">✕</button>
      </div>
    </div>
    <div class="divider"></div>

    <!-- 전체 삭제 버튼 -->
    <div class="clear-all-wrap">
      <button class="clear-all-btn" onclick="clearAllAlarms()">전체삭제</button>
    </div>

    <!-- 알림 목록 -->
    <div class="alarm-list" id="alarmList">
      <c:forEach var="alarm" items="${alarms}">
        <div class="alarm-card" data-num="${alarm.no}">
          <div class="alarm-top">
            <h4 class="alarm-title">${alarm.title}</h4>
            <button class="delete-btn" onclick="deleteAlarm(this)">✕</button>
          </div>
          <p class="alarm-body">${alarm.content}</p>
        </div>
      </c:forEach>

      <c:if test="${empty alarms}">
        <div class="alarm-empty">
          <div class="alarm-empty-icon">
            <svg width="80" height="80" viewBox="0 0 24 24" fill="#e0e7ef" xmlns="http://www.w3.org/2000/svg">
              <path d="M12 2C10.3 2 9 3.3 9 5V5.3C6.2 6.2 4.3 8.8 4.3 11.7V16L2 18.3V19H22V18.3L19.7 16V11.7C19.7 8.8 17.8 6.2 15 5.3V5C15 3.3 13.7 2 12 2ZM12 22C13.1 22 14 21.1 14 20H10C10 21.1 10.9 22 12 22Z"/>
            </svg>
            <button class="close-btn" onclick="closeAlarmModal()">✕</button>
          </div>
          <p class="alarm-empty-text">알림 내역이 없습니다.</p>
        </div>
      </c:if>
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
 		console.log("🔑 Token:", currentToken);
      if (currentToken) {
        $.post("fcmToken", { fcmToken: currentToken });
      }
    }).catch(console.error);

    updateAlarmBadge();
    onMessageListener();
  };

	const updateAlarmBadge = () => {
    const count = document.querySelectorAll("#alarmList .alarm-card").length;
    const badge = document.getElementById("alarmBadge");
    const headerBadge = document.getElementById("headerAlarmBadge");
    if (count > 0) {
      badge.textContent = count;
      badge.style.display = "inline-block";
      if (headerBadge) {
        headerBadge.textContent = count;
        headerBadge.style.display = "inline-block";
      }
    } else {
      badge.style.display = "none";
      if (headerBadge) {
        headerBadge.style.display = "none";
      }
    }
  };
	
  const onMessageListener = () => {
    onMessage(messaging, (payload) => {
		console.log("📬 FCM 수신함!");
      console.log("📦 payload 전체:", payload);
      const title = payload.data?.title || "제목 없음";
      const body = payload.data?.body || "내용 없음";

      const modal = document.getElementById("alarmModal");
      modal.style.display = "flex";
      void modal.offsetHeight;

      $("#alarmList .alarm-empty").remove();

      const alarmHTML = `
        <div class="alarm-card realtime">
          <div class="alarm-top">
            <h4 class="alarm-title">${title}</h4>
            <button class="delete-btn" onclick="deleteAlarm(this)">✕</button>
          </div>
          <p class="alarm-body">${body}</p>
        </div>`;

      $("#alarmList").prepend(alarmHTML);
      updateAlarmBadge();
    });
  };

  requestForToken();
  onMessageListener();

</script>

<script>

	

  function closeAlarmModal() {
    document.getElementById("alarmModal").style.display = "none";
  }

  function deleteAlarm(button) {
    const card = button.closest('.alarm-card');
    const no = card.getAttribute('data-num');

    if (no) {
      $.post('alarmConfirm', { no }, function (result) {
        if (result === 'true') {
          card.remove();
          checkIfEmpty();
        }
      });
    } else {
      card.remove();
      checkIfEmpty();
    }
  }

  function clearAllAlarms() {
    if (!confirm("모든 알림을 삭제하시겠어요?")) return;

    const cards = document.querySelectorAll('.alarm-card');
    if (cards.length === 0) return;

    cards.forEach(card => {
      const no = card.getAttribute('data-num');
      if (no) {
        $.post('alarmConfirm', { no }, function (result) {
          if (result === 'true') {
            card.remove();
            checkIfEmpty();
          }
        });
      } else {
        card.remove();
      }
    });
  }

  function checkIfEmpty() {
    if ($("#alarmList .alarm-card").length === 0) {
      $("#alarmList").html(`
        <div class="alarm-empty">
          <div class="alarm-empty-icon">
            <svg width="80" height="80" viewBox="0 0 24 24" fill="#e0e7ef" xmlns="http://www.w3.org/2000/svg">
              <path d="M12 2C10.3 2 9 3.3 9 5V5.3C6.2 6.2 4.3 8.8 4.3 11.7V16L2 18.3V19H22V18.3L19.7 16V11.7C19.7 8.8 17.8 6.2 15 5.3V5C15 3.3 13.7 2 12 2ZM12 22C13.1 22 14 21.1 14 20H10C10 21.1 10.9 22 12 22Z"/>
            </svg>
            <button class="close-btn" onclick="closeAlarmModal()">✕</button>
          </div>
          <p class="alarm-empty-text">알림 내역이 없습니다.</p>
        </div>
      `);
    }
  }

  document.addEventListener("keydown", function (event) {
    if (event.key === "Escape") {
      closeAlarmModal();
    }
  });

  function backgroundClick(event) {
    const modalContent = document.querySelector(".alarm-content");
    if (!modalContent.contains(event.target)) {
      closeAlarmModal();
    }
  }
</script>

<script>
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('${contextPath}/firebase-messaging-sw.js')
      .then(function(registration) {
        console.log("✅ Service Worker 등록 성공", registration);
      })
      .catch(function(err) {
        console.error("❌ Service Worker 등록 실패", err);
      });
  } else {
    console.warn("Service Worker 지원 안 됨");
  }
</script>
