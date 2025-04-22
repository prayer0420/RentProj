<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="css/addressAdd.css" />

<div class="modal" id="addressAddModal" style="display: none;">
  <div class="modal-content">
    <button class="close" onclick="closeAddressAddModal()">×</button>
    <h3>배송지 추가 <span style="color: red; font-size: 14px;">* 필수 항목</span></h3>
    <form action="addAddress.do" method="post" id="modalAddressForm">

      <label>배송지명 <span style="color: red;">*</span></label>
      <input type="text" name="alias" placeholder="최대 10자" maxlength="10" required />

      <label>이름 <span style="color: red;">*</span></label>
      <input type="text" name="recipient" placeholder="수령인" required />

      <label>연락처 <span style="color: red;">*</span></label>
      <input type="text" name="phone" placeholder="전화번호" required />

      <label>주소 <span style="color: red;">*</span></label>
      <div class="zip-code-group">
        <input type="text" name="zipcode" placeholder="우편번호" required readonly />
        <button type="button" class="zip-btn" onclick="execDaumPostcode()">우편번호</button>
      </div>
      <input type="text" name="address" placeholder="주소" required readonly />
      <input type="text" name="detail" placeholder="상세주소를 입력해주세요" />

      <label>배송메모</label>
      <select name="memo" required>
        <option value="">선택해주세요.</option>
        <option value="문 앞에 놔주세요">문 앞에 놔주세요</option>
        <option value="배송 전 연락주세요">배송 전 연락주세요</option>
        <option value="경비실에 맡겨주세요">경비실에 맡겨주세요</option>
        <option value="기타">기타</option>
      </select>

      <label>공동현관 출입방법</label>
      <div class="entry-group">
        <label><input type="radio" name="entryType" value="공동현관 비밀번호" checked /> 공동현관 비밀번호</label>
        <input type="text" name="entryCode" placeholder="입력해주세요" />
        <p class="entry-tip">
          ○ 입력이 필요한 모든 숫자와 특수 기호를 정확하게 입력해주세요. (예: 1111 또는 11#1234)<br>
          ○ 기본 출입번호로 진입이 어려운 경우, 1층 공동현관 앞 또는 경비실로 요청할 수 있습니다.
        </p>
        <label><input type="radio" name="entryType" value="자유 출입 가능" /> 자유 출입 가능</label>
      </div>

      <label><input type="checkbox" name="isDefault" value="true" /> 기본 배송지로 등록하기</label>

      <button type="submit">추가</button>
    </form>
  </div>
</div>

<script>
  function closeAddressAddModal() {
    document.getElementById('addressAddModal').style.display = 'none';
  }
  
  function execDaumPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        document.querySelector("input[name='zipcode']").value = data.zonecode;
        document.querySelector("input[name='address']").value = data.roadAddress;
        document.querySelector("input[name='detail']").focus();
      }
    }).open();
  }
</script>
