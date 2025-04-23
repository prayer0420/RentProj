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

        <label>거래지역</label>
        <button type="button" id="regionPostSearch">➕ 지역 추가</button>
        <input type="hidden" name="region1" id="region1">
        <input type="hidden" name="region2" id="region2">
        <input type="hidden" name="region3" id="region3">
        <div id="regionList"></div>

        <label>배송지 입력</label>
        <button type="button" id="addrPostSerach">➕ 배송지 추가</button>
        <div id="addressList"></div>
				<div class="input">
					<input type="text" id="addAlias" name="addrAlias" placeholder="배송지명">
					<input type="text" id="postcode" name="postcode" placeholder="우편번호">
					<input type="text" id="address" name="address" placeholder="주소">
					<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소">
				</div>
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
    // 약관 전체동의
    //prop: HTML요소의 속성 값을 읽거나 설정, 
    //.term(체크박스)의 속성을 #agreeAll의 체크상태와 똑같이 설정
    $('#agreeAll').on('click', function () {
      $('.term').prop('checked', $(this).prop('checked'));
    });

    // step1 → step2 이동
    $('#toStep2').on('click', function () {
    	//: 필터선택, 체크박스에서 선택된 것 
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

    // 비밀번호 확인
    $('form').on('submit', function () {
      const pw = $('#password').val();
      const confirm = $('#confirmPassword').val();
      if (pw !== confirm) {
        alert("비밀번호가 일치하지 않습니다.");
        return false;
      }
      
      // 필수 입력값이 비어 있으면 submit 중단
      const requiredFields = ['#userId', '#password', '#confirmPassword', '#name', '#nickname', '#phone', '#postcode', '#address', '#detailAddress', '#addAlias'];
      for (const selector of requiredFields) {
        if ($(selector).val().trim() === '') {
          alert("모든 필수 정보를 입력해주세요.");
          $(selector).focus();
          return false;
        }
      }

      // 거래지역 최소 1개 등록 필수
      if (selectedRegions.length === 0) {
        alert("거래지역을 최소 1개 이상 등록해주세요.");
        return false;
      }
      
      return true;
    });
	
	$('#addrPostSerach').click(function(){
		new daum.Postcode({
			oncomplete : function(data){
				console.log(data);
				//팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				
				//각 주소의 노출 규칙에 따라 주소를 조합한다.
				//내려오는 변수 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기한다.
				var addr =''; //주소변수
				var detailAddr =''; //참고항목 변수
				
				//사용자가 선택한 주소 타입에 따라 해당주소 값을 가져온다.
				if(data.userSelectedType === 'R') {
					//사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				}else{
					//사용자가 지번주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}
				//우편번호와 주소정보를 해당 필드에 넣는다.
				$('#postcode').val(data.zonecode);
				$('#address').val(addr);
				//커서를 상세주소 필드로 이동한다.
				$('#detailAddress').focus();
			}
		}).open();
	})
	
	$('#regionPostSearch').click(function() {
				new daum.Postcode({
					oncomplete : function(data) {
						const region = data.sido + " " + data.sigungu;
						if (selectedRegions.includes(region)) {
							alert("이미 등록된 지역입니다.");
							return;
						}
						if (selectedRegions.length >= 3) {
							alert("최대 3개까지만 등록할 수 있습니다.");
							return;
						}
						selectedRegions.push(region);
						updateRegionList();
					}
				}).open();
			});
  });
  
  function updateRegionList() {
		
		const $regionList = $('#regionList');
	    $regionList.empty();
		
	    $.each(selectedRegions, function (i, region) {
			//Jqeury방식
			const $div = $('<div>').text(region);
			 const $button = $('<button type="button">❌</button>')
		        .addClass('delete-btn')
		        .on('click', function () {
		          removeRegion(i);
		        });
			$div.append($button);
			$regionList.append($div);
	    });
	    
		for (let j = 0; j < 3; j++) {
			$('#region'+(j+1)).val(selectedRegions[j]|| '');
		}
	}

	function removeRegion(index) {
		// 선택된 지역 배열에서 해당 인덱스를 제거
		selectedRegions.splice(index, 1);
		updateRegionList();
	}
	
	//엔터금지
	$('form').on('keypress', function (e) {
		  if (e.key === 'Enter') {
		    e.preventDefault();
		    return false;
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

  initializeApp(firebaseConfig);
  const messaging = getMessaging();

  const requestForToken = () => {
    getToken(messaging, {
      vapidKey: 'BKf2ZnmnAxGrBS6VogRScPinuISeM-n_I7Dn4k-4uSZ7FxAjeJCFxg7tJMFfZ0HvlKCeH4qv85F8L7r4rdweVT8'
    }).then((currentToken) => {
      if (currentToken) {
      	document.getElementById("fcmToken").value = currentToken;
        $.post("fcmToken", { fcmToken: currentToken });
      }
    }).catch(console.error);

    onMessageListener();
  };

  const onMessageListener = () => {
    onMessage(messaging, (payload) => {
      const alarm = payload.data;
      $("#alarmModal").css("display", "flex");
      $("#alarmList .alarm-empty").remove(); // 알림 없을 때 텍스트 제거

      const alarmHTML = `
        <div class="alarm-card" data-num="${alarm.no}">
          <div class="alarm-top">
            <h4 class="alarm-title">${alarm.title}</h4>
            <button class="delete-btn" onclick="deleteAlarm(this)">✕</button>
          </div>
          <p class="alarm-body">${alarm.content}</p>
        </div>`;
      $("#alarmList").prepend(alarmHTML);
    });
  };

  requestForToken();
</script>

</body>
</html>
