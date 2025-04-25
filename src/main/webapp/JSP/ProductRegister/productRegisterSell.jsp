<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script>
  const contextPath = '${pageContext.request.contextPath}';
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/CSS/productRegister/productRegisterSell.css">
<script>
    window.onload = function () {
      const prod = document.querySelector('.modal-prodState');
      const admit = document.querySelector('.modal-admit');
      const addr = document.querySelector('.modal-addr');
      const addrPlus = document.querySelector('.modal-addrPlus')
      const tooltipTrigger = document.getElementById("tooltipTrigger");
      const tooltipBox = document.getElementById("tooltipBox");

      const btnOpenProd = document.querySelector('.btn-open-modal-prodState');
      const btnCancleProd = document.querySelector('.cancle-prod');
      const btnOpenAdmit = document.querySelector('.btn-open-modal-admit');
      const btnCancleAdmit = document.querySelector('.cancle-admit');
      const btnOpenAddr = document.querySelector('.btn-open-modal-addr');
      const btnCancleAddr = document.querySelector('.cancle-addr');
      //const btnOpenAddrPlus = document.querySelector('.btn-open-modal-addrPlus');
      //const cancleBtn = document.querySelector('.cancle-btn');

      const registerForm = document.getElementById("registerForm");
	  const admitCheck = document.getElementById("admitCheck");
	  const categoryList = document.getElementById("categoryList");
	  const salePrice = document.getElementById("salePrice");
		const title = document.getElementById("title");
		const hand = document.getElementById("hand");
		const delvPrice = document.getElementById("delvPrice");
		const state1 = document.getElementById("state1");
		const state2 = document.getElementById("state2");
		const state3 = document.getElementById("state3");
		const state4 = document.getElementById("state4");
		const ifile = document.getElementById("ifile");
		const content = document.getElementById("content");
		const deliveryPrice = document.getElementById("deliveryPrice");
      
		hand.addEventListener("change", toggleDeliveryPrice);
        delvPrice.addEventListener("change", toggleDeliveryPrice);

      btnOpenProd.addEventListener("click", () => {
        prod.style.display = "flex";
      });
      btnCancleProd.addEventListener("click", () => {
        prod.style.display = "none";
        const selected = document.querySelector('input[name="state"]:checked');
        const result = document.querySelector('.stateDiv');
        if (selected) {
          result.innerText = '상품상태 : '+selected.value;
        } else {
          result.innerText = '상품상태 : 없음';
        }
        
      });
      btnOpenAdmit.addEventListener("click", () => {
        admit.style.display = "flex";
      });
      btnCancleAdmit.addEventListener("click", () => {
        admit.style.display = "none";
      });
      
      //btnOpenAddrPlus.addEventListener("click", () => {
      //  addrPlus.style.display = "flex"
      //});
      //cancleBtn.addEventListener("click", () => {
      //  addrPlus.style.display = "none";
      //  addr.style.display = "flex";
      //});
      tooltipTrigger.addEventListener("click", () => {
        tooltipBox.style.display = tooltipBox.style.display === "block" ? "none" : "block";
      });
      // 클릭 외부 영역 클릭 시 툴팁 닫기
      document.addEventListener("click", function (event) {
        if (!tooltipTrigger.contains(event.target) && !tooltipBox.contains(event.target)) {
          tooltipBox.style.display = "none";
        }
      });
      
      //필수등록 여부
      registerForm.addEventListener("submit", function (e) {
    if (!admitCheck.checked) {
        e.preventDefault();
        alert("상품등록을 위해 필수 동의를 체크해야 합니다.");
    } else if(categoryList.value === "카테고리 선택"){
        e.preventDefault();
        alert("카테고리를 선택해야 합니다.");
    } else if(title.value === ""){
        e.preventDefault();
        alert("제목을 입력해주세요");
    } else if(salePrice.value === ""){
        e.preventDefault();
        alert("판매금액을 설정하셔야 합니다.");
    } else if(!hand.checked && !delvPrice.checked) {
        e.preventDefault();
        alert("거래방식을 선택해야 합니다.");
    } else if(delvPrice.checked && deliveryPrice.value.trim() === ""){
        e.preventDefault();
        alert("배송비를 설정하셔야 합니다.");
    } else if(!state1.checked && !state2.checked && !state3.checked && !state4.checked){
        e.preventDefault();
        alert("상품상태를 선택하셔야 합니다.");
    } else if (content.value.trim() === "") {
        e.preventDefault();
        alert("상품에 대한 내용을 입력하셔야 합니다.");
      }else if(document.querySelectorAll('.copied-image-input').length === 0 ||
    	        !Array.from(document.querySelectorAll('.copied-image-input')).some(input => input.files.length > 0)){
    	    e.preventDefault();
    	    alert("상품 이미지를 선택하셔야 합니다.");
    	}
    });
      toggleDeliveryPrice();
      createImageCard();
    };
    //이미지 파일
let imageCount = 0;
const MAX_IMAGES = 5;

function createImageCard() {
	  if (imageCount >= MAX_IMAGES) return;

	  const container = document.getElementById('imageContainer');
	  const card = document.createElement('div');
	  card.className = 'image-card';

	  const previewId = `preview${imageCount}`;
	  const inputId = `ifile${imageCount}`;
	  const nameAttr = `imgList${imageCount}`;  // 반드시 이 name으로!

	  const img = document.createElement('img');
	  img.src = `${contextPath}/img/plus.jpg`;
	  img.id = previewId;
	  img.style.cursor = 'pointer';

	  const input = document.createElement('input');
	  input.type = 'file';
	  input.accept = 'image/*';
	  input.name = nameAttr;
	  input.id = inputId;
	  input.classList.add('product-image');  // 식별용
	  input.style.display = 'none'; // 안 보여도 form 안에 있음

	  const deleteBtn = document.createElement('button');
	  deleteBtn.innerText = 'X';
	  deleteBtn.type = 'button';
	  deleteBtn.className = 'img-delete-btn';
	  deleteBtn.style.display = 'none';

	  deleteBtn.onclick = () => {
	    if (container.children.length > 1) {
	      container.removeChild(card);
	      imageCount--;
	    } else {
	      alert("이미지는 최소 1장 이상 등록해야 합니다.");
	    }
	  };

	  img.addEventListener('click', () => input.click());

	  input.addEventListener('change', function () {
	    if (input.files && input.files[0]) {
	      const reader = new FileReader();
	      reader.onload = function (e) {
	        img.src = e.target.result;
	        deleteBtn.style.display = 'block';

	        // 다음 카드 생성
	        if (container.querySelectorAll('.image-card').length < MAX_IMAGES) {
	          imageCount++;
	          createImageCard();
	        }
	      };
	      reader.readAsDataURL(input.files[0]);
	    }
	  });

	  card.appendChild(img);
	  card.appendChild(input);
	  card.appendChild(deleteBtn);
	  container.appendChild(card);
	}


//✅ 모달 확인 버튼 클릭 시 선택 이미지 메인에 표시 및 실제 input 복사
function confirmImages() {
  const previewArea = document.getElementById('selectedImagePreview');
  previewArea.innerHTML = '';

  const mainForm = document.getElementById('registerForm');

  // 기존 복사본 제거
  document.querySelectorAll('.copied-image-input').forEach(el => el.remove());

  const inputs = document.querySelectorAll('#imageContainer input[type="file"]');
  let validImageCount = 0;

  inputs.forEach((input, index) => {
    const file = input.files[0];
    if (file) {
      validImageCount++;

      // 미리보기
      const img = document.createElement('img');
      img.src = URL.createObjectURL(file);
      img.style.width = '100px';
      img.style.height = '100px';
      img.style.objectFit = 'cover';
      previewArea.appendChild(img);

      // ✅ 새로운 input 생성 + 파일 복사
      const newInput = document.createElement('input');
      newInput.type = 'file';
      newInput.name = `imgList${index}`;
      newInput.classList.add('copied-image-input');
      newInput.style.display = 'none';

      // 🔥 핵심: DataTransfer 사용해서 파일 넣어줘야 실제 전송됨
      const dt = new DataTransfer();
      dt.items.add(file);
      newInput.files = dt.files;

      mainForm.appendChild(newInput);
    }
  });

  if (validImageCount === 0) {
    alert("최소 한 장의 이미지를 선택해야 합니다.");
  } else {
    closeImageModal();
  }
}


    function readURL(input, previewId) {
    	  if (input.files && input.files[0]) {
    	    const reader = new FileReader();
    	    reader.onload = function (e) {
    	      const img = document.getElementById(previewId);
    	      if (img) {
    	        img.src = e.target.result;
    	      }
    	    };
    	    reader.readAsDataURL(input.files[0]);
    	  }
    	}
    
    function toggleDeliveryPrice() {
        if (hand.checked) {
            deliveryPrice.disabled = true;
            deliveryPrice.value = 0;
            
        } else if (delvPrice.checked) {
            deliveryPrice.disabled = false;
        }
    }
    
    function openAddressModal() {
		document.getElementById('addressModal').style.display = 'flex';
	}
	function closeAddressModal() {
		document.getElementById('addressModal').style.display = 'none';
	}
	function openImageModal(){
		document.getElementById('imageModal').style.display = 'flex';
	}
	function closeImageModal(){
		document.getElementById('imageModal').style.display = 'none';
	}
	
  </script>
</head>
<body>
	<jsp:include page="../Header/header.jsp"></jsp:include>
	<form id="registerForm" action="<%=request.getContextPath()%>/sell"
		method="post" enctype="multipart/form-data" class="container">
		<input type="hidden" name="tradeType" value="판매">
		<div class="container-header">
			<h2>판매등록</h2>
		</div>
		<hr>
		<div class="container-admit">
			<input type="checkbox" id="admitCheck">
			<h3>상품등록 필수 동의</h3>
			<div class="modal-admit">
				<div class="modal-admit-body">
					<hr>
					<h5>Re:NT는 거래시스템을 제공해드리는 중개사업이며 빌리 중고거래 및 렌탈 거래시 발생하는 책임은 각
						당사자에게 있음을 알려드립니다.</h5>
					<h5>특히 렌탈시 발생할 수 있는 문제에 대하여 빌리는 판매자가 정해놓은 보증금으로 처리해드리며 필요한
						서류들은 각 당사자들끼리 제공 받으셔야 합니다.</h5>
					<h5>각 서류에 대해 빌리는 일체 관여하지 않음을 알려드립니다. 확인 부탁드립니다.</h5>
					<hr>
					<button class="cancle-admit" type="button">확인</button>
				</div>
			</div>
			<button type="button" class="btn-open-modal-admit">자세히 보기</button>
		</div>
		<hr>
		<div class="container-category">
			<select name="categoryNo" id="categoryList" class="category-list">
				<option selected="">카테고리 선택</option>
				<option value="1">의류/패션/악세사리</option>
				<option value="2">PC용품/디지털</option>
				<option value="3">가전제품</option>
				<option value="4">뷰티/미용</option>
				<option value="5">캠핑/스포츠/레져</option>
				<option value="6">생활/주방용품</option>
				<option value="7">가구/인테리어</option>
				<option value="8">유아동/출산</option>
				<option value="9">애완동물용품</option>
				<option value="10">기타</option>
			</select> <input type="text" id="title" name="title" placeholder="제목을 입력하세요">
		</div>
		<div class="container-charge">
			<div class="wrap"
				style="position: relative; display: inline-block; margin-top: 5px;">
				<h6 id="tooltipTrigger"
					style="cursor: pointer; margin-right: 740px;">수수료안내</h6>
				<div class="tooltip" id="tooltipBox">
					브론즈 : 5%<br> 실버 : 4.5%<br> 골드 : 4%<br> 플레 : 3.5%<br>
					다이아 : 3%<br> Re:NT : 2.5%
				</div>
			</div>
		</div>
		<div class="container-sale">
			<h4>판매가</h4>
			<input type="text" placeholder="판매가" id="salePrice" name="salePrice">
		</div>
		<div class="container-delivery">
			<h4>배송비</h4>
			<input type="radio" id="hand" name="deliveryStatus"
				class="delivery-radio" value="직거래"> <label for="hand"
				class="delivery-label">결제 후 직접거래</label> <input type="radio"
				name="deliveryStatus" class="delivery-radio" id="delvPrice"
				value="택배거래"> <label for="delvPrice" class="delivery-label">택배거래</label>
			<input type="text" class="rent-security" id="deliveryPrice"
				name="deliveryPrice" placeholder="배송비" disabled>
		</div>
		<div class="container-prodstate">
			<h4>상품상태</h4>
			<div class="modal-prodState">
				<div class="modal-prodState-body">
					<h3>상품의 상태를 선택하세요</h3>
					<hr>
					<input type="radio" id="state1" name="state" class="state-radio"
						value="새상품(미사용)"> <label for="state1" class="state-label">새상품(미사용)</label>
					<input type="radio" id="state2" name="state" class="state-radio"
						value="사용감적음"> <label for="state2" class="state-label">사용감
						적음</label> <input type="radio" id="state3" name="state"
						class="state-radio" value="사용감 많음"> <label for="state3"
						class="state-label">사용감 많음</label> <input type="radio" id="state4"
						name="state" class="state-radio" value="고장/파손"> <label
						for="state4" class="state-label">고장/파손</label>
					<button type="button" class="cancle-prod">확인</button>
				</div>
			</div>
			<button type="button" class="btn-open-modal-prodState">상품상태선택</button>
			<div class="stateDiv">상품상태 : 없음</div>
		</div>

		<div class="container-addr">

			<h4>거래지역</h4>
			<button type="button" class="btn-open-modal-addr"
				onclick="openAddressModal()">배송지 선택</button>
			<div class="address-title">
				<span class="address-name"></span>
				<button class="default-address"></button>
			</div>
			<div class="address-info">
				<span class="phone"></span><br> <span class="addressRegion"></span>
				<input type="hidden" name="deliveryAddr" id="deliveryAddressInput">
			</div>
		</div>

		<div class="container-image">
			<h4>상품이미지</h4>
			<button type="button" class="btn-open-modal-image"
				onClick="openImageModal()">상품 이미지 선택</button>
			<div id="selectedImagePreview" class="selected-image-preview"
				style="display: flex; gap: 10px; margin-top: 10px;"></div>
			<!-- 
			<img alt="상품이미지" src="<%=request.getContextPath()%>/img/plus.jpg"
				id="preview" onclick="document.getElementById('ifile').click();">
			<input type="file" name="img" id="ifile" accept="image/*"
				style="display: none" onchange="readURL(this)">
			-->
		</div>
		<jsp:include page="productImageModal.jsp"></jsp:include>

		<div class="container-content">
			<textarea name="content" id="content" placeholder="내용을 입력하세요"></textarea>
		</div>
		<button type="submit">확인</button>
	</form>
	<jsp:include page="productAddressModal.jsp"></jsp:include>
</body>
</html>