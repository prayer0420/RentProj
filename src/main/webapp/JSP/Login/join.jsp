<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Login/join.css" />
  <script	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  
</head>

<body>
<div class="container">
  <h2>회원가입</h2>

  <!-- STEP 1: 약관 동의 -->
  <div class="step" id="step1">
    <p>빌리에 오신 것을 환영합니다.</p>
    <div class="checkbox-group">
      <label><input type="checkbox" id="agreeAll"> [전체] 필수동의</label>
      <label><input type="checkbox" class="term"> RE:NT 이용약관</label>
      <label><input type="checkbox" class="term"> 전자상거래 표준약관</label>
      <label><input type="checkbox" class="term"> 개인정보 수집 및 이용 동의</label>
      <label><input type="checkbox" class="term"> 위치 수집 동의</label>
      <label><input type="checkbox" class="term"> 개인정보 처리방침</label>
    </div>
    <div class="buttons">
      <button id="toStep2">다음</button>
    </div>
  </div>

  <!-- STEP 2: 정보 입력 -->
  <div class="step" id="step2" style="display: none;">
    <form action="join" method="post">
      <div class="input-group">
        <label for="userId">아이디</label>
        <div class="input-inline">
          <input type="text" id="userId" name="id" placeholder="아이디를 입력하세요">
          <button type="button" id="doubleId">중복 확인</button>
        </div>

        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요">

        <label for="confirmPassword">비밀번호 확인</label>
        <input type="password" id="confirmPassword" placeholder="비밀번호 확인">

		<label for="name">이름</label>
        <input type="text" id="name" name="name" placeholder="이름을 입력하세요">

        <label for="nickname">닉네임</label>
        <input type="text" id="nickname" name="nickname" placeholder="닉네임을 입력하세요">

        <label for="phone">휴대폰번호</label>
        <input type="text" id="phone" name="phone" placeholder="휴대폰 번호를 입력하세요">

        <label>배송지 입력</label>
        <button type="button" id="addrPostSerach">➕ 배송지 추가</button>
        <div id="addressList"></div>
		<div class="input">
			<input type="text" id="addAlias" name="addrAlias" placeholder="배송지명">
			<input type="text" id="postcode" name="postcode" placeholder="우편번호">
			<input type="text" id="address" name="address" placeholder="주소">
			<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소">
		</div>
		<input type="hidden" name="profileImage" value="/CSS/img/profileImage2.png">
		<input type="hidden" id="fcmToken" name="fcmToken" />
      	</div>
      <div class="buttons">
        <button type="submit">회원가입 완료</button>
      </div>
    </form>
  </div>
</div>

<script>
  const selectedRegions = [];

  $(function () {
    // 전체 동의 체크박스
    $('#agreeAll').on('click', function () {
      $('.term').prop('checked', $(this).prop('checked'));
    });

    // Step1 → Step2로 이동
    $('#toStep2').on('click', function () {
      if ($('.term:checked').length < $('.term').length) {
        alert('모든 약관에 동의해주세요.');
        return;
      }
      $('#step1').hide();
      $('#step2').show();
    });

    // 아이디 중복 확인
    $('#doubleId').click(function (e) {
      e.preventDefault();
      $.ajax({
        url: 'memberDoubleId',
        type: 'post',
        dataType: 'text',
        data: {
          id: $('#userId').val()
        },
        success: function (result) {
          if (result === 'false') {
            alert("사용중인 아이디 입니다.");
          } else if (result === 'true') {
            alert("사용가능한 아이디 입니다.");
          } else {
            alert(result);
          }
        },
        error: function (err) {
          console.log(err);
          alert("에러 발생: " + err.status);
        }
      });
    });

    // 엔터 금지
    $('form').on('keypress', function (e) {
      if (e.key === 'Enter') {
        e.preventDefault();
        return false;
      }
    });
  });

  // 주소 검색 버튼 클릭 시
  $('#addrPostSerach').click(function () {
    new daum.Postcode({
      oncomplete: function (data) {
        let addr = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
        $('#postcode').val(data.zonecode);
        $('#address').val(addr);
        $('#detailAddress').focus();
      }
    }).open();
  });

  // 비밀번호 확인 및 필수 입력 체크
  $('form').on('submit', function () {
    const pw = $('#password').val();
    const confirm = $('#confirmPassword').val();
    if (pw !== confirm) {
      alert("비밀번호가 일치하지 않습니다.");
      return false;
    }

    const requiredFields = [
      '#userId', '#password', '#confirmPassword',
      '#name', '#nickname', '#phone',
      '#postcode', '#address', '#detailAddress', '#addAlias'
    ];

    for (const selector of requiredFields) {
      if ($(selector).val().trim() === '') {
        alert("모든 필수 정보를 입력해주세요.");
        $(selector).focus();
        return false;
      }
    }
  });
</script>


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

  const app = initializeApp(firebaseConfig);
  const messaging = getMessaging(app);

  //알림 권한 요청 → 허용 시 서비스워커 등록 및 토큰 요청
  Notification.requestPermission().then(permission => {
    if (permission === 'granted') {
      navigator.serviceWorker.register("/rent/firebase-messaging-sw.js")
        .then((registration) => {
          console.log("서비스워커 등록 완료:", registration);

          return getToken(messaging, {
            vapidKey: "BKf2ZnmnAxGrBS6VogRScPinuISeM-n_I7Dn4k-4uSZ7FxAjeJCFxg7tJMFfZ0HvlKCeH4qv85F8L7r4rdweVT8",
            serviceWorkerRegistration: registration
          });
        })
        .then((currentToken) => {
          if (currentToken) {
            document.getElementById("fcmToken").value = currentToken;
            console.log("FCM Token:", currentToken);
          } else {
            console.warn("토큰이 없습니다. 권한이 없거나 사용자 거부");
          }
        })
        .catch((err) => {
          console.error("토큰 요청 실패:", err);
        });

      // 메시지 수신 처리
      onMessage(messaging, (payload) => {
        console.log("Foreground 메시지 수신됨:", payload);
      });

    } else {
      console.warn("알림 권한이 거부되었습니다:", permission);
    }
  });
</script>

</body>
</html>
