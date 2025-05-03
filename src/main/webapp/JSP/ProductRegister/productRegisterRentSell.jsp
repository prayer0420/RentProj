<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 판매대여 등록</title>

<!-- Flatpickr CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/CSS/productRegister/productRegisterRentSell.css">

<!-- Flatpickr JS -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>


</head>
<body>
	<jsp:include page="../Header/header.jsp" />
	<main class="form-wrapper">
		<h1 class="form-title">판매/대여 등록</h1>
		<form id="registerForm" action="<%=request.getContextPath()%>/rentSell"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="tradeType" value="판매/대여" />

			<!-- 제목 -->
			<section class="form-section">
				<label for="title">제목</label> <input type="text" id="title"
					name="title" placeholder="상품 제목을 입력하세요" />
			</section>

			<!-- 카테고리 -->
			<section class="form-section">
				<label for="category">카테고리</label> <select id="category"
					name="categoryNo">
					<option value="">카테고리 선택</option>
					<option value="2">의류/팩션/악세사리</option>
					<option value="3">PC/디지털</option>
					<option value="4">가전제품</option>
					<option value="5">비트미/미용</option>
					<option value="6">칼피는/스포츠</option>
					<option value="7">생활/주방</option>
					<option value="8">가구/인터리어</option>
					<option value="9">유아/출산</option>
					<option value="10">애와도움</option>
					<option value="11">기타</option>
				</select>
			</section>

		      <!-- 판매가 -->
			<section class="form-section price-section">
			  <div class="label-with-tooltip">
			    <label for="salePrice">판매가</label>
			    <div class="tooltip-container">
			      <span id="tooltipTrigger" class="info-icon">&#9432;</span>
			      <div class="tooltip" id="tooltipBox">
			        브론즈 : 5%<br>실버 : 4.5%<br>골드 : 4%<br>플레티넘 : 3.5%<br>다이아 : 3%<br>Re:NT : 2.5%
			        <div class="tooltip-arrow"></div>
			      </div>
			    </div>
			  </div>
			  <input type="text" id="salePrice" name="salePrice" placeholder="가격을 입력하세요" />
			</section>

			<!-- 대여 일정 -->
			<section class="form-section container-date">
				<h4>대여 가능 날짜</h4>
				<div class="date-range">
					<label for="startDate" class="start-date-label">대여 시작일</label> <input
						type="text" id="startDate" name="startDate" placeholder="연도-월-일" />
				</div>
				<div class="date-range">
					<label for="endDate" class="end-date-label">대여 반납일</label> <input
						type="text" id="endDate" name="endDate" placeholder="연도-월-일" />
				</div>
			</section>

			<!-- 대여가 -->
			<section class="form-section price-section">
				<label for="rentPrice">대여가(1일당)</label> <input type="text"
					id="rentPrice" name="rentPrice" placeholder="대여 가격을 입력하세요" />
			</section>

			<!-- 보증금 -->
			<section class="form-section secPrice-section">
				<label for="secPrice">보증금</label> <input type="text" id="secPrice"
					name="secPrice" placeholder="보증금을 입력하세요" />
			</section>

			<!-- 거래방식 -->
			<section class="form-section">
				<label>거래방식</label>
				<div class="radio-group">
					<input type="radio" name="deliveryStatus" id="hand" value="직거래" />
					<label for="hand">직거래</label> <input type="radio"
						name="deliveryStatus" id="delvPrice" value="택배거래" /> <label
						for="delvPrice">택배</label>
				</div>
				<label for="deliveryPrice">배송비</label> <input type="text"
					id="deliveryPrice" name="deliveryPrice" placeholder="배송비를 입력하세요"
					disabled />
			</section>

			<!-- 상품 상태 -->
			<section class="form-section">
				<label for="state">상품 상태</label> <select id="state" name="state">
					<option value="">선택하세요</option>
					<option value="새상품(미사용)">새상품(미사용)</option>
					<option value="사용감적음">사용감 적음</option>
					<option value="사용감많음">사용감 많음</option>
					<option value="고장/파손">고장/파손</option>
				</select>
			</section>

			<!-- 상품 설명 -->
			<section class="form-section">
				<label for="content">상품 설명</label>
				<textarea id="content" name="content" placeholder="상품 설명"></textarea>
			</section>

			<!-- 이미지 업로드 -->
			<section class="form-section">
				<label>상품 이미지 (최대 5장)</label>
				<div class="image-upload-container">
					<div id="previewArea" class="image-preview"></div>
					<div class="img-upload-box" id="addImageButton">
						<img src="${pageContext.request.contextPath}/img/plus.png"
							alt="상품추가" style="width: 40px; height: 40px;" />
					</div>
				</div>
				<input type="file" name="imgList0" id="ifile0" accept="image/*"
					style="display: none;" onchange="readURL(this, 0)" /> <input
					type="file" name="imgList1" id="ifile1" accept="image/*"
					style="display: none;" onchange="readURL(this, 1)" /> <input
					type="file" name="imgList2" id="ifile2" accept="image/*"
					style="display: none;" onchange="readURL(this, 2)" /> <input
					type="file" name="imgList3" id="ifile3" accept="image/*"
					style="display: none;" onchange="readURL(this, 3)" /> <input
					type="file" name="imgList4" id="ifile4" accept="image/*"
					style="display: none;" onchange="readURL(this, 4)" />
			</section>

			<!-- 이미지 확대 모달 -->
			<div id="imageZoomModal" class="modal-zoom">
				<div class="modal-content">
					<img id="zoomedImage" src="" alt="확대 이미지" />
					<button type="button" onclick="closeImageModal()">닫기</button>
				</div>
			</div>

			<!-- 필수 안내 -->
			<section class="form-section align-inline">
				<div class="agreement-row">
					<label class="inline-left"> <input type="checkbox"
						id="admitCheck" /> 필수 안내에 동의합니다
					</label>
					<button type="button" id="btnOpenAdmit" class="inline-right">자세히
						보기</button>
				</div>
			</section>


			<div class="modal-admit" id="admitModal">
				<div class="modal-admit-body">
					<h3>거래 중개 서비스 이용 약관</h3>

					<h4>1. 서비스 성격</h4>
					<p>RE:NT는 판매자와 구매자 간의 거래 및 대여 서비스를 중개하는 플랫폼을 제공합니다. 당사는 거래 당사자가 아닌
						중개 서비스 제공자로서, 거래의 성립과 이행에 관여하지 않습니다.</p>

					<h4>2. 책임 한계</h4>
					<p>거래 과정에서 발생하는 모든 책임(상품 상태, 배송, 환불, 분쟁 등)은 거래 당사자(판매자와 구매자)에게
						있으며, 빌리는 이에 대한 직접적인 책임을 지지 않습니다.</p>

					<h4>3. 서류 및 정보 교환</h4>
					<p>대여 진행 시 필요한 서류 및 정보는 거래 당사자 간에 직접 교환해야 합니다. 빌리는 거래 당사자 간
						교환되는 서류 및 정보에 관여하지 않으며, 이와 관련된 책임을 지지 않습니다.</p>

					<p style="margin-top: 20px;">본 약관에 동의함으로써 이용자는 위의 내용을 모두 이해하고
						동의함을 확인합니다.</p>

					<button type="button" id="btnCloseAdmit">확인</button>
				</div>
			</div>

			<!-- 등록 버튼 -->
			<button type="submit" class="submit-btn">등록하기</button>
		</form>
	</main>
</body>

<script>
document.addEventListener('DOMContentLoaded', function () {
	  const registerForm = document.getElementById("registerForm");
	  const admitCheck = document.getElementById("admitCheck");
	  const categoryList = document.getElementById("category");
	  const title = document.getElementById("title");
	  const hand = document.getElementById("hand");
	  const delvPrice = document.getElementById("delvPrice");
	  const state = document.getElementById("state");
	  const ifile0 = document.getElementById("ifile0");
	  const content = document.getElementById("content");
	  const deliveryPrice = document.getElementById("deliveryPrice");
	  const tooltipTrigger = document.getElementById("tooltipTrigger");
	  const tooltipBox = document.getElementById("tooltipBox");

	  hand.addEventListener("change", toggleDeliveryPrice);
	  delvPrice.addEventListener("change", toggleDeliveryPrice);

	  if (tooltipTrigger && tooltipBox) {
	    tooltipTrigger.addEventListener("click", function (e) {
	      e.stopPropagation();
	      tooltipBox.classList.toggle("show");
	    });

	    document.addEventListener("click", function (e) {
	      if (!tooltipBox.contains(e.target) && !tooltipTrigger.contains(e.target)) {
	        tooltipBox.classList.remove("show");
	      }
	    });
	  }

	  registerForm.addEventListener("submit", function (e) {
	    if (!admitCheck.checked) {
	      e.preventDefault(); alert("필수 동의를 체크해주세요.");
	    } else if (categoryList.value === "") {
	      e.preventDefault(); alert("카테고리를 선택해야 합니다.");
	    } else if (title.value.trim() === "") {
	      e.preventDefault(); alert("제목을 입력해주세요.");
	    } else if (!hand.checked && !delvPrice.checked) {
	      e.preventDefault(); alert("거래 방식을 선택해주세요.");
	    } else if (delvPrice.checked && deliveryPrice.value.trim() === "") {
	      e.preventDefault(); alert("배송비를 입력해주세요.");
	    } else if (state.value === "") {
	      e.preventDefault(); alert("상품 상태를 선택해주세요.");
	    } else if (ifile0.files.length === 0) {
	      e.preventDefault(); alert("상품 이미지를 1개 이상 등록해주세요.");
	    } else if (content.value.trim() === "") {
	      e.preventDefault(); alert("상품 설명을 입력해주세요.");
	    }
	  });
	});
</script>


<script>
  let imageCount = 0;

  document.addEventListener('DOMContentLoaded', function () {
    const addButton = document.getElementById('addImageButton');
    const fileInputs = [
      document.getElementById('ifile0'),
      document.getElementById('ifile1'),
      document.getElementById('ifile2'),
      document.getElementById('ifile3'),
      document.getElementById('ifile4')
    ];

    addButton.addEventListener('click', function () {
      if (imageCount >= 5) {
        alert('최대 5장까지만 등록할 수 있습니다.');
        return;
      }
      for (let i = 0; i < fileInputs.length; i++) {
        if (!fileInputs[i].files.length) {
          fileInputs[i].click();
          break;
        }
      }
    });
  });

  function readURL(input, index) {
    if (input.files && input.files[0]) {
      const previewArea = document.getElementById('previewArea');
      const addBtn = document.getElementById('addImageButton');

      const reader = new FileReader();
      reader.onload = function (e) {
        const wrapper = document.createElement('div');
        wrapper.className = 'img-wrapper';
        wrapper.style.position = 'relative';
        wrapper.style.width = '100px';
        wrapper.style.height = '100px';
        wrapper.style.marginRight = '5px';
        wrapper.style.marginBottom = '5px';

        const img = document.createElement('img');
        img.src = e.target.result;
        img.style.width = '100%';
        img.style.height = '100%';
        img.style.objectFit = 'cover';
        img.style.borderRadius = '6px';
        img.addEventListener('click', function () {
        	  const zoomedImage = document.getElementById('zoomedImage');
        	  zoomedImage.src = e.target.result;
        	  document.getElementById('imageZoomModal').style.display = 'flex';
        	});
        wrapper.appendChild(img);

        const deleteBtn = document.createElement('button');
        deleteBtn.innerText = '×';
        deleteBtn.style.position = 'absolute';
        deleteBtn.style.top = '-10px';
        deleteBtn.style.right = '-10px';
        deleteBtn.style.backgroundColor = '#ff5c5c';
        deleteBtn.style.color = '#fff';
        deleteBtn.style.border = 'none';
        deleteBtn.style.borderRadius = '50%';
        deleteBtn.style.width = '22px';
        deleteBtn.style.height = '22px';
        deleteBtn.style.fontSize = '14px';
        deleteBtn.style.cursor = 'pointer';
        deleteBtn.style.zIndex = '10';

        deleteBtn.onclick = function () {
          wrapper.remove();
          input.value = '';
          imageCount--;
          if (imageCount < 5) {
            addBtn.style.display = 'inline-block';
          }
        };

        wrapper.appendChild(deleteBtn);
        previewArea.appendChild(wrapper);

        imageCount++;
        if (imageCount >= 5) {
          addBtn.style.display = 'none';
        }
      };
      reader.readAsDataURL(input.files[0]);
    }
  }
  </script>

<script>
  document.addEventListener('DOMContentLoaded', function () {
    const btnOpenAdmit = document.getElementById('btnOpenAdmit');
    const btnCloseAdmit = document.getElementById('btnCloseAdmit');
    const admitModal = document.getElementById('admitModal');

    btnOpenAdmit?.addEventListener('click', () => {
      admitModal.style.display = 'flex';
    });

    btnCloseAdmit?.addEventListener('click', () => {
      admitModal.style.display = 'none';
    });
  });
</script>

<script>
function formatPriceInputWithCaret(input) {
    const selectionStart = input.selectionStart;
    const rawValue = input.value.replace(/[^\d]/g, ''); // 숫자만 남기기

    if (rawValue === '') {
        input.value = '';
        return;
    }

    // 1,000 단위로 포맷팅
    const formatted = parseInt(rawValue, 10).toLocaleString();

    // '원'과 '일'을 붙이기 위해 대여가 부분을 처리
    let formattedValue = formatted + '원';
    if (input.id === 'rentPrice') {
        formattedValue = formatted + '원/일';
    }

    input.value = formattedValue;

    window.requestAnimationFrame(() => {
        // 커서를 숫자 뒤로 이동시킴
        let caretPos = selectionStart;
        // '원/일'의 길이를 고려하여 커서를 설정
        if (input.id === 'rentPrice') {
            caretPos = caretPos + (formattedValue.length - rawValue.length) - 5; // '원/일'의 길이만큼 빼기
        } else {
            caretPos = caretPos + (formattedValue.length - rawValue.length) - 1; // '원'의 길이만큼 빼기
        }

        input.setSelectionRange(caretPos, caretPos);
    });
}

// 숫자만 추출하여 반환하는 함수
function stripPriceFormat(value) {
    return value.replace(/[^\d]/g, ''); // 숫자만 추출
}

// 실시간 포맷팅
document.addEventListener('DOMContentLoaded', function () {
    const salePriceInput = document.getElementById('salePrice');
    const rentPriceInput = document.getElementById('rentPrice');
    const deliveryPriceInput = document.getElementById('deliveryPrice');
    const secPriceInput = document.getElementById('secPrice'); // 보증금 필드 추가

    // 실시간 포맷팅 (판매가, 대여가, 보증금)
    salePriceInput.addEventListener('input', function () {
        formatPriceInputWithCaret(this);
    });

    rentPriceInput.addEventListener('input', function () {
        formatPriceInputWithCaret(this);
    });

    deliveryPriceInput.addEventListener('input', function () {
        formatPriceInputWithCaret(this);
    });

    secPriceInput.addEventListener('input', function () { // 보증금도 포맷팅
        formatPriceInputWithCaret(this);
    });

    // 제출 전 숫자만 추출
    const registerForm = document.getElementById('registerForm');
    registerForm.addEventListener('submit', function () {
        salePriceInput.value = stripPriceFormat(salePriceInput.value);
        rentPriceInput.value = stripPriceFormat(rentPriceInput.value);
        deliveryPriceInput.value = stripPriceFormat(deliveryPriceInput.value);
        secPriceInput.value = stripPriceFormat(secPriceInput.value); // 보증금 숫자만 추출
    });
});

</script>


<script>
function closeImageModal() {
  document.getElementById('imageZoomModal').style.display = 'none';
  document.getElementById('zoomedImage').src = '';
}
</script>

<script>
  document.addEventListener('DOMContentLoaded', function () {
    // flatpickr 초기화
    flatpickr("#startDate", {
      dateFormat: "Y-m-d",  // "yyyy-mm-dd" 형식으로 날짜 입력
      minDate: "today",  // 오늘 날짜 이후로만 선택 가능
      onChange: function(selectedDates, dateStr, instance) {
        // 선택한 날짜가 변경되면 'endDate'의 최소 날짜를 갱신
        document.getElementById('endDate')._flatpickr.set("minDate", selectedDates[0]);
      }
    });

    flatpickr("#endDate", {
      dateFormat: "Y-m-d",  // "yyyy-mm-dd" 형식으로 날짜 입력
      minDate: "today",  // 오늘 날짜 이후로만 선택 가능
    });
  });
</script>

<script>
function toggleDeliveryPrice() {
	  const hand = document.getElementById("hand");
	  const delvPrice = document.getElementById("delvPrice");
	  const deliveryPrice = document.getElementById("deliveryPrice");

	  // 직거래를 선택했을 때
	  if (hand.checked) {
	    deliveryPrice.disabled = true;
	    deliveryPrice.value = ''; // 배송비 초기화
	    deliveryPrice.placeholder = "배송비 없음";
	  }
	  // 택배 거래를 선택했을 때
	  else if (delvPrice.checked) {
	    deliveryPrice.disabled = false;
	    deliveryPrice.placeholder = "배송비를 입력하세요";
	  }
	  // 거래 방식을 선택하지 않았을 때
	  else {
	    deliveryPrice.disabled = true;
	    deliveryPrice.value = ''; // 배송비 초기화
	    deliveryPrice.placeholder = "거래방식을 선택하세요";
	  }
	}

	window.onload = function () {
	  const hand = document.getElementById("hand");
	  const delvPrice = document.getElementById("delvPrice");

	  // 페이지 로드 시 상태를 갱신
	  toggleDeliveryPrice();

	  // 거래방식 선택 변경 시 동작
	  hand.addEventListener("change", toggleDeliveryPrice);
	  delvPrice.addEventListener("change", toggleDeliveryPrice);
	};
</script>

<script>
  window.addEventListener('DOMContentLoaded', function () {
    const locationFromCookie = "${cookieLocation}"; // JSP에서 전달된 쿠키 위치값

    function checkLocationHighlight() {
      if (!locationFromCookie || locationFromCookie.trim() === "") {
        const locationButton = document.getElementById("btn-location");
        if (locationButton) {
          locationButton.style.border = "2px solid red"; // 빨간 테두리 강조
          alert("위치 정보가 없으니 위치를 갱신해 주세요!");
          window.scrollTo(0, 0);
        }
        return false;
      }
      return true;
    }

    // 진입 시 바로 검사
    checkLocationHighlight();

    // 등록 버튼 누를 때도 검사
    const registerForm = document.getElementById("registerForm");
    if (registerForm) {
      registerForm.addEventListener("submit", function (e) {
        if (!checkLocationHighlight()) {
          e.preventDefault(); // 등록 막음
        }
      });
    }
  });
</script>


</body>
</html>