<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대여 캘린더</title>
<script>const contextPath = "${pageContext.request.contextPath}";</script>

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
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	justify-content: center;
	align-items: center;
	z-index: 9999;
}

#calendarWrapper {
	background: white;
	padding: 20px;
	width: 800px;
	height: 800px;
	box-sizing: border-box;
	overflow-y: auto;
}

.fc {
	font-size: 14px;
}

#calendar {
	max-width: 100%;
	height: auto;
}
</style>
</head>

<body>
	<div id="calendarModal">
		<div id="calendarWrapper">
			<button onclick="closeCalendar()">X</button>
			<p style="margin-bottom: 10px;">
				📅 대여 가능 시작일: <strong id="availableStart"></strong> <span>~</span>
				대여 가능 종료일: <strong id="availableEnd"></strong>
			</p>
			<button onclick="submitReservation()">✅ 예약하기</button>
			<div id="calendar"></div>

			<!-- JSTL로 전달된 파라미터 저장 -->
			<c:set var="productStart" value="${param.productStart}" />
			<c:set var="productEnd" value="${param.productEnd}" />
			<c:set var="productNo" value="${param.productNo}" />
		</div>
	</div>

<script>
	let calendar = null;
	let selectedStart = null;
	let selectedEnd = null;
	let reservedRanges = [];

	function openCalendar() {
	  document.getElementById('calendarModal').style.display = 'flex';

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
	        end.setDate(end.getDate()); // inclusive
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
	        height: 'auto',
	        initialDate: productStart,
	        selectable: true,
	        selectMirror: true,

	        select: function(info) {
	          const selectedRangeStart = new Date(info.startStr);
	          const selectedRangeEnd = new Date(info.endStr);
	          selectedRangeEnd.setDate(selectedRangeEnd.getDate() - 1);

	          const isOverlapping = reservedRanges.some(r =>
	            selectedRangeStart <= r.end && selectedRangeEnd >= r.start
	          );
	          if (isOverlapping) {
	        	    alert('❌ 이미 예약된 날짜가 포함되어 있습니다.');
	        	    selectedStart = null;
	        	    selectedEnd = null;
	        	    return;
	        	  }

	          // ✅ 단순히 날짜 저장만 (alert 띄우지 않음)
	          selectedStart = info.startStr;
	          selectedEnd = selectedRangeEnd.toISOString().split('T')[0];

	          console.log("✅ 선택된 날짜:", selectedStart, "~", selectedEnd);
	        },

	        validRange: {
	          start: productStart,
	          end: productEnd
	        },

	        events: data.map(r => {
	          const memberNo = r.memberNo;
	          if (!memberColorMap[memberNo]) {
	            memberColorMap[memberNo] = colors[colorIndex % colors.length];
	            colorIndex++;
	          }
	          const endObj = new Date(r.endDate);
	          endObj.setDate(endObj.getDate() + 1);
	          return {
	            start: r.startDate,
	            end: endObj.toISOString().split('T')[0],
	            rendering: 'background',
	            backgroundColor: memberColorMap[memberNo],
	            title: `예약자: ${r.nickName || '알 수 없음'}`
	          };
	        }),

	        eventDidMount: function(info) {
	          if (info.event.title) {
	            info.el.setAttribute('title', info.event.title);
	          }
	        }
	      });

	      calendar.render();
	    });
	}

	function closeCalendar() {
	  document.getElementById('calendarModal').style.display = 'none';
	}

	function submitReservation() {
		  const memberNo = '${sessionScope.no}';
		  const productNo = '${param.productNo}';

		  if (!selectedStart || !selectedEnd) {
		    alert("먼저 예약할 날짜를 선택해주세요.");
		    return;
		  }

		  if (!confirm(`${selectedStart} ~ ${selectedEnd} 예약하시겠습니까?`)) {
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
		        handleDateSelection(); // 결제 페이지로 이동
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
