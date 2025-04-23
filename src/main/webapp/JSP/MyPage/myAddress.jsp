<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>배송지 관리</title>
  <!-- 스타일시트 링크 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/mypage/myAddress.css">
  <!-- jQuery 및 다음 주소 API -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
  <div class="wrapper">
    <div class="container">

      <!-- 마이페이지 사이드바 포함 -->
      <jsp:include page="/JSP/MyPage/mypageSidebar.jsp" />

      <!-- 본문 영역 시작 -->
      <section class="content">
        <h2>배송지 관리</h2>
        <div class="divider"></div>

        <!-- 배송지 추가 버튼 -->
        <div class="address-header">
          <button class="add-address-btn" onclick="toggleModal('addModal')">
            배송지 추가
          </button>
        </div>

        <!-- 배송지 목록 출력 -->
        <div class="address-list">
          <c:choose>
            <c:when test="${not empty addressList}">
              <!-- 등록된 주소가 있으면 반복 출력 -->
              <c:forEach var="addr" items="${addressList}">
                <div class="product-card">
                  <div class="order-info">
                    <div class="order-meta">
                      <span class="order-number">배송지명: ${addr.alias}</span>
                      <!-- 기본배송지 표시 배지 -->
                      <c:if test="${addr.defaultAddress}">
                        <span class="badge">기본배송지</span>
                      </c:if>
                    </div>

                    <!-- 수정 및 삭제 버튼 영역 -->
                    <div class="order-status-area">
                      <!-- 수정 버튼 클릭 시 모달 오픈 -->
                      <button class="edit-btn"
                        onclick="openEditModal(
                          '${addr.alias}', 
                          '${addr.zipcode}', 
                          '${addr.address}', 
                          '${addr.detail}', 
                          '${addr.recipient}', 
                          '${addr.phone}', 
                          '${addr.defaultAddress}'
                        )">수정</button>

                      <!-- 삭제 form: POST 방식으로 주소 삭제 -->
                      <form method="post" action="myAddress">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="alias" value="${addr.alias}">
                        <input type="hidden" name="zipcode" value="${addr.zipcode}">
                        <input type="hidden" name="address" value="${addr.address}">
                        <input type="hidden" name="detail" value="${addr.detail}">
                        <button type="submit" class="delete-btn">삭제</button>
                      </form>
                    </div>
                  </div>

                  <div class="card-divider"></div>

                  <!-- 주소 상세 정보 -->
                  <div class="card-content">
                    <div class="product-info">
                      <p><strong>수령인:</strong> ${addr.recipient}</p>
                      <p><strong>연락처:</strong> ${addr.phone}</p>
                      <p><strong>주소:</strong> ${addr.zipcode} ${addr.address} ${addr.detail}</p>
                    </div>
                  </div>
                </div>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <!-- 주소 없을 경우 표시 -->
              <p class="empty-text">등록된 배송지가 없습니다.</p>
            </c:otherwise>
          </c:choose>
        </div>
      </section>
    </div>
  </div>

  <!-- 주소 추가 모달 -->
  <div class="modal" id="addModal" style="display: none;">
    <div class="modal-content">
      <div class="modal-header">
        <h3>배송지 추가</h3>
        <button class="close" onclick="toggleModal('addModal')">&times;</button>
      </div>
      <form method="post" action="myAddress" onsubmit="return validateForm('add')">
        <input type="hidden" name="action" value="add">
        <!-- 입력 항목들 -->
        <label>배송지명</label>
        <input type="text" name="alias" id="addAlias">
        <label>우편번호</label>
        <div class="zip-code-group">
          <input type="text" name="zipcode" id="addZipcode" readonly>
          <button type="button" onclick="searchZip('addZipcode', 'addAddress')">검색</button>
        </div>
        <label>주소</label>
        <input type="text" name="address" id="addAddress" readonly>
        <label>상세주소</label>
        <input type="text" name="detail" id="addDetail">
        <label>수령인</label>
        <input type="text" name="recipient" id="addRecipient">
        <label>연락처</label>
        <input type="text" name="phone" id="addPhone">
        <!-- 기본배송지 체크 -->
        <label><input type="checkbox" name="isDefault" value="true"> 기본 배송지로 설정</label>

        <div class="btn-row">
          <button type="button" onclick="toggleModal('addModal')">취소</button>
          <button type="submit">등록</button>
        </div>
      </form>
    </div>
  </div>

  <!-- 주소 수정 모달 -->
  <div class="modal" id="editModal" style="display: none;">
    <div class="modal-content">
      <div class="modal-header">
        <h3>배송지 수정</h3>
        <button class="close" onclick="toggleModal('editModal')">&times;</button>
      </div>
      <form method="post" action="myAddress" onsubmit="return validateForm('edit')">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="oldAlias" id="editOldAlias">
        <!-- 기존 주소 정보 입력란 -->
        <label>배송지명</label>
        <input type="text" name="alias" id="editAlias">
        <label>우편번호</label>
        <div class="zip-code-group">
          <input type="text" name="zipcode" id="editZipcode" readonly>
          <button type="button" onclick="searchZip('editZipcode', 'editAddress')">검색</button>
        </div>
        <label>주소</label>
        <input type="text" name="address" id="editAddress" readonly>
        <label>상세주소</label>
        <input type="text" name="detail" id="editDetail">
        <label>수령인</label>
        <input type="text" name="recipient" id="editRecipient">
        <label>연락처</label>
        <input type="text" name="phone" id="editPhone">
        <!-- 체크 여부는 openEditModal에서 지정 -->
        <label><input type="checkbox" name="isDefault" id="editIsDefault" value="true"> 기본 배송지로 설정</label>

        <div class="btn-row">
          <button type="button" onclick="toggleModal('editModal')">취소</button>
          <button type="submit">수정</button>
        </div>
      </form>
    </div>
  </div>

  <!-- JavaScript 로직 -->
  <script>
    // 모달 열고 닫는 함수
    function toggleModal(id) {
      if (id === 'addModal') {
        // 주소 최대 3개 제한
        const count = document.querySelectorAll('.product-card').length;
        if (count >= 3) {
          alert("배송지는 최대 3개까지만 등록 가능합니다.");
          return;
        }
      }
      const modal = document.getElementById(id);
      modal.style.display = modal.style.display === 'flex' ? 'none' : 'flex';
    }

    // 수정 버튼 클릭 시 모달에 값 세팅
    function openEditModal(alias, zipcode, address, detail, recipient, phone, isDefault) {
      document.getElementById("editOldAlias").value = alias;
      document.getElementById("editAlias").value = alias;
      document.getElementById("editZipcode").value = zipcode;
      document.getElementById("editAddress").value = address;
      document.getElementById("editDetail").value = detail;
      document.getElementById("editRecipient").value = recipient;
      document.getElementById("editPhone").value = phone;
      // 문자열 'true'인 경우 체크됨
      document.getElementById("editIsDefault").checked = (isDefault === 'true');
      toggleModal("editModal");
    }

    // 다음 우편번호 검색 API 연동
    function searchZip(zipFieldId, addrFieldId) {
      new daum.Postcode({
        oncomplete: function(data) {
          document.getElementById(zipFieldId).value = data.zonecode;
          document.getElementById(addrFieldId).value = data.roadAddress;
        }
      }).open();
    }

    // 모든 입력값 검증 (빈 값 방지)
    function validateForm(prefix) {
      const fields = ["Alias", "Zipcode", "Address", "Detail", "Recipient", "Phone"];
      for (let f of fields) {
        if (!document.getElementById(prefix + f).value.trim()) {
          alert("모든 항목을 입력해주세요.");
          document.getElementById(prefix + f).focus();
          return false;
        }
      }
      return true;
    }
  </script>
</body>
</html>
