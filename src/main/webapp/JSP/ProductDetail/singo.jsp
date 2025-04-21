<%@ page contentType="text/html;charset=UTF-8"%>

<div class="report" id="reportBox">
	<h3>신고하기</h3>
	<select id="reportType">
		<option value="">신고 유형</option>
		<option>거래금지물품이에요</option>
		<option>콘텐츠 내용이 불쾌해요</option>
		<option>사기가 의심돼요</option>
	</select> <input type="text" id="reportTitle" placeholder="제목">
	<textarea id="reportContent" placeholder="신고 내용을 입력하세요"></textarea>
	<div class="error-text hidden" id="errorMsg">모든 항목을 입력해주세요.</div>
	<button class="btn-submit" onclick="validateReport()">신고하기</button>
</div>

<!-- 확인창 -->
<div class="report hidden" id="confirmBox">
	<div class="confirm-box">
		<h3>신고하기</h3>
		<p>
			신고 내용은 부적절한 이용자 및 물품에 대해<br>사회적인 경고 및 필요시 제재가<br>이루어질 수
			있습니다.
		</p>
		<button class="cancel" onclick="goBack()">취소</button>
		<button class="ok" onclick="submitReport()">확인</button>
	</div>
</div>

<!-- 완료창 -->
<div class="report hidden" id="completeBox">
	<div class="complete-box">
		<h3>신고가 완료되었습니다</h3>
		<p>귀하의 소중한 신고 감사합니다.</p>
		<button class="close" onclick="closereport()">확인</button>
	</div>
</div>

<script>
function validateReport() {
    const type = document.getElementById('reportType').value;
    const title = document.getElementById('reportTitle').value.trim();
    const content = document.getElementById('reportContent').value.trim();
    const error = document.getElementById('errorMsg');

    if (!type || !title || !content) {
      error.textContent = "모든 항목을 입력해주세요.";
      error.classList.remove("hidden");
      return;
    }

    // 금칙어 예시
    const bannedWords = ['욕설', '비방', '사기', '개인정보'];
    const hasBan = bannedWords.some(word => content.includes(word));

    if (hasBan) {
      error.textContent = "ex) 개인정보를 물어보고 말투가 이상해요";
      error.classList.remove("hidden");
      return;
    }

    error.classList.add("hidden");
    document.getElementById('reportBox').classList.add('hidden');
    document.getElementById('confirmBox').classList.remove('hidden');
  }

  function goBack() {
    document.getElementById('confirmBox').classList.add('hidden');
    document.getElementById('reportBox').classList.remove('hidden');
  }

  function submitReport() {
    // 실제 신고 데이터 서버 전송은 여기에서 AJAX나 form 제출로 처리
    document.getElementById('confirmBox').classList.add('hidden');
    document.getElementById('completeBox').classList.remove('hidden');
  }

  function closereport() {
    alert("신고창 닫기 또는 새로고침 등 처리");
    location.reload(); // 예시로 새로고침 처리
  }
</script>