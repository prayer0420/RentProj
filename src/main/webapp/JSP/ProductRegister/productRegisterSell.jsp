<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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
		const ifile1 = document.getElementById("ifile0");
		const content = document.getElementById("content");
		const deliveryPrice = document.getElementById("deliveryPrice");
      
		const copiedInputs = document.querySelectorAll('.copied-image-input');
		
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
    }else if(ifile0.files.length === 0){
    	e.preventDefault();
    	alert("상품 이미지를 선택하셔야 합니다.");
    }else if (content.value.trim() === "") {
        e.preventDefault();
        alert("상품에 대한 내용을 입력하셔야 합니다.");
    }
    });
      
      toggleDeliveryPrice();
    };

    
    let currentInputIndex = 0;

    document.addEventListener('DOMContentLoaded', function() {
      const addButton = document.getElementById('addImageButton');

      addButton.addEventListener('click', function() {
        if (currentInputIndex >= 5) {
          alert('최대 5장까지만 등록할 수 있습니다.');
          return;
        }
        document.getElementById('ifile' + currentInputIndex).click();
      });
    });

    // 하나의 파일 읽어서 미리보기 + 삭제버튼 추가
    function readURL(input, index) {
      if (input.files && input.files[0]) {
        const previewArea = document.getElementById('previewArea');

        const reader = new FileReader();
        reader.onload = function(e) {
          // 미리보기 이미지 div 생성
          const wrapper = document.createElement('div');
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
          wrapper.appendChild(img);

          // 삭제 버튼 생성
          const deleteBtn = document.createElement('button');
          deleteBtn.innerText = 'X';
          deleteBtn.style.position = 'absolute';
          deleteBtn.style.top = '0';
          deleteBtn.style.right = '0';
          deleteBtn.style.backgroundColor = 'red';
          deleteBtn.style.color = 'white';
          deleteBtn.style.border = 'none';
          deleteBtn.style.borderRadius = '50%';
          deleteBtn.style.width = '20px';
          deleteBtn.style.height = '20px';
          deleteBtn.style.cursor = 'pointer';
          deleteBtn.style.fontSize = '12px';
          
          deleteBtn.onclick = function() {
            wrapper.remove(); // 미리보기 삭제
            input.value = ""; // 해당 input 비워주기

            // 삭제하고나면 input index 다시 써야 하니까 currentInputIndex 하나 줄인다
            currentInputIndex--;
          };

          wrapper.appendChild(deleteBtn);

          previewArea.appendChild(wrapper);

          currentInputIndex++;
        }
        reader.readAsDataURL(input.files[0]);
      }
    }


    // plus.jpg 클릭하면 input 파일창 열기
    document.addEventListener('DOMContentLoaded', function() {
    	const addButton = document.getElementById('addImageButton');
    	const fileInput = document.getElementById('ifile');

    	addButton.addEventListener('click', function() {
    		fileInput.click();
    	});
    });
    
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
  <jsp:include page="../Header/header.jsp" />
  <main class="form-wrapper">
    <h1 class="form-title">상품 판매 등록</h1>
    <form id="registerForm" action="<%=request.getContextPath()%>/sell" method="post" enctype="multipart/form-data">
      <input type="hidden" name="tradeType" value="판매" />

      <section class="form-section">
        <label for="title">제목</label>
        <input type="text" id="title" name="title" placeholder="상품 제목을 입력하세요" />
      </section>

      <section class="form-section">
        <label for="category">카테고리</label>
        <select id="category" name="categoryNo">
          <option value="">카테고리 선택</option>
          <option value="2">의류/패션/악세사리</option>
          <option value="3">PC용품/디지털</option>
          <option value="4">가전제품</option>
          <option value="5">뷰티/미용</option>
          <option value="6">캠핑/스포츠/레져</option>
          <option value="7">생활/주방용품</option>
          <option value="8">가구/인테리어</option>
          <option value="9">유아/출산</option>
          <option value="10">애완동물용품</option>
          <option value="11">기타</option>
        </select>
      </section>

      <section class="form-section price-section">
        <label for="salePrice">판매가
          <span id="tooltipTrigger" class="info-icon">&#9432;</span>
        </label>
        <input type="text" id="salePrice" name="salePrice" placeholder="₩ 가격을 입력하세요" />
        <div class="tooltip" id="tooltipBox">
          브론즈 : 5%<br>실버 : 4.5%<br>골드 : 4%<br>플레티넘 : 3.5%<br>다이아 : 3%<br>Re:NT : 2.5%
        </div>
      </section>

      <section class="form-section">
        <label>거래방식</label>
        <div class="radio-group">
          <input type="radio" name="deliveryStatus" id="hand" value="직거래" />
          <label for="hand">직거래</label>
          <input type="radio" name="deliveryStatus" id="delvPrice" value="택배거래" />
          <label for="delvPrice">택배</label>
        </div>
        <input type="text" id="deliveryPrice" name="deliveryPrice" placeholder="배송비 (₩)" disabled />
      </section>

      <section class="form-section">
        <label for="state">상품 상태</label>
        <select id="state" name="state">
          <option value="">선택하세요</option>
          <option value="새상품(미사용)">새상품(미사용)</option>
          <option value="사용감적음">사용감 적음</option>
          <option value="사용감많음">사용감 많음</option>
          <option value="고장/파손">고장/파손</option>
        </select>
      </section>

      <section class="form-section">
        <label for="content">상품 설명</label>
        <textarea id="content" name="content" placeholder="상품 설명을 적어주세요"></textarea>
      </section>

      <section class="form-section">
        <label>상품 이미지 (최대 5장)</label>
        <div class="image-upload-container">
          <div id="previewArea" class="image-preview"></div>
          <div class="img-upload-box" id="addImageButton"></div>
        </div>
        <input type="file" name="imgList0" id="ifile0" accept="image/*" style="display: none;" onchange="readURL(this, 0)" />
        <input type="file" name="imgList1" id="ifile1" accept="image/*" style="display: none;" onchange="readURL(this, 1)" />
        <input type="file" name="imgList2" id="ifile2" accept="image/*" style="display: none;" onchange="readURL(this, 2)" />
        <input type="file" name="imgList3" id="ifile3" accept="image/*" style="display: none;" onchange="readURL(this, 3)" />
        <input type="file" name="imgList4" id="ifile4" accept="image/*" style="display: none;" onchange="readURL(this, 4)" />
      </section>
		 <div id="imageZoomModal" class="modal-zoom">
   			<div class="modal-content">
     			<img id="zoomedImage" src="" alt="확대 이미지" />
     			<button onclick="closeImageModal()">닫기</button>
   			</div>
  		</div>	
		
      <section class="form-section checkbox-row">
        <label>
          <input type="checkbox" id="admitCheck" /> 필수 안내에 동의합니다
        </label>
        <button type="button" class="btn-open-modal-admit">자세히 보기</button>
        <div class="modal-admit" style="display: none;">
          <div class="modal-admit-body">
            <h5>Re:NT는 거래시스템을 제공하는 중개 플랫폼입니다. 거래 책임은 당사자에게 있습니다.</h5>
            <h5>렌탈 거래 시 보증금, 서류 확인 등은 사용자 책임입니다.</h5>
            <button class="cancle-admit" type="button">확인</button>
          </div>
        </div>
      </section>

      <button type="submit" class="submit-btn">등록하기</button>
    </form>
  </main>
  <jsp:include page="productAddressModal.jsp" />
</body>
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      const tooltipTrigger = document.getElementById("tooltipTrigger");
      const tooltipBox = document.getElementById("tooltipBox");
      const addBtn = document.getElementById("addImageButton");
      const preview = document.getElementById("previewArea");
      const fileInputs = ["ifile0", "ifile1", "ifile2", "ifile3", "ifile4"].map(id => document.getElementById(id));
      let imageCount = 0;

      tooltipTrigger.addEventListener("click", function (e) {
        tooltipBox.style.display = tooltipBox.style.display === "block" ? "none" : "block";
      });

      addBtn.addEventListener("click", function () {
        if (imageCount >= 5) return;
        for (let i = 0; i < fileInputs.length; i++) {
          if (!fileInputs[i].files.length) {
            fileInputs[i].click();
            break;
          }
        }
      });

      window.readURL = function(input, index) {
        if (input.files && input.files[0]) {
          const reader = new FileReader();
          reader.onload = function (e) {
            const wrapper = document.createElement("div");
            
            const img = document.createElement("img");
            img.src = e.target.result;
            img.setAttribute("onclick", "openImageModal(this.src)");
            img.style.cursor = "pointer";

            const del = document.createElement("button");
            del.innerText = "×";
            del.onclick = () => {
              wrapper.remove();
              input.value = "";
              imageCount--;
              if (imageCount < 5) addBtn.style.display = "flex";
            };
            wrapper.appendChild(img);
            wrapper.appendChild(del);
            preview.appendChild(wrapper);
            imageCount++;
            if (imageCount === 5) addBtn.style.display = "none";
          }
          reader.readAsDataURL(input.files[0]);
        }
      }

      const admitBtn = document.querySelector(".btn-open-modal-admit");
      const modal = document.querySelector(".modal-admit");
      const closeModal = document.querySelector(".cancle-admit");

      admitBtn.addEventListener("click", () => {
        modal.style.display = "flex";
      });
      closeModal.addEventListener("click", () => {
        modal.style.display = "none";
      });
    });
    
    
    function openImageModal(src) {
        document.getElementById("zoomedImage").src = src;
        document.getElementById("imageZoomModal").style.display = "flex";
      }

      function closeImageModal() {
        document.getElementById("imageZoomModal").style.display = "none";
      }
  </script>

</html>