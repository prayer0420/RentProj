<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/CSS/productRegister/productRegisterFree.css">
<script>
        window.onload = function(){
            const addr = document.querySelector('.modal-addr');
            const addrPlus = document.querySelector('.modal-addrPlus')
            const btnOpenAddr = document.querySelector('.btn-open-modal-addr');
            const btnCancleAddr = document.querySelector('.cancle-addr');
            const btnOpenAddrPlus = document.querySelector('.btn-open-modal-addrPlus');
            const cancleBtn = document.querySelector('.cancle-btn');

            btnOpenAddr.addEventListener("click", () => {
                addr.style.display = "flex";
                addrPlus.style.display = "none";
            });
            btnCancleAddr.addEventListener("click", () => {
                addr.style.display = "none";
            });
            btnOpenAddrPlus.addEventListener("click", () => {
                addrPlus.style.display = "flex"
            });
            cancleBtn.addEventListener("click", () => {
                addrPlus.style.display = "none";
                addr.style.display = "flex";
            });
            
            //필수등록 여부
            registerForm.addEventListener("submit", function (e) {
            	console.log(categoryList);
                if(categoryList.value==="카테고리 선택"){
                	e.preventDefault();
                	alert("카테고리를 선택해야 합니다.");
                }else if(title.value===""){
                	e.preventDefault();
                	alert("제목을 입력해주세요");
                }else if(ifile.files.length === 0){
                	e.preventDefault();
                	alert("상품 이미지를 선택하셔야 합니다.");
                }else if(content.value.trim() === ""){
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
    </script>
</head>
<body>
	<jsp:include page="../Header/header.jsp"></jsp:include>
	<form action="<%=request.getContextPath()%>/free" method="post"
		enctype="multipart/form-data" class="container">
		<input type="hidden" name="tradeType" value="무료나눔">
		<div class="container">
			<div class="container-header">
				<h2>무료나눔등록</h2>
			</div>
			<div class="container-category">
				<select name="categoryNo" id="categoryNo" class="category-list">
					<option selected="">카테고리 선택</option>
					<option value="2">의류/패션/악세사리</option>
					<option value="3">PC용품/디지털</option>
					<option value="4">가전제품</option>
					<option value="5">뷰티/미용</option>
					<option value="6">캠핑/스포츠/레져</option>
					<option value="7">생활/주방용품</option>
					<option value="8">가구/인테리어</option>
					<option value="9">유아동/출산</option>
					<option value="10">애완동물용품</option>
					<option value="11">기타</option>
				</select> <input type="text" placeholder="제목을 입력하세요" name="title">
			</div>
			<div class="container-addr">
				<div class="address-title">
					<span class="address-name"></span>
					<button class="default-address"></button>
				</div>
				<div class="address-info">
					<span class="phone"></span><br> <span class="addressRegion"></span>
					<input type="hidden" name="deliveryAddr" id="deliveryAddressInput">
				</div>
				<h4>거래지역</h4>
				<button type="button" class="btn-open-modal-addr"
					onclick="openAddressModal()">배송지 선택</button>
			</div>
			<div class="container-image">
				<h4>상품이미지 (최대 5장)</h4>
				<hr>

				<div id="previewArea"
					style="display: flex; gap: 10px; flex-wrap: wrap;">
					<img alt="상품추가" src="<%=request.getContextPath()%>/img/plus.jpg"
						id="addImageButton"
						style="cursor: pointer; width: 100px; height: 100px; object-fit: cover;">
				</div>

				<input type="file" name="imgList0" id="ifile0" accept="image/*"
					style="display: none" onchange="readURL(this, 0)"> <input
					type="file" name="imgList1" id="ifile1" accept="image/*"
					style="display: none" onchange="readURL(this, 1)"> <input
					type="file" name="imgList2" id="ifile2" accept="image/*"
					style="display: none" onchange="readURL(this, 2)"> <input
					type="file" name="imgList3" id="ifile3" accept="image/*"
					style="display: none" onchange="readURL(this, 3)"> <input
					type="file" name="imgList4" id="ifile4" accept="image/*"
					style="display: none" onchange="readURL(this, 4)">
			</div>

			<div class="container-content">
				<textarea name="content" id="content" placeholder="내용을 입력하세요"></textarea>
			</div>

			<button type="submit">확인</button>
		</div>
	</form>
	<jsp:include page="productAddressModal.jsp"></jsp:include>
</body>
</html>