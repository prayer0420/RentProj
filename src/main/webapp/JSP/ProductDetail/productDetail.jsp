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
			<div class="product-layout">
				<div class="product-image">
					<img src="https://cdn-icons-png.flaticon.com/512/1041/1041916.png"
						alt="버즈 이미지" />
				</div>
				<div class="product-details">
					<div class="top-icons">
						<button class="btn-share">🔗</button>
						<button class="btn-wish">🤍</button>
						<button class="btn-inquiry">🚩</button>
						<!-- singo.jsp -->
					</div>
					<div class="category">${product.categoryNo}</div>
					<div class="product-id">${product.no}</div>
					<div class="title">${product.title}</div>
					<c:choose>
						<c:when test="${product.tradeType == '무료나눔' }"></c:when>
						<c:when test="${product.tradeType == '대여' }">
							<div class="rent-price">${product.rentPrice}원/1일</div>
							<div class="sec-price">보증금 ${product.secPrice}</div>
						</c:when>
						<c:when test="${product.tradeType == '판매' }">
							<div class="sale-price">${product.salePrice}원</div>
						</c:when>
						<c:when test="${product.tradeType == '대여/판매' }">
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
								<span class="score">3.0</span> <span class="stars">★★★</span>
							</div>
						</div>
					</div>

					<div class="likes-views">
						<div>❤️ 5</div>
						<div>👁️ 13</div>
					</div>
					<div class="btn-box">
						<c:if test="${not empty sessionScope.member}">
							<button class="btn btn-message" onclick="openMessageModal()">쪽지보내기</button>
						</c:if>
						<c:choose>
							<c:when test="${product.tradeType=='판매' }">
								<form
									action="${pageContext.request.contextPath}/productOrder?no=${product.no}">
									method="get"> <input type="hidden" name="productNo"
										value="${product.no}" />

									<button class="btn btn-sell">구매하기</button>
								</form>
							</c:when>
							<c:when test="${product.tradeType=='대여' }">
								<form action="">
									<button class="btn btn-rent">대여하기</button>
								</form>
							</c:when>
							<c:when test="${product.tradeType=='대여/판매' }">
								<form action="${pageContext.request.contextPath}/productOrder"
									method="get">
									<button class="btn btn-sell">구매하기</button>
								</form>
								<form action="">
									<button class="btn btn-rent-">대여하기</button>
								</form>
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
		</c:if>
		<div class="tab-pane" id="review">
			<div class="review-section">
				<div class="review-top">
					<h3>판매자 만족도</h3>
					<div class="rating-display">
						<span class="score">3/5</span> <span class="stars">★★★☆☆</span>
					</div>
				</div>

				<button id="review-toggle-btn" class="btn btn-review-write">리뷰
					쓰기</button>
				<!--리뷰 작성-->
				<form id="review-form" class="review-form" style="display: none;">
					<div class="review-input-row">
						<textarea name="content" placeholder="리뷰 내용을 입력하세요"></textarea>
						<label class="rating-box"> 평점: <select name="rating">
								<option value="5">5점</option>
								<option value="4">4점</option>
								<option value="3" selected>3점</option>
								<option value="2">2점</option>
								<option value="1">1점</option>
						</select>
						</label>
						<button type="submit" class="btn btn-review-submit">등록</button>
					</div>
				</form>
				<!--리뷰조회-->
				<div id="review-list-container">
					<jsp:include page="reviewList.jsp" />
				</div>


			</div>
		</div>
	</div>
</body>

<jsp:include page="messageModal.jsp">
	<jsp:param value="${product.no }" name="productNo" />
	<jsp:param value="${product.tradeType }" name="tradeType" />
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
    //쪽지보내기 모달
	function openMessageModal() {
	  document.getElementById('messageModal').style.display = 'flex';
	}
	
	function closeMessageModal() {
	  document.getElementById('messageModal').style.display = 'none';
	}
	
	 $('#review-form').on('submit', function (e) {
		    e.preventDefault(); // 기본 제출 막기

		    const formData = {
		      content: $('textarea[name="content"]').val(),
		      rating: $('select[name="rating"]').val(),
		      productNo: '${product.no}'
		    };

		    $.ajax({
		      type: 'POST',
		      url: '${pageContext.request.contextPath}/reviewWrite', // ← 리뷰 등록 서블릿
		      data: formData,
		      success: function () {
		        alert('리뷰가 등록되었습니다!');
		        $('#review-form')[0].reset();
		        $('#review-form').hide();

		        // 🔁 리뷰 리스트를 다시 불러오기
		        $('#review-list-container').load('${pageContext.request.contextPath}/review/list?productNo=${product.no}');
		      },
		      error: function () {
		        alert('리뷰 등록에 실패했습니다.');
		      }
		    });
		  });
	
	
	
</script>