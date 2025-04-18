<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/alarm.css" />

<!-- 알림 모달 -->
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
      <!-- 알림 카드 1 -->
      <div class="alarm-card">
        <div class="alarm-top">
          <h4 class="alarm-title">[Re:NT] 회원가입을 축하드립니다!</h4>
          <button class="delete-btn" onclick="deleteAlarm(this)">✕</button>
        </div>
        <p class="alarm-body">성공적인 회원가입을 진심으로 감사드립니다. 더 나은 서비스로 보답하겠습니다.</p>
      </div>

      <!-- 알림 카드 2 -->
      <div class="alarm-card">
        <div class="alarm-top">
          <h4 class="alarm-title">대여한 상품 반납일이 3일 남았습니다</h4>
          <button class="delete-btn" onclick="deleteAlarm(this)">✕</button>
        </div>
        <p class="alarm-body">렌탈하신 '아이폰 14 Pro'의 반납일이 3일 남았습니다. 마이페이지 > 대여상품에서 확인해주세요.</p>
      </div>
    </div>
  </div>
</div>


<script>
  function closeAlarmModal() {
    document.getElementById("alarmModal").style.display = "none";
  }

  // 개별 삭제
  function deleteAlarm(button) {
    const card = button.closest('.alarm-card');
    card.remove();
  }

  // 전체 삭제
  function clearAllAlarms() {
    const list = document.getElementById('alarmList');
    list.innerHTML = "<p class='empty-text'>알림이 없습니다.</p>";
  }
</script>

