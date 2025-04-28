<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- FullCalendar CDN -->
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>

<title>Insert title here</title>
</head>
<body>
<div id="calendarModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background-color:rgba(0,0,0,0.5); justify-content:center; align-items:center; z-index:9999;">
  <div style="background:white; padding:20px; width:80%; height:80%;">
    <button onclick="closeCalendar()">❌ 닫기</button>
    <div id="calendar"></div>
  </div>
</div>
</body>
<script>
function openCalendar() {
	  document.getElementById('calendarModal').style.display = 'flex';

	  // 모달이 열릴 때 FullCalendar를 렌더링
	  let calendarEl = document.getElementById('calendar');
	  let calendar = new FullCalendar.Calendar(calendarEl, {
	    initialView: 'dayGridMonth',
	    locale: 'ko',
	    events: '/getRentalDates?productNo=${product.no}' // 예약된 날짜 가져오기
	  });
	  calendar.render();
	}

	function closeCalendar() {
	  document.getElementById('calendarModal').style.display = 'none';
	}
</script>
</html>