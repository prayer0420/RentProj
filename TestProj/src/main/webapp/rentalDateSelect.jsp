<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>대여 날짜 선택</title>

<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css"
	rel="stylesheet" />
<link rel="stylesheet" href="css/rental.css" />

</head>
<body>
	<div class="modal-overlay" id="rentalModal">
		<div class="calendar-modal">
			<div class="calendar-container">
				<h2>대여 날짜 선택</h2>
				<p>아래에서 대여 가능한 날짜를 선택해주세요.</p>

				<div id="calendar"></div>

				<div class="price-summary">
					<p>
						선택 기간: <span id="selected-range">없음</span>
					</p>
					<p>
						대여 금액: <strong id="price">₩0</strong>
					</p>
					<p>
						보증금: <strong>₩30,000</strong>
					</p>
				</div>

				<form action="order.jsp" method="post" id="rentalForm">
					<input type="hidden" name="startDate" id="startDate"> 
					<input type="hidden" name="endDate" id="endDate"> 
					<input type="hidden" name="totalPrice" id="totalPrice">
						<div class="btns">
							<button type="button" onclick="closeRentalModal()">취소</button>
							<button type="submit">확인</button>
						</div>
				</form>
			</div>
		</div>
	</div>
<script>
  let calendar;
  
  const pricePerDay = 8000;
  const deposit = 30000;

  document.addEventListener('DOMContentLoaded', function () {
    const calendarEl = document.getElementById('calendar');
    calendar = new FullCalendar.Calendar(calendarEl, {
      selectable: true,
      initialView: 'dayGridMonth',
      locale: 'ko',
      select: function(info) {
        const start = new Date(info.startStr);
        const end = new Date(info.endStr);
        const dayCount = (end - start) / (1000 * 60 * 60 * 24); // exclude end day

        if (dayCount <= 0) {
          alert("올바른 날짜 범위를 선택하세요.");
          return;
        }

        const formattedEnd = new Date(end - 1).toISOString().slice(0, 10);
        document.getElementById("selected-range").textContent = `${info.startStr} ~ ${formattedEnd}`;
        document.getElementById("startDate").value = info.startStr;
        document.getElementById("endDate").value = info.endStr;
        const total = dayCount * pricePerDay;
        document.getElementById("price").textContent = `${total.toLocaleString()}`;
        document.getElementById("totalPrice").value = total;
      },
      events: [
        {
          start: '2025-05-01',
          end: '2025-05-04',
          display: 'background',
          color: '#ff9999'
        },
        {
          start: '2025-05-20',
          end: '2025-05-22',
          display: 'background',
          color: '#ff9999'
        }
      ]
    });
    calendar.render();
  });
  
</script>


</body>
</html>
