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
        //이미지 파일
        function readURL(input){
        	if(input.files && input.files[0]){
        		var reader = new FileReader();
        		reader.onload = function(e){
        			document.getElementById("preview").src = e.target.result;
        		}
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
				<h4>상품이미지</h4>
				<hr>
				<img alt="상품이미지" src="<%=request.getContextPath()%>/img/plus.jpg"
					id="preview" onclick="document.getElementById('ifile').click();">
				<input type="file" name="img" id="ifile" accept="image/*"
					style="display: none" onchange="readURL(this)">
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