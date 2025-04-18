<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/productRegister/productRegisterRentSell.css">
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
			const startDate = document.getElementById("startDate");
			const endDate = document.getElementById("endDate");
			const rentPrice = document.getElementById("rentPrice");
			const secPrice = document.getElementById("secPrice");
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
            });
            btnOpenAdmit.addEventListener("click", () => {
                admit.style.display = "flex";
            });
            btnCancleAdmit.addEventListener("click", () => {
                admit.style.display = "none";
            });
            btnOpenAddr.addEventListener("click", () => {
                addr.style.display = "flex";
                addrPlus.style.display = "none";
            });
            btnCancleAddr.addEventListener("click", () => {
                addr.style.display = "none";
            });
           // btnOpenAddrPlus.addEventListener("click", () => {
           //     addrPlus.style.display = "flex"
           // });
           // cancleBtn.addEventListener("click", () => {
           //     addr.style.display = "flex";
           //    addrPlus.style.display = "none";
           // });

                tooltipTrigger.addEventListener("click", () => {
                    tooltipBox.style.display = tooltipBox.style.display === "block" ? "none" : "block";
                });

                document.addEventListener("click", function (event) {
                    if (!tooltipTrigger.contains(event.target) && !tooltipBox.contains(event.target)) {
                        tooltipBox.style.display = "none";
                    }
                });
                
                //시작 날짜보다 이르게 선택x
                document.getElementById("startDate").addEventListener("change", function () {
                    const startDate = this.value;
                    document.getElementById("endDate").min = startDate;
                });
                
                //필수등록 여부
                registerForm.addEventListener("submit", function (e) {
                	console.log(categoryList);
                    if (!admitCheck.checked) {
                        e.preventDefault(); // 폼 제출 막기
                        alert("상품등록을 위해 필수 동의를 체크해야 합니다.");
                    }else if(categoryList.value==="카테고리 선택"){
                    	e.preventDefault();
                    	alert("카테고리를 선택해야 합니다.");
                    }else if(title.value===""){
                    	e.preventDefault();
                    	alert("제목을 입력해주세요");
                    }else if(salePrice.value === ""){
                      	e.preventDefault();
                      	alert("판매금액을 설정하셔야 합니다.");
                    }else if(rentPrice.value === ""){
                    	e.preventDefault();
                    	alert("하루치 대여금액을 설정하셔야 합니다.");
                    }else if(secPrice.value === ""){
                    	e.preventDefault();
                    	alert("보증금을 설정하셔야 합니다.");
                    }else if(!hand.checked && !delvPrice.checked) {
                        e.preventDefault();
                        alert("거래방식을 선택해야 합니다.");
                    }else if(delvPrice.checked && deliveryPrice.value.trim() === ""){
                    	e.preventDefault();
                    	alert("배송비를 설정하셔야 합니다.");
                    }else if(startDate.value === ""){
                    	e.preventDefault();
                    	alert("대여시작일을 선택해야 합니다.");
                    }else if(endDate.value === ""){
                    	e.preventDefault();
                    	alert("대여반납일을 선택해야 합니다.");
                    }else if(!state1.checked && !state2.checked && !state3.checked && !state4.checked){
                    	e.preventDefault();
                    	alert("상품상태를 선택하셔야 합니다.");
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
        
    </script>
</head>
<body>
<jsp:include page="../Header/header.jsp"></jsp:include>
	<form id="registerForm" action="<%=request.getContextPath()%>/rentSell"
		method="post" enctype="multipart/form-data" class="container">
		<input type="hidden" name="tradeType" value="대여/판매">
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
                    <h5>Re:NT는 거래시스템을 제공해드리는 중개사업이며 빌리 중고거래 및 렌탈 거래시 발생하는 책임은 각 당사자에게 있음을 알려드립니다.</h5>
                    <h5>특히 렌탈시 발생할 수 있는 문제에 대하여 빌리는 판매자가 정해놓은 보증금으로 처리해드리며 필요한 서류들은 각 당사자들끼리 제공 받으셔야 합니다.</h5>
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
            </select>
            <input type="text" id="title" name="title" placeholder="제목을 입력하세요">
        </div>
        <div class="container-charge">
            <div class="wrap" style="position: relative; display: inline-block; margin-top: 5px;">
                <h6 id="tooltipTrigger" style="cursor: pointer; margin-right: 740px;">수수료안내</h6>
                <div class="tooltip" id="tooltipBox">
                    브론즈 : 5%<br>
                    실버 : 4.5%<br>
                    골드 : 4%<br>
                    플레 : 3.5%<br>
                    다이아 : 3%<br>
                    Re:NT : 2.5%
                </div>
            </div>
        </div>
        <div class="container-sale">
            <h4>판매가</h4>
            <input type="text" placeholder="판매가" id="salePrice" name="salePrice">
        </div>
        <div class="container-rent">
            <h4>대여1일 기준 금액</h4>
            <input type="text" id="rentPrice" class="rent-price" placeholder="빌리기 가격" name="rentPrice">
        </div>
        <div class="container-security">
            <h4>보증금</h4>
            <input type="text" id="secPrice" class="rent-security" placeholder="보증금 가격"
            	id="secPrice" name="secPrice">
        </div>
        <div class="container-delivery">
           <input type="radio" id="hand" name="deliveryStatus"
				class="delivery-radio" value="직거래"> <label for="hand"
				class="delivery-label">결제 후 직접거래</label> <input type="radio"
				name="deliveryStatus" class="delivery-radio" id="delvPrice"
				value="택배거래"> <label for="delvPrice" class="delivery-label">택배거래</label>
			<input type="text" class="rent-security" id="deliveryPrice"
				name="deliveryPrice" placeholder="배송비" disabled>
        </div>
        <div class="container-date">
			<h4>대여가능 날짜</h4>
			<label>대여시작일</label> <input type="date" id="startDate"
				class="dateinput" placeholder="대여시작일" name="startDate" min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"> <span>~</span>
			<label>대여반납일</label> <input type="date" id="endDate"
				class="dateinput" placeholder="대여반납일" name="endDate">
		</div>
        <div class="container-prodstate">
            <h4>상품상태</h4>
            <div class="modal-prodState">
                <div class="modal-prodState-body">
                    <h3>상품의 상태를 선택하세요</h3>
                    <hr>
                    <input type="radio" id="state1" name="state" class="state-radio" value="새상품">
                    <label for="state1" class="state-label">새상품(미사용)</label>
                    <input type="radio" id="state2" name="state" class="state-radio" value="사용감적음">
                    <label for="state2" class="state-label">사용감 적음</label>
                    <input type="radio" id="state3" name="state" class="state-radio" value="사용감많음">
                    <label for="state3" class="state-label">사용감 많음</label>
                    <input type="radio" id="state4" name="state" class="state-radio" value="파손">
                    <label for="state4" class="state-label">고장/파손</label>
                    <button type="button" class="cancle-prod">확인</button>
                </div>
            </div>
            <button type="button" class="btn-open-modal-prodState">상품상태선택</button>
        </div>

        <div class="container-addr">
            <div class="modal-addr">
                <div class="modal-addr-body">
                    <h3>거래지역 선택</h3>
                    <hr>
                    <button type="button" class="btn-open-modal-addrPlus">거래지역 추가</button>
                    <div class="addr-list"></div>
                    <button type="button" class="cancle-addr">확인</button>
                </div>
            </div>
            <!-- 
            <div class="modal-addrPlus">
                <div class="modal-addrPlus-body">
                    <h3>거래지역 추가</h3>
                    <hr>
                    <h5>거래지역*</h5>
                    <input class="addrNum" placeholder="우편번호">
                    <button class="searchBtn">검색</button>
                    <input class="loadNum" placeholder="도로명 주소">
                    <h5>입력하신 거래지역의 상세주소는 표시되지 않습니다.</h5>
                    <button type="button" class="cancle-btn">취소</button>
                    <button type="button">확인</button>
                </div>
            </div>
             -->
             <h4>거래지역</h4>
            <button type="button" class="btn-open-modal-addr">거래지역 등록/수정</button>
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
    </form>
</body>

</html>