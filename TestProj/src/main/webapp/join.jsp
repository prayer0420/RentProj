<%@ page contentType="text/html;charset=UTF-8"%>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="css/join.css" />

<div class="container">
	<h2>회원가입</h2>

	<!-- STEP 1 -->
	<div class="step active" id="step1">
		<p>빌리에 오신 것을 환영합니다.</p>
		<div class="checkbox-group">
			<label>
				<input type="checkbox" id="agreeAll"> [전체] 필수동의
			</label> 
			
			<label>
				<input type="checkbox" class="term"> RE:NT 이용약관</label>
			<label>
				<input type="checkbox" class="term"> 전자상거래 표준약관
			</label>
			
			<label>
				<input type="checkbox" class="term"> 개인정보 수집 및 이용 동의
			</label>
			
			<label>
				<input type="checkbox" class="term"> 위치 수집 동의
			</label> 
			
			<label>
				<input type="checkbox" class="term"> 개인정보 처리방침
			</label>
		</div>
		<div class="buttons">
			<button disabled>이전</button>
			<button id="toStep2" class="next-btn">다음</button>
		</div>
	</div>

	<!-- STEP 2 -->
	<div class="step" id="step2">
		<div class="input-group">
			<label for="userId">아이디</label> 
			<input type="text" id="userId" placeholder="아이디를 입력하세요"> 
			
			<label for="password">비밀번호</label>
			<input type="password" id="password" placeholder="비밀번호를 입력하세요">

			<label for="confirmPassword">비밀번호 확인</label> 
			<input type="password" id="confirmPassword" placeholder="비밀번호 확인"> 
			
			<label for="nickname">닉네임</label> 
			<input type="text" id="nickname" placeholder="닉네임을 입력하세요">
			 
			<label for="phone">휴대폰번호</label> 
			<input type="text" id="phone" placeholder="휴대폰 번호를 입력하세요">
			 
			<label for="account">은행/계좌번호</label>
			<div style="display: flex; gap: 10px; align-items: center;">
				<input type="text" id="account" placeholder="계좌번호를 입력하세요" readonly>
				<button type="button" onclick="$('#accountModal').fadeIn();">+</button>
			</div>

			<label for="location">거래지역</label>
			<div style="display: flex; gap: 10px; align-items: center;">
				<input type="text" id="location" placeholder="거래지역을 입력하세요">
				<button type="button">+</button>
			</div>

			<label for="profileImage">프로필 이미지</label>
			<div style="display: flex; align-items: center; gap: 10px;">
				<img id="profilePreview" src="/mnt/data/image.png"
					alt="Profile Preview"
					style="width: 80px; height: 80px; border: 1px solid #ccc; border-radius: 50%; object-fit: cover;">
				<input type="file" name="profileImage" id="profileImage"
					accept="image/*" style="font-size: 10px; padding: 2px;">
			</div>
		</div>
		<div class="buttons">
			<button id="backToStep1">이전</button>
			<button id="toStep3" class="next-btn">다음</button>
		</div>
	</div>

	<!-- STEP 3, 최종 제출 -->
	<div class="step" id="step3">
		<div class="info-confirm" id="confirmInfo"></div>
		<form action="join" method="post" enctype="multipart/form-data">
			<input type="hidden" name="userId" id="fUserId"> <input
				type="hidden" name="password" id="fPassword"> <input
				type="hidden" name="nickname" id="fNickname"> <input
				type="hidden" name="phone" id="fPhone"> <input type="hidden"
				name="account" id="fAccount"> <input type="hidden"
				name="location" id="fLocation">
			<div class="buttons">
				<button type="button" id="backToStep2">이전</button>
				<button type="submit">회원가입 완료</button>
			</div>
		</form>
	</div>
</div>

<!-- Modal for Account -->
<div class="modal" id="accountModal">
	<div class="modal-content">
		<h3>은행/계좌번호 변경</h3>
		<input type="text" id="accountHolder" placeholder="예금주"> 
			<select	id="bankSelect">
				<option value="국민">국민은행</option>
				<option value="신한">신한은행</option>
				<option value="우리">우리은행</option>
			</select> 
		<input type="text" id="accountNumber" placeholder="- 없이 숫자만 입력해주세요">
		<button class="close-modal" id="saveAccount">저장</button>
	</div>
</div>

<script>
    $(function () {
      $("#agreeAll").on("click", function () {
        $(".term").prop("checked", $(this).prop("checked"));
      });

      function goToStep(stepNum) {
        $(".step").removeClass("active");
        $("#step" + stepNum).addClass("active");
      }

      $("#toStep2").on("click", function () {
        goToStep(2);
      });

      $("#backToStep1").on("click", function () {
        goToStep(1);
      });

      $("#toStep3").on("click", function () {
        const userId = $("#userId").val();
        const password = $("#password").val();
        const confirmPassword = $("#confirmPassword").val();
        const nickname = $("#nickname").val();
        const phone = $("#phone").val();
        const account = $("#account").val();
        const location = $("#location").val();

        if (password !== confirmPassword) {
          alert("비밀번호가 일치하지 않습니다.");
          return;
        }

        $("#confirmInfo").html(`
          <p><strong>아이디:</strong> ${userId}</p>
          <p><strong>닉네임:</strong> ${nickname}</p>
          <p><strong>휴대폰번호:</strong> ${phone}</p>
          <p><strong>계좌번호:</strong> ${account}</p>
          <p><strong>거래지역:</strong> ${location}</p>
        `);

        $("#fUserId").val(userId);
        $("#fPassword").val(password);
        $("#fNickname").val(nickname);
        $("#fPhone").val(phone);
        $("#fAccount").val(account);
        $("#fLocation").val(location);

        goToStep(3);
      });

      $("#backToStep2").on("click", function () {
        goToStep(2);
      });

      // 계좌 정보 저장
      $("#saveAccount").on("click", function () {
        const bank = $("#bankSelect").val();
        const number = $("#accountNumber").val();
        if (!number || isNaN(number)) {
          alert("계좌번호는 숫자만 입력해주세요.");
          return;
        }
        $("#account").val(`${bank} / ${number}`);
        $("#accountModal").fadeOut();
      });
      
      // 모달 밖 클릭 시 닫기
      $("#accountModal").on("click", function (e) {
        if (e.target.id === "accountModal") {
          $(this).fadeOut();
        }
      });
      
      //프로필 이미지
      $(function () {
         $('#profileImage').on('change', function (e) {
           const reader = new FileReader();
           reader.onload = function (event) {
             $('#profilePreview').attr('src', event.target.result);
           };
           if (e.target.files[0]) {
             reader.readAsDataURL(e.target.files[0]);
           }
         });
       });
    });
    
  </script>