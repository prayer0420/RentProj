<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet" href="css/accountModal.css" />

<div id="bankModal">
	<div class="modal-wrapper">
		<h2>은행/계좌번호 변경</h2>
		<p class="notice">구매 확정일 2일 이내에 계좌 변경이 이루어진 경우 변경 이전 계좌로 입급될 수
			있습니다.</p>

		<!-- 변경전 -->
		<div class="section">
			<h4>변경전</h4>
			<div class="row">
				<label>은행/계좌번호:</label> 
				<span id="beforeAccount">${accountInfo.bank} ${accountInfo.account}</span>
			</div>
			<div class="row">
				<label>예금주:</label> 
				<span id="beforeOwner">${accountInfo.owner}</span>
			</div>
		</div>

		<!-- 변경 후 -->
		<div class="section">
			<h4>변경 후</h4>
			<div class="row">
				<label>예금주 *</label> <input type="text" id="accountOwner"
					placeholder="예금주를 입력하세요">
			</div>

			<div class="row">
				<label>은행 *</label> <select id="selectBank">
					<option value="">선택</option>
					<option>국민</option>
					<option>신한</option>
					<option>우리</option>
					<option>카카오</option>
					<option>농협</option>
					<option>롯데</option>
				</select>
			</div>

			<div class="row">
				<label>계좌번호 *</label> <input type="text" id="inputAccount"
					placeholder="숫자만 입력해주세요">
			</div>
		</div>

		<!-- 버튼 -->
		<div class="btn-row">
			<button class="btn confirm" onclick="applyBankInfo()">확인</button>
			<button class="btn cancel" onclick="closeBankModal()">취소</button>
		</div>
	</div>
</div>

<script>
	function applyBankInfo() {
		const owner = document.getElementById("accountOwner").value;
		const bank = document.getElementById("selectBank").value;
		const account = document.getElementById("inputAccount").value;

		if (!owner || !account || !bank) {
			alert("예금주와 계좌번호를 입력해주세요.");
			return;
		}

		// 개인정보 수정 페이지에 있는 input에 넣기
		document.querySelector("input[name='account']").value = bank + " "	+ account;
		document.querySelector("input[name='owner']").value = owner;

		closeBankModal();
	}

	function closeBankModal() {
		document.getElementById("bankModal").style.display = "none";
	}
</script>
