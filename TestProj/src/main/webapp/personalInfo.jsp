<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>개인정보 수정</title>
<style>
</style>
</head>
<body>
	<div class="form-wrapper">
		<div class="form-title">개인정보 수정</div>

		<div class="form-group">
			<label>아이디</label> <input type="text" value="appleee22" readonly />
		</div>

		<div class="form-group">
			<label>비밀번호</label> <input type="password" placeholder="비밀번호를 입력하세요" />
		</div>

		<div class="form-group">
			<label>비밀번호 확인</label> <input type="password"
				placeholder="비밀번호를 다시 입력하세요" />
		</div>

		<div class="form-group">
			<label>닉네임</label> <input type="text" placeholder="닉네임 입력" />
		</div>

		<div class="form-group">
			<label>휴대폰번호</label> <input type="tel" placeholder="010-1234-5678" />
		</div>

		<div class="form-group">
			<label>은행/계좌번호</label>
			<div class="account-row">
				<input type="hidden" name="owner" value="" /> <input type="text"
					placeholder="예: 국민 753****8423" name="account" readonly="" />
				<button type="button" class="btn confirm" style="padding: 8px 14px;"
					onclick="openBankModal()">등록</button>
			</div>
		</div>

		<div class="form-group">
			<label>거래지역</label>
			<button type="button" id="postSearch">➕ 주소 검색</button>
			<div id="regionList"></div>
			<input type="hidden" name="region1" id="region1" /> 
			<input type="hidden" name="region2" id="region2" /> 
			<input type="hidden" name="region3" id="region3" />
		</div>

		<div class="form-group">
			<label>프로필 이미지</label>
			<div class="profile-upload">
				<img src="https://cdn-icons-png.flaticon.com/512/149/149071.png"
					alt="프로필 이미지" /> <input type="file" />
			</div>
		</div>

		<div class="btn-row">
			<button class="btn cancel">취소</button>
			<button class="btn confirm">확인</button>
		</div>
	</div>
	
	<jsp:include page="accountModal.jsp" />

	<script	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		const selectedRegions = [];

		document.getElementById("postSearch").addEventListener("click",
				function() {
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

		function removeRegion(index) {
			selectedRegions.splice(index, 1);
			updateRegionList();
		}

		function updateRegionList() {
			const regionList = document.getElementById("regionList");
			regionList.innerHTML = "";

			for (let i = 0; i < selectedRegions.length; i++) {
				const region = selectedRegions[i];

				const div = document.createElement("div");
				//텍스트 노드를 따로 생성해서 붙이기
				const text = document.createTextNode(region);
				div.appendChild(text);

				// ❌ 버튼
				const button = document.createElement("button");
				button.innerHTML = "❌";
				button.className = "delete-btn";
				button.onclick = function() {
					removeRegion(i);
				};

				div.appendChild(button);
				regionList.appendChild(div);
			}

			for (let j = 0; j < 3; j++) {
				document.getElementById("region" + (j + 1)).value = selectedRegions[j]|| "";
			}
		}
		/*accountModal 관련*/
		function openBankModal() {
			document.getElementById("bankModal").style.display = "block";
		}
	</script>
</body>
</html>
