<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>주문결제</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/productDetail/detail.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/productDetail/footer.css" />
</head>
<body>
	<!-- 상세 정보 -->
	<jsp:include page="../Header/header.jsp"></jsp:include>
	<div class="container">
		<c:if test="${not empty product }">
			<div class="section-title">📷 상세 정보</div>
			<c:if test="${checkOrder}">이미 구매/대여된 상품입니다.</c:if>
			<div class="product-layout">
				<div class="product-image">
					<div class="slider">
						<c:if test="${not empty product.img1}">
							<img
								src="${pageContext.request.contextPath}/upload/${product.img1}"
								class="slide-image" style="display: none;">
						</c:if>
						<c:if test="${not empty product.img2}">
							<img
								src="${pageContext.request.contextPath}/upload/${product.img2}"
								class="slide-image" style="display: none;">
						</c:if>
						<c:if test="${not empty product.img3}">
							<img
								src="${pageContext.request.contextPath}/upload/${product.img3}"
								class="slide-image" style="display: none;">
						</c:if>
						<c:if test="${not empty product.img4}">
							<img
								src="${pageContext.request.contextPath}/upload/${product.img4}"
								class="slide-image" style="display: none;">
						</c:if>
						<c:if test="${not empty product.img5}">
							<img
								src="${pageContext.request.contextPath}/upload/${product.img5}"
								class="slide-image" style="display: none;">
						</c:if>

						<!-- 이미지 하나도 없을 경우 기본이미지 -->
						<c:if
							test="${empty product.img1 and empty product.img2 and empty product.img3 and empty product.img4 and empty product.img5}">
							<img
								src="${pageContext.request.contextPath}/img/default_product.png"
								class="slide-image" style="display: none;">
						</c:if>

						<button id="prevBtn" class="slide-btn">&lt;</button>
						<button id="nextBtn" class="slide-btn">&gt;</button>
						<div id="slideCounter" class="slide-counter">1 / 1</div>
					</div>
				</div>
				<div class="product-details">
					<div class="top-icons">
						<button class="btn-share">🔗</button>
						<button class="btn-wish" onclick="toggleMark(this,${product.no})">
							<c:choose>
								<c:when test="${isMark}">♥</c:when>
								<c:otherwise>♡</c:otherwise>
							</c:choose>
						</button>
						<button type="button" class="btn-inquiry" onclick="openReportModal()">🚩</button>
						<!-- singo.jsp --> 
					</div>
					<c:choose>
						<c:when test="${product.categoryNo == 2}">
							<div class="category">의류/패션/악세사리</div>
						</c:when>
						<c:when test="${product.categoryNo == 3}">
							<div class="category">PC/모바일</div>
						</c:when>
						<c:when test="${product.categoryNo == 4}">
							<div class="category">가전제품</div>
						</c:when>
						<c:when test="${product.categoryNo == 5}">
							<div class="category">뷰티/미용</div>
						</c:when>
						<c:when test="${product.categoryNo == 6}">
							<div class="category">캠핑/스포츠/레저</div>
						</c:when>
						<c:when test="${product.categoryNo == 7}">
							<div class="category">생활/주방용품</div>
						</c:when>
						<c:when test="${product.categoryNo == 8}">
							<div class="category">가구인테리어</div>
						</c:when>
						<c:when test="${product.categoryNo == 9}">
							<div class="category">유아동/출산</div>
						</c:when>
						<c:when test="${product.categoryNo == 10}">
							<div class="category">애완동물용품</div>
						</c:when>
						<c:when test="${product.categoryNo == 11}">
							<div class="category">기타</div>
						</c:when>

					</c:choose>
					<div class="product-id">상품고유번호:${product.no}</div>
					<div class="title">${product.title}</div>

					<c:choose>
						<c:when test="${product.tradeType == '나눔' }"></c:when>
						<c:when test="${product.tradeType == '대여' }">
							<div class="rent-price">${product.rentPrice}원/1일</div>
							<div class="sec-price">보증금 ${product.secPrice}</div>
						</c:when>
						<c:when test="${product.tradeType == '판매' }">
							<div class="sale-price">${product.salePrice}원</div>
						</c:when>
						<c:when test="${product.tradeType == '판매/대여' }">
							<div class="rent-price">${product.rentPrice}원/1일</div>
							<div class="sec-price">보증금 ${product.secPrice}원</div>
							<div class="sale-price">판매가 ${product.salePrice}원</div>
						</c:when>
					</c:choose>
					<div class="seller-profile">
						<div class="avatar">
							<img
								src="https://cdn-icons-png.flaticon.com/512/1144/1144760.png"
								alt="프로필아이콘" />
						</div>
						<div class="profile-info">
							<div class="seller-name">${product.nickname}</div>
							<div class="seller-rating">
								<span class="score">${avgScore}</span> <span class="stars">
									<c:choose>
										<c:when test="${avgScore >= 4.5}">★★★★★</c:when>
										<c:when test="${avgScore >= 3.5}">★★★★☆</c:when>
										<c:when test="${avgScore >= 2.5}">★★★☆☆</c:when>
										<c:when test="${avgScore >= 1.5}">★★☆☆☆</c:when>
										<c:when test="${avgScore >= 0.5}">★☆☆☆☆</c:when>
										<c:when test="${avgScore <0.5}">☆☆☆☆☆</c:when>
									</c:choose>
								</span>
							</div>
						</div>
					</div>

					<div class="likes-views">
						<div>❤️</div>
						<div>👁️</div>
					</div>
					<div class="btn-box">
						<c:if test="${memberNo != null}">
						<button
						  class="btn btn-message"
						  onclick="openMessageModal(this)"
						  data-receiver-no="${product.memberNo}"
						  data-product-no="${product.no}"
						  data-receiver-name="${product.nickname}"
						  data-product-title="${product.title}"
						>쪽지보내기
						</button>
						</c:if>
						<c:if test="${not checkOrder}">
							<c:choose>
								<c:when test="${product.tradeType=='판매' }">
									<form
										action="${pageContext.request.contextPath}/productSellOrder"
										method="get">
										<input type="hidden" name="productNo" value="${product.no}" />
										<input type="hidden" name="tradeType" value="${product.tradeType}" />
										<button class="btn btn-sell">구매하기</button>
									</form>
								</c:when>
								<c:when test="${product.tradeType=='대여' }">
									<form
										action="${pageContext.request.contextPath}/productRentOrder"
										method="get">
										<input type="hidden" name="productNo" value="${product.no}" />
										<input type="hidden" name="tradeType" value="${product.tradeType}" />
										<button class="btn btn-sell">대여하기</button>
									</form>
								</c:when>
								<c:when test="${product.tradeType=='판매/대여' }">
									<form
										action="${pageContext.request.contextPath}/productSellOrder"
										method="get">
										<input type="hidden" name="productNo" value="${product.no}" />
										<input type="hidden" name="tradeType" value="${product.tradeType}" />
										<button class="btn btn-sell">구매하기</button>
									</form>
									<form
										action="${pageContext.request.contextPath}/productRentOrder"
										method="get">
										<input type="hidden" name="productNo" value="${product.no}" />
										<input type="hidden" name="tradeType" value="${product.tradeType}" />
										<button class="btn btn-rent">대여하기</button>
									</form>
								</c:when>
							</c:choose>
						</c:if>
					</div>
				</div>
			</div>

			<!--상품정보-->
			<div class="tab-menu">
				<div class="tab-item active" data-tab="info">상품정보</div>
				<div class="tab-item" data-tab="review">리뷰</div>
			</div>

			<div class="tab-content">
				<div class="tab-pane show" id="info">
					<div class="description">
						<!-- 색상 컬러 : 실버<br> 모델명/품번 : SM-R630N<br> 제조자/수입자 : 삼성전자(주)<br>
					유닛형태 : 커널형<br> 노이즈캔슬링 여부 : 액티브노이즈캔슬링(ANC)<br> 블루투스 버전 :
					블루투스 5.0 이상<br> 유무선 여부 : 무선<br> 내장마이크 탑재여부 : 내장마이크<br>
					<br> 이 상품은 개봉하지 않은 미사용 상품입니다. 상품은 새상품이며 직거래만 가능합니다.<br>
					거래지역은 사당역, 서울대벤처타운역, 신림역 등 서울대 근처 우선이며, 직거래만 가능합니다.<br>
					현금/계좌이체 모두 가능하며, 제가 직접 대중교통을 이용해 거래합니다. -->
						${product.content }
					</div>
				</div>
		</c:if>
		<div class="tab-pane" id="review">
			<div class="review-section">
				<div class="review-top">
					<h3>판매자 만족도</h3>
					<div class="rating-display">
						<span class="score">${avgScore}/5.0</span>
						<c:choose>
							<c:when test="${avgScore >= 4.5}">★★★★★</c:when>
							<c:when test="${avgScore >= 3.5}">★★★★☆</c:when>
							<c:when test="${avgScore >= 2.5}">★★★☆☆</c:when>
							<c:when test="${avgScore >= 1.5}">★★☆☆☆</c:when>
							<c:when test="${avgScore >= 0.5}">★☆☆☆☆</c:when>
							<c:when test="${avgScore <0.5}">☆☆☆☆☆</c:when>
						</c:choose>
					</div>
				</div>
				<c:if test="${memberNo != null and not checkMyReview}">
					<button id="review-toggle-btn" class="btn btn-review-write">리뷰쓰기</button>
				</c:if>
				<!--리뷰 작성-->
				<form id="review-form" class="review-form" style="display: none;">
					<input type="hidden" name="productNo" value="${product.no}" /> <input
						type="hidden" name="memberNo" value="${member.no}" />
					<div class="review-input-row">
						<textarea name="content" placeholder="리뷰 내용을 입력하세요"></textarea>
						<label class="rating-box"> 평점: <select name="score">
								<option value="5">5점</option>
								<option value="4">4점</option>
								<option value="3" selected>3점</option>
								<option value="2">2점</option>
								<option value="1">1점</option>
						</select>
						</label>
						<button type="submit" class="btn btn-review-submit" id="submitBtn">등록</button>
					</div>
				</form>
				<!--리뷰조회-->
				<div id="review-list-container">
					<jsp:include page="reviewList.jsp" />
				</div>

				<!-- 달력 -->
				<jsp:include page="calendarModal.jsp" />
				<button onclick="openCalendar()">📅 대여 가능 날짜 보기</button>

			</div>
		</div>
	</div>
	<c:if test="${param.paid eq 'true'}">
		<script>
    		alert("🎉 결제가 정상적으로 완료되었습니다!");
    		// 주소에서 paid 파라미터 제거 (브라우저 주소만 바꾸고 리로드 안 함)
    	    history.replaceState(null, '', location.pathname + location.search.replace(/(&|\?)?paid=true/, ''));
  		</script>
	</c:if>
</body>

<jsp:include page="noteModal.jsp">
	<jsp:param value="${product.no}" name="productNo" />
	<jsp:param value="${product.tradeType}" name="tradeType" />
</jsp:include>
<jsp:include page="report.jsp">
	<jsp:param value="${product.no}" name="productNo"/>
	<jsp:param value="${product.tradeType}" name="tradeType"/>
</jsp:include>




<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

    const tabItems = document.querySelectorAll('.tab-item');
    const tabPanes = document.querySelectorAll('.tab-pane');
    
    tabItems.forEach(item => {
      item.addEventListener('click', () => {
        tabItems.forEach(el => el.classList.remove('active'));
        tabPanes.forEach(el => el.classList.remove('show'));
        item.classList.add('active');
        document.getElementById(item.dataset.tab).classList.add('show');
      });
    });

    const toggleBtn = document.getElementById('review-toggle-btn');
    const reviewForm = document.getElementById('review-form');
    if (toggleBtn) {
      toggleBtn.addEventListener('click', () => {
        reviewForm.style.display = reviewForm.style.display === 'none' ? 'block' : 'none';
      });
    }
 // 쪽지보내기 모달
    function openMessageModal(btn) {
      const modal = document.getElementById('messageModal');
      
      // 버튼에서 데이터 읽기
      const receiverNo = btn.getAttribute('data-receiver-no');
      const productNo = btn.getAttribute('data-product-no');
      const receiverName = btn.getAttribute('data-receiver-name');
      const productTitle = btn.getAttribute('data-product-title');
      
      // 모달에 값 설정
      document.getElementById('modalReceiverNo').value = receiverNo;
      document.getElementById('modalProductNo').value = productNo;
      document.getElementById('modalReceiverName').textContent = receiverName;
      document.getElementById('modalProductTitle').textContent = productTitle;

      // 모달을 보여줌
      modal.style.display = 'flex';

      setTimeout(() => {
        modal.classList.add('active');
      }, 10); // 모달의 애니메이션을 10ms 후에 추가
    }

    function closeMessageModal() {
      const modal = document.getElementById('messageModal');
      modal.classList.remove('active');
      
      // 애니메이션 후, display:none 처리
      setTimeout(() => {
        modal.style.display = 'none';
      }, 400); // transition 시간에 맞춰서
    }

    // 쪽지 보내기 처리
    $('#sendMessageBtn').click(function (e) {
      e.preventDefault();

      const formData = {
        receiverNo: $("input[name='receiverNo']").val(),
        productNo: $("input[name='productNo']").val(),
        noteContent: $("#noteContent").val()
      };

      $.ajax({
        type: "POST",
        url: contextPath + "/noteSend",  // 서버로 전송할 URL
        data: formData,
        success: function(response) {
          alert("쪽지가 성공적으로 보내졌습니다!");
          closeMessageModal();
          $("#messageForm")[0].reset();  // 폼 초기화
        },
        error: function(xhr, status, error) {
          alert("쪽지 보내기 실패ㅠㅠ 다시 시도해주세요!");
          console.error(xhr.responseText);
        }
      });
    });

    // 신고하기 모달 열기
    function openReportModal() {
      if ('${memberNo}' === '' || '${memberNo}' === 'null') {
        alert('로그인이 필요합니다.');
        return;
      }
      const modal = document.getElementById('reportModal');
      modal.style.display = 'flex';
      
      // 약간의 delay 후 활성화
      setTimeout(() => {
        modal.classList.add('active');
      }, 10); // transition을 제대로 적용하기 위해 10ms 딜레이
    }

    // 신고하기 모달 닫기
    function closeReportModal() {
      const modal = document.getElementById('reportModal');
      
      modal.classList.remove('active');
      
      // 애니메이션 후, display:none 처리
      setTimeout(() => {
        modal.style.display = 'none';
      }, 400); // transition 시간과 동일 (0.4초)
    }

    // 신고 처리
    function submitReport() {
      const type = document.getElementById('reportReason').value;
      const contents = document.getElementById('reportDetail').value;
      const title = document.getElementById('reportTitle').value;

      if (!type || !contents || !title) {
        alert('⚠️ 신고 사유, 제목, 내용을 모두 입력해 주세요!');
        return;
      }

      $.ajax({
        type: 'POST',
        url: contextPath + '/report', // 신고 처리할 URL
        data: {
          type: type,
          contents: contents,
          title: title,
          productNo: '${product.no}' // 상품 번호 추가
        },
        success: function(response) {
          alert('✅ 신고가 정상적으로 접수되었습니다!');
          closeReportModal();  // 모달 닫기
          resetReportForm();   // 폼 초기화
        },
        error: function(xhr, status, error) {
          alert('❌ 신고 처리 실패! 다시 시도해주세요.');
          console.error(xhr.responseText);
        }
      });
    }

    // 신고 폼 초기화 함수
    function resetReportForm() {
      document.getElementById('reportReason').value = '';
      document.getElementById('reportDetail').value = '';
      document.getElementById('reportTitle').value = '';
    }
	
    
    //찜하기
    function toggleMark(btn, productNo) {
  const memberNo = '${memberNo}';
  if (!memberNo || memberNo === 'null') {
    alert('로그인이 필요합니다.');
    return;
  }

  $.ajax({
    url: contextPath + "/markProduct",
    type: "POST",
    data: { productNo: productNo },
    success: function(res) {
      btn.innerText = res.isMark ? "♥" : "♡";
    },
    error: function(xhr) {
      alert("찜 요청 실패");
      console.error(xhr.responseText);
    }
  });
	}
	 
</script>