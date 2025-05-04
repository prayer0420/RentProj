<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>주문결제</title>
<%-- JSP 상단에 디버그용 출력 --%>
<%
Object userNo = session.getAttribute("no");
Object userId = session.getAttribute("id");
System.out.println("세션 userNo: " + userNo);
System.out.println("세션 userId: " + userId);
%>
<c:set var="isLoggedIn" value="${not empty sessionScope.no}" />
<script>
	  const contextPath = "${pageContext.request.contextPath}";
	  const memberNo = "${sessionScope.no}";
	  const isLoggedIn = ${isLoggedIn}; // ← Boolean true/false 그대로
	</script>
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
			<!-- <div class="section-title">📷 상세 정보</div> -->
			<c:if test="${checkOrder && product.tradeType=='판매'}">이미 구매된 상품입니다.</c:if>
			<div class="product-layout">
				<div class="product-image">
					<div class="slider">
						<c:if test="${not empty product.img1}">
							<img
								src="${pageContext.request.contextPath}/upload/${product.img1}"
								class="slide-image">
						</c:if>
						<c:if test="${not empty product.img2}">
							<img
								src="${pageContext.request.contextPath}/upload/${product.img2}"
								class="slide-image">
						</c:if>
						<c:if test="${not empty product.img3}">
							<img
								src="${pageContext.request.contextPath}/upload/${product.img3}"
								class="slide-image">
						</c:if>
						<c:if test="${not empty product.img4}">
							<img
								src="${pageContext.request.contextPath}/upload/${product.img4}"
								class="slide-image">
						</c:if>
						<c:if test="${not empty product.img5}">
							<img
								src="${pageContext.request.contextPath}/upload/${product.img5}"
								class="slide-image">
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
						<div id="slideCounter" class="slide-counter"></div>
					</div>
				</div>
				<div class="product-details">
					<div class="top-icons">
						<button class="btn-share" onclick="copyToClipboard()">🔗</button>
							<button class="btn-kakao" onclick="shareKakao()" title="카카오톡 공유">
							  <img src="${pageContext.request.contextPath}/img/kakao-share.png"
							       alt="카카오톡 공유"
							       style="width: 32px; height: 32px;" />
							</button>
							<button class="btn-wish" id="wishBtn" data-productno="${product.no}">
							  <img id="wishIcon"
							       src="<c:out value='${isMark ? "https://cdn-icons-png.flaticon.com/512/833/833472.png" : "https://cdn-icons-png.flaticon.com/512/1077/1077035.png"}'/>"
							       alt="찜"
							       style="width: 28px; height: 28px;" />
							</button>
						</button>
						<button type="button" class="btn-inquiry"
							onclick="openReportModal()">🚩</button>
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
						<div class="profile-info" id="avgScoreBox">
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
						<div id="markCount">
							❤️ <span id="markCountNumber">${countMarkProduct}</span>
						</div>
						<div>
							👁️<span id="viewCount"></span>
						</div>
					</div>
					<div class="btn-box">
						<c:choose>
							<c:when test="${product.memberNo != memberNo}">
								<button class="btn btn-message" onclick="openMessageModal(this)"
									data-receiver-no="${product.memberNo}"
									data-product-no="${product.no}"
									data-receiver-name="${product.nickname}"
									data-product-title="${product.title}">쪽지보내기</button>
							</c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
						<c:choose>
							<c:when
								test="${product.memberNo != memberNo && product.tradeType=='판매'}">
								<c:if test="${not checkOrder}">
									<form
										action="${pageContext.request.contextPath}/productSellOrder"
										method="get">
										<input type="hidden" name="productNo" value="${product.no}" />
										<input type="hidden" name="tradeType"
											value="${product.tradeType}" />
										<button class="btn btn-sell">구매하기</button>
									</form>
								</c:if>
							</c:when>
							<c:when
								test="${product.memberNo != memberNo && product.tradeType=='대여'}">
								<!-- 항상 표시 -->
								<button class="btn btn-rent" onclick="openCalendar()">대여하기</button>

								<jsp:include page="calendarModal.jsp">
									<jsp:param name="productNo" value="${product.no}" />
									<jsp:param name="productStart" value="${product.startDate}" />
									<jsp:param name="productEnd" value="${product.endDate}" />
								</jsp:include>
							</c:when>
							<c:when
								test="${product.memberNo != memberNo && product.tradeType=='판매/대여'}">
								<c:if test="${not checkOrder}">
									<form
										action="${pageContext.request.contextPath}/productSellOrder"
										method="get">
										<input type="hidden" name="productNo" value="${product.no}" />
										<input type="hidden" name="tradeType"
											value="${product.tradeType}" />
										<button class="btn btn-sell">구매하기</button>
									</form>
								</c:if>
								<!-- 대여 버튼은 항상 표시 -->
								<button class="btn btn-rent" onclick="openCalendar()">대여하기</button>
								<jsp:include page="calendarModal.jsp">
									<jsp:param name="productNo" value="${product.no}" />
									<jsp:param name="productStart" value="${product.startDate}" />
									<jsp:param name="productEnd" value="${product.endDate}" />
								</jsp:include>
							</c:when>
						</c:choose>
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
			</div>
		</c:if>
		<div class="tab-pane" id="review">
			<div class="review-section">
				<div class="review-top" id="reviewAvgScoreBox">
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
				<c:if test="${memberNo != null and not checkMyReview and memberNo != product.memberNo}">
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
	<jsp:param value="${product.no}" name="productNo" />
	<jsp:param value="${product.tradeType}" name="tradeType" />
</jsp:include>



<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
console.log("로그인 여부:", isLoggedIn);
	//뷰 카운트 가져오기
	function fetchViewCount(productNo) {
  $.ajax({
    url: contextPath + "/getViewCount",
    type: "GET",
    data: { no: productNo },
    success: function (res) {
      const viewEl = document.getElementById("viewCount");
      if (viewEl) {
        viewEl.textContent = `👁️ ${res.viewCnt}`;
      }
    },
    error: function (xhr) {
      console.error("뷰카운트 가져오기 실패", xhr.responseText);
    }
  });
}
	document.addEventListener("DOMContentLoaded", function () {
		  const productNo = "${product.no}";

		  // 1. 뷰카운트 증가
		  fetch(contextPath + "/incrementViewCount?no=" + productNo, {
		    method: "POST"
		  }).then(res => {
		    if (!res.ok) {
		      console.error("뷰카운트 증가 실패");
		    } else {
		      // 2. 증가 성공 후 최신 뷰카운트 가져오기
		      fetch(contextPath + "/getViewCount?no=" + productNo)
		        .then(res => res.json())
		        .then(data => {
		          const viewEl = document.getElementById("viewCount");
		          if (viewEl && data.viewCnt !== undefined) {
		            viewEl.textContent = data.viewCnt;  // 👁️ 아이콘은 HTML에 이미 있으니 숫자만
		          }
		        })
		        .catch(err => {
		          console.error("뷰카운트 가져오기 실패", err);
		        });
		    }
		  }).catch(err => {
		    console.error("뷰카운트 증가 요청 중 에러 발생", err);
		  });
		});
	
	function toggleMark(btn, productNo) {
		if (!isLoggedIn) {
		    alert("로그인이 필요합니다.");
		    location.href = contextPath + "/login";
		    return;
		  }
	
	  $.ajax({
	    url: contextPath + "/markProduct",
	    type: "POST",
	    data: { productNo: productNo },
	    dataType: "json", // ✅ 꼭 넣어줘
	    success: function (res) {
	    	  const heartIcon = document.getElementById("wishIcon");
	    	  if (heartIcon) {
	    	    heartIcon.src = res.isMark
	    	      ? "https://cdn-icons-png.flaticon.com/512/833/833472.png"   // 빨간 하트
	    	      : "https://cdn-icons-png.flaticon.com/512/1077/1077035.png"; // 빈 하트
	    	  }

	    	  const markCountEl = document.getElementById("markCountNumber");
	    	  if (markCountEl && res.count !== undefined) {
	    	    markCountEl.textContent = res.count;
	    	  }
	    	},
	    error: function (xhr) {
	      alert("찜 처리 중 오류 발생");
	      console.error(xhr.responseText);
	    },
	  });
	}
	
	document.addEventListener("DOMContentLoaded", function () {
	  // 탭 처리
	  document.querySelectorAll('.tab-item').forEach(item => {
	    item.addEventListener('click', () => {
	      document.querySelectorAll('.tab-item').forEach(el => el.classList.remove('active'));
	      document.querySelectorAll('.tab-pane').forEach(el => el.classList.remove('show'));
	      item.classList.add('active');
	      document.getElementById(item.dataset.tab).classList.add('show');
	    });
	  });
	
	  // 찜 버튼 바인딩
	  const btn = document.getElementById("wishBtn");
	  if (btn) {
	    btn.addEventListener("click", function () {
	      const productNo = btn.dataset.productno;
	      toggleMark(btn, productNo);
	    });
	  }
	
	  // 리뷰 toggle 버튼
	  const toggleBtn = document.getElementById('review-toggle-btn');
	  const reviewForm = document.getElementById('review-form');
	  if (toggleBtn) {
	    toggleBtn.addEventListener('click', () => {
	      reviewForm.style.display = (reviewForm.style.display === 'none') ? 'block' : 'none';
	    });
	  }
	});
	
	// 쪽지 보내기
	function openMessageModal(btn) {
		 if (!isLoggedIn) {
			    alert("로그인이 필요합니다.");
			    location.href = contextPath + "/login";
			    return;
			  }
	  const modal = document.getElementById('messageModal');
	  document.getElementById('modalReceiverNo').value = btn.dataset.receiverNo;
	  document.getElementById('modalProductNo').value = btn.dataset.productNo;
	  document.getElementById('modalReceiverName').textContent = btn.dataset.receiverName;
	  document.getElementById('modalProductTitle').textContent = btn.dataset.productTitle;
	
	  modal.style.display = 'flex';
	  setTimeout(() => modal.classList.add('active'), 10);
	}
	
	function closeMessageModal() {
	  const modal = document.getElementById('messageModal');
	  modal.classList.remove('active');
	  setTimeout(() => modal.style.display = 'none', 400);
	}
	
	$('#sendMessageBtn').click(function (e) {
	  e.preventDefault();
	  const formData = {
	    receiverNo: $("input[name='receiverNo']").val(),
	    productNo: $("input[name='productNo']").val(),
	    noteContent: $("#noteContent").val()
	  };
	
	  $.ajax({
	    type: "POST",
	    url: contextPath + "/noteSend",
	    data: formData,
	    success: function () {
	      alert("쪽지가 성공적으로 보내졌습니다!");
	      closeMessageModal();
	      $("#messageForm")[0].reset();
	    },
	    error: function (xhr) {
	      alert("쪽지 보내기 실패ㅠㅠ 다시 시도해주세요!");
	      console.error(xhr.responseText);
	    }
	  });
	});
	
	// 신고 모달
	function openReportModal() {
		if (!isLoggedIn) {
		    alert("로그인이 필요합니다.");
		    location.href = contextPath + "/login";
		    return;
		  }
	  const modal = document.getElementById('reportModal');
	  modal.style.display = 'flex';
	  setTimeout(() => modal.classList.add('active'), 10);
	}
	
	function closeReportModal() {
	  const modal = document.getElementById('reportModal');
	  modal.classList.remove('active');
	  setTimeout(() => modal.style.display = 'none', 400);
	}
	
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
	    url: contextPath + '/report',
	    data: {
	      type: type,
	      contents: contents,
	      title: title,
	      productNo: '${product.no}'
	    },
	    success: function () {
	      alert('✅ 신고가 정상적으로 접수되었습니다!');
	      closeReportModal();
	      resetReportForm();
	    },
	    error: function (xhr) {
	      alert('❌ 신고 처리 실패! 다시 시도해주세요.');
	      console.error(xhr.responseText);
	    }
	  });
	}
	
	function resetReportForm() {
	  document.getElementById('reportReason').value = '';
	  document.getElementById('reportDetail').value = '';
	  document.getElementById('reportTitle').value = '';
	}
	
	// 리뷰 등록/수정
	let isUpdateMode = false;
	let updateReviewNo = null;
	const productNo = '${product.no}';
	$('#review-form').on('submit', function (e) {
	  e.preventDefault();

	  const formData = {
	    content: $('textarea[name="content"]').val(),
	    score: $('select[name="score"]').val(),
	    productNo: '${product.no}'
	  };

	  if (isUpdateMode && updateReviewNo) {
	    formData.no = updateReviewNo;
	  }

	  $.ajax({
	    type: 'POST',
	    url: isUpdateMode ? contextPath + "/reviewUpdate" : contextPath + "/reviewWrite",
	    data: formData,
	    success: function () {
	      alert(isUpdateMode ? '리뷰가 수정되었습니다!' : '리뷰가 등록되었습니다!');
	      $('#review-form')[0].reset();
	      $('#review-form').hide();
	      isUpdateMode = false;
	      updateReviewNo = null;
	      $("#submitBtn").text("등록");

	   // ✅ 리뷰 리스트 & 별점 모두 갱신
	      $('#review-list-container').load(contextPath + '/productDetail?no=' + productNo + ' #review-list-container > *');
	      
	   	  $('#avgScoreBox').load(contextPath + '/productDetail?no=' + productNo + ' #avgScoreBox > *');
	      $('#reviewAvgScoreBox').load(contextPath + '/productDetail?no=' + productNo + ' #reviewAvgScoreBox > *'); // ✅ 이거 추가
	    
	      // ✅ 리뷰쓰기 버튼 숨기기
	      $('#review-toggle-btn').hide();
	    },
	    error: function () {
	      alert(isUpdateMode ? '리뷰 수정 실패' : '리뷰 등록 실패');
	    }
	  });
	});

	// 수정 버튼 눌렀을 때 실행될 함수 (HTML에서 onclick으로 호출됨)
	function editReview(reviewNo, content, score) {
	  const reviewForm = document.getElementById('review-form');
	  const contentInput = document.querySelector('textarea[name="content"]');
	  const scoreSelect = document.querySelector('select[name="score"]');
	  const submitBtn = document.getElementById('submitBtn');

	  isUpdateMode = true;
	  updateReviewNo = reviewNo;

	  reviewForm.style.display = 'block';
	  contentInput.value = content;
	  scoreSelect.value = score;
	  submitBtn.textContent = '수정';
	}

	// 삭제 버튼 눌렀을 때 실행될 함수 (HTML에서 onclick으로 호출됨)
	function deleteReview(reviewNo) {
	  if (!confirm('정말 삭제하시겠습니까?')) return;

	  $.ajax({
	    type: 'POST',
	    url: contextPath + '/reviewDelete',
	    data: { no: reviewNo },
	    success: function () {
	      alert('리뷰가 삭제되었습니다!');
	      // ✅ 삭제 후 리스트 다시 로딩
	      $('#review-list-container').load(contextPath + '/productDetail?no=' + productNo + ' #review-list-container > *');
	      $('#avgScoreBox').load(contextPath + '/productDetail?no=' + productNo + ' #avgScoreBox > *');
	      $('#reviewAvgScoreBox').load(contextPath + '/productDetail?no=' + productNo + ' #reviewAvgScoreBox > *'); // ✅ 이거 추가
	      // ✅ 리뷰쓰기 버튼 다시 보이기
	      $('#review-toggle-btn').show();
	    },
	    error: function () {
	      alert('리뷰 삭제 실패');
	    }
	  });
	}
	
	function toggleReviewWriteButton() {
		  const hasReview = $('#hasReviewCheck').text().trim() === 'true';
		  if (hasReview) {
		    $('#review-toggle-btn').hide();
		  } else {
		    $('#review-toggle-btn').show();
		  }
		}
	
	function copyToClipboard() {
		  const dummy = document.createElement("input");
		  const text = window.location.href; // 현재 페이지 URL
		  document.body.appendChild(dummy);
		  dummy.value = text;
		  dummy.select();
		  document.execCommand("copy");
		  document.body.removeChild(dummy);
		  alert("링크가 복사되었습니다!");
		}
	Kakao.init('aebfadf8315b8625cd1f4c4607cf4a68');

	function shareKakao() {
	  Kakao.Link.sendDefault({
	    objectType: 'feed',
	    content: {
	      title: 'RE:NT에서 상품을 공유했어요!',
	      description: '이 상품 어때요?',
	      imageUrl: 'https://yourdomain.com/path/image.jpg',
	      link: {
	        mobileWebUrl: window.location.href,
	        webUrl: window.location.href,
	      },
	    }
	  });
	}
	/*슬라이더 관련*/
	document.addEventListener("DOMContentLoaded", function () {
  const images = document.querySelectorAll(".slide-image");
  const prevBtn = document.getElementById("prevBtn");
  const nextBtn = document.getElementById("nextBtn");
  const counter = document.getElementById("slideCounter");

  const totalImages = images.length;
  let currentIndex = 0; // ❗초기 인덱스는 0부터 시작해야 함
  
  function showImage(index) {
    images.forEach((img, i) => {
    	img.classList.remove("active");
    	if (i === index) {
    	  img.classList.add("active");
    	}
    });
    if (counter) {
      counter.textContent = (index+1) +"/"+totalImages;
    	if(index==totalImages) index=1;
    }
  }

  if (totalImages === 0) {
    prevBtn.style.display = "none";
    nextBtn.style.display = "none";
    if (counter) counter.style.display = "none";
    return;
  }

  showImage(currentIndex); // ✅ 첫 이미지 보이게 하기

  prevBtn.addEventListener("click", () => {
    currentIndex = (currentIndex - 1 + totalImages) % totalImages;
    showImage(currentIndex);
  });

  nextBtn.addEventListener("click", () => {
    currentIndex = (currentIndex + 1) % totalImages;
    showImage(currentIndex);
  });
});
	
	
	
</script>