
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대여 캘린더</title>

<!-- FullCalendar CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<style>
#calendarModal {
  display: none;
  position: fixed;
  top: 0; left: 0;
  width: 100%; height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  justify-content: center;
  align-items: center;
  z-index: 9999;
  font-family: 'Noto Sans KR', sans-serif;
}

#calendarModal .modal-content {
  background-color: #fffaf3;
  width: 740px;               /* ✅ 가로 살짝 늘림 */
  height: 680px;              /* ✅ 세로 줄임 */
  padding: 32px;
  border-radius: 20px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
  text-align: center;
  overflow: hidden;           /* ✅ 스크롤 없애기 */
  position: relative;
  transform: scale(0.95);
  opacity: 0;
  transition: all 0.25s ease;
}

#calendarModal .modal-content.active {
  transform: scale(1);
  opacity: 1;
}

#calendarModal .modal-title {
  font-size: 22px;
  font-weight: bold;
  color: #333;
  margin-bottom: 16px;
}

#calendarModal .available-dates {
  font-size: 14px;
  color: #666;
  margin-bottom: 14px;
}

#calendarModal .calendar-box {
  height: 480px;              /* ✅ 캘린더 영역 축소 */
  margin: 0 auto;
  border: 1px solid #eee;
  border-radius: 10px;
  overflow: hidden;
}
#calendarModal .calendar-box {
  height: 480px;
  overflow: hidden;
  border: 1px solid #eee;
  border-radius: 10px;
}

/* ✅ FullCalendar 내부 셀 줄이기 */
.fc .fc-daygrid-day-frame {
  min-height: 50px !important;  /* 기본은 90px 넘음 → 줄여줌 */
  padding: 2px !important;
}

.fc .fc-daygrid-day-number {
  font-size: 13px !important;   /* 날짜 숫자 크기 줄이기 */
  padding: 2px !important;
}

.fc .fc-scrollgrid {
  font-size: 13px;
}
.fc .fc-toolbar-title {
  font-size: 18px;
  font-weight: bold;
  text-align: center;
  flex-grow: 0;
  margin: 0 auto 0 50px;
  
}
/* 날짜 숫자 (9일, 10일 등)를 가운데 정렬 */
.fc .fc-daygrid-day-number {
  text-align: center !important;
  display: block;              /* ✅ inline -> block으로 바꿔야 가운데 정렬이 적용됨 */
  width: 100%;
}

/* ◀ 이전/다음 버튼 스타일 */
.fc .fc-button {
  background-color: #fffaf3;
  border: none;
  border-radius: 6px;
  padding: 6px 10px;
  font-size: 14px;
  font-weight: bold;
  color: #333;
  transition: background-color 0.2s ease;
}

.fc .fc-button:hover {
  background-color: rgb(255,248,232);
}

.fc .fc-button:disabled {
  background-color: rgb(255,253,249);
  color: #999;
}

#calendarModal #calendar {
  margin-top: 10px;
}

#calendarModal .modal-actions {
  margin-top: 16px;           /* ✅ 버튼 여백 줄임 */
  display: flex;
  justify-content: center;
  gap: 10px;
}

#calendarModal .btn-confirm,
#calendarModal .btn-cancel {
  padding: 10px 20px;
  font-weight: bold;
  border-radius: 8px;
  border: none;
  cursor: pointer;
}

#calendarModal .btn-confirm {
  background-color: #4CAF50;
  color: white;
}

#calendarModal .btn-cancel {
  background-color: #e0e0e0;
  color: #333;
}

#calendarModal .btn-confirm:hover {
  background-color: #45a049;
}

#calendarModal .btn-cancel:hover {
  background-color: #d0d0d0;
}
</style>
</head>

<body>
	<div id="calendarModal" class="modal">
		<div class="modal-content">
			<h3 class="modal-title">📅 대여하기</h3>

			<p class="available-dates">
				대여 가능 <strong id="availableStart"></strong> ~ <strong
					id="availableEnd"></strong>
			</p>

			<div id="calendar" class="calendar-box"></div>

			<div class="modal-actions">
				<button onclick="submitReservation()" class="btn-confirm">예약하기</button>
				<button onclick="closeCalendar()" class="btn-cancel">닫기</button>
			</div>

			<!-- JSTL로 전달된 파라미터 저장 -->
			<c:set var="productStart" value="${param.productStart}" />
			<c:set var="productEnd" value="${param.productEnd}" />
			<c:set var="productNo" value="${param.productNo}" />
		</div>
	</div>

	<script>
console.log("로그인 여부:", isLoggedIn);

let calendar = null;
let selectedStart = null;
let selectedEnd = null;
let reservedRanges = [];

function openCalendar() {
	  if (!isLoggedIn) {
	    alert("로그인이 필요합니다.");
	    location.href = contextPath + "/login";
	    return;
	  }

	  const modal = document.getElementById('calendarModal');
	  modal.style.display = 'flex';

	  setTimeout(() => {
	    modal.querySelector('.modal-content').classList.add('active');
	  }, 10);

	  const productNo = '${param.productNo}';
	  const productStart = '${param.productStart}';
	  const productEnd = '${param.productEnd}';

	  document.getElementById('availableStart').textContent = productStart;
	  document.getElementById('availableEnd').textContent = productEnd;

	  fetch(contextPath + '/getReservedDates?productNo=' + productNo)
	    .then(res => res.json())
	    .then(data => {
	      reservedRanges = data.map(r => {
	        const start = new Date(r.startDate);
	        const end = new Date(r.endDate);
	        return { start, end };
	      });

	      const calendarEl = document.getElementById('calendar');
	      if (calendar !== null) calendar.destroy();

	      const colors = ['#FFB3BA', '#BAE1FF', '#BAFFC9', '#FFFFBA', '#D9BAFF', '#FFCBA4'];
	      const memberColorMap = {};
	      let colorIndex = 0;

	      calendar = new FullCalendar.Calendar(calendarEl, {
	        initialView: 'dayGridMonth',
	        locale: 'ko',
	        height: 480,
	        headerToolbar: {
	        	 left: '',       // ← 버튼 제거
	        	  center: 'title', // ✅ 타이틀만 가운데 정렬
	        	  right: 'prev,next' // → 버튼 우측
	          },
	        initialDate: productStart,
	        selectable: true,
	        validRange: { start: productStart, end: productEnd },
	        select: function (info) {
	          const start = info.startStr;
	          const end = new Date(info.endStr);
	          end.setDate(end.getDate() - 1);
	          selectedStart = start;
	          selectedEnd = end.toISOString().split('T')[0];
	        },
	        dateClick: function (info) {
	          selectedStart = selectedEnd = info.dateStr;
	        },
	        events: data.map(r => {
	          const memberNo = r.memberNo;
	          if (!memberColorMap[memberNo]) {
	            memberColorMap[memberNo] = colors[colorIndex++ % colors.length];
	          }
	          const end = new Date(r.endDate);
	          end.setDate(end.getDate() + 1);
	          return {
	            start: r.startDate,
	            end: end.toISOString().split('T')[0],
	            rendering: 'background',
	            backgroundColor: memberColorMap[memberNo],
	            title: `예약자: ${r.nickName || '알 수 없음'}`
	          };
	        }),
	        eventDidMount: function (info) {
	          if (info.event.title) {
	            info.el.setAttribute('title', info.event.title);
	          }
	        }
	      });

	      calendar.render();
	    });
	}

function closeCalendar() {
	  const modal = document.getElementById("calendarModal");
	  const content = modal.querySelector(".modal-content");
	  content.classList.remove("active");
	  setTimeout(() => {
	    modal.style.display = "none";
	  }, 250);
	}

function submitReservation() {
	  const memberNo = '${sessionScope.no}';
	  const productNo = '${param.productNo}';

	  console.log("submitReservation 호출됨");
	  console.log("selectedStart:", selectedStart);
	  console.log("selectedEnd:", selectedEnd);

	  if (!selectedStart || !selectedEnd) {
	    alert("먼저 예약할 날짜를 선택해주세요.");
	    return;
	  }

	  const alertMessage = `✅ ${selectedStart} ~ ${selectedEnd} 예약하시겠습니까?`;

	  if (!confirm(alertMessage)) {
	    return;
	  }

	  fetch(contextPath + '/reserveProduct', {
	    method: 'POST',
	    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	    body: new URLSearchParams({
	      memberNo,
	      productNo,
	      startDate: selectedStart,
	      endDate: selectedEnd
	    })
	  })
	    .then(res => res.text())
	    .then(result => {
	      if (result.trim() === 'success') {
	        alert('✅ 예약이 완료되었습니다!');
	        handleDateSelection();
	      } else {
	        alert('❌ 이미 예약된 날짜가 포함되어 있습니다.');
	      }
	    })
	    .catch(err => {
	      console.error("❗ 예약 중 오류 발생:", err);
	      alert('❌ 서버 오류로 인해 예약이 실패했습니다.');
	    });
	}

function handleDateSelection() {
  const productNo = '${param.productNo}';
  const memberNo = '${sessionScope.no}';
  const productStart = '${param.productStart}';
  const productEnd = '${param.productEnd}';

  const form = document.createElement('form');
  form.method = 'GET';
  form.action = contextPath + '/productRentOrder';

  form.innerHTML = `
    <input type="hidden" name="productNo" value="${productNo}">
    <input type="hidden" name="memberNo" value="${memberNo}">
    <input type="hidden" name="startDate" value="${selectedStart}">
    <input type="hidden" name="endDate" value="${selectedEnd}">
    <input type="hidden" name="productStartDate" value="${productStart}">
    <input type="hidden" name="productEndDate" value="${productEnd}">
    <input type="hidden" name="orderType" value="대여">
  `;
  document.body.appendChild(form);
  form.submit();
}
</script>
</body>
</html>
