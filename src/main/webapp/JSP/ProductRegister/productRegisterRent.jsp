<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/productRegister/productRegisterRent.css">
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
            const btnOpenAddrPlus = document.querySelector('.btn-open-modal-addrPlus');
            const cancleBtn = document.querySelector('.cancle-btn');


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
            btnOpenAddrPlus.addEventListener("click", () => {
                addrPlus.style.display = "flex"
            });
            cancleBtn.addEventListener("click", () => {
                addrPlus.style.display = "none";
                addr.style.display = "flex";
            });



            tooltipTrigger.addEventListener("click", () => {
                tooltipBox.style.display = tooltipBox.style.display === "block" ? "none" : "block";
            });
            // 클릭 외부 영역 클릭 시 툴팁 닫기
            document.addEventListener("click", function (event) {
                if (!tooltipTrigger.contains(event.target) && !tooltipBox.contains(event.target)) {
                    tooltipBox.style.display = "none";
                }
            });
        };
    </script>
</head>
<body>
<jsp:include page="../Header/header.jsp"></jsp:include>
<form class="container">
        <div class="container-header">
            <h2>판매등록</h2>
        </div>
        <hr>
        <div class="container-admit">
            <input type="checkbox">
            <h3>상품등록 필수 동의</h3>
            <div class="modal-admit">
                <div class="modal-admit-body">
                    <hr>
                    <h5>Re:NT는 거래시스템을 제공해드리는 중개사업이며 빌리 중고거래 및 렌탈 거래시 발생하는 책임은 각 당사자에게 있음을 알려드립니다.</h5>
                    <h5>특히 렌탈시 발생할 수 있는 문제에 대하여 빌리는 판매자가 정해놓은 보증금으로 처리해드리며 필요한 서류들은 각 당사자들끼리 제공 받으셔야 합니다.</h5>
                    <h5>각 서류에 대해 빌리는 일체 관여하지 않음을 알려드립니다. 확인 부탁드립니다.</h5>
                    <hr>
                    <button class="cancle-admit">확인</button>
                </div>
            </div>
            <button type="button" class="btn-open-modal-admit">자세히 보기
        </div>
        <hr>
        <div class="container-category">
            <select name="" id="" class="category-list">
                <option selected="">카테고리 선택</option>
                <option value="">의류/패션/악세사리</option>
                <option value="">PC용품/디지털</option>
                <option value="">가전제품</option>
                <option value="">뷰티/미용</option>
                <option value="">캠핑/스포츠/레져</option>
                <option value="">생활/주방용품</option>
                <option value="">가구/인테리어</option>
                <option value="">유아동/출산</option>
                <option value="">애완동물용품</option>
                <option value="">기타</option>
            </select>
            <input type="text" placeholder="제목을 입력하세요">
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
        <div class="container-rent">
            <h4>상품금액 유형 및 가격을 지정해주세요</h4>
            <input type="radio" id="day" name="delivery" class="rent-radio">
            <label for="day" class="rent-label">1일 가격</label>
            <input type="radio" id="week" name="delivery" class="rent-radio">
            <label for="week" class="rent-label">1주 가격</label>
            <input type="radio" id="month" name="delivery" class="rent-radio">
            <label for="month" class="rent-label">1달 가격</label>
            <input type="text" class="rent-price" placeholder="빌리기 가격">
        </div>
        <div class="container-security">
            <h4>보증금</h4>
            <input type="text" class="rent-security" placeholder="보증금 가격">
        </div>

        <div class="container-delivery">
            <h4>배송비</h4>
            <input type="radio" id="hand" name="delivery" class="delivery-radio">
            <label for="hand" class="delivery-label">결제 후 직접거래</label>

            <input type="radio" id="deliv" name="delivery" class="delivery-radio">
            <label for="deliv" class="delivery-label">택배거래</label>
        </div>
        <div class="container-prodstate">
            <h4>상품상태</h4>
            <div class="modal-prodState">
                <div class="modal-prodState-body">
                    <h3>상품의 상태를 선택하세요</h3>
                    <hr>
                    <input type="radio" id="state1" name="state" class="state-radio">
                    <label for="state1" class="state-label">새상품(미사용)</label>
                    <input type="radio" id="state2" name="state" class="state-radio">
                    <label for="state2" class="state-label">사용감 적음</label>
                    <input type="radio" id="state3" name="state" class="state-radio">
                    <label for="state3" class="state-label">사용감 많음</label>
                    <input type="radio" id="state4" name="state" class="state-radio">
                    <label for="state4" class="state-label">고장/파손</label>
                    <button type="button" class="cancle-prod">취소</button>
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
                    <button class="cancle-addr">취소</button>
                </div>
            </div>
            <div class="modal-addrPlus">
                <div class="modal-addrPlus-body">
                    <h3>거래지역 추가</h3>
                    <hr>
                    <h5>거래지역*</h5>
                    <input class="addrNum" placeholder="우편번호">
                    <button class="searchBtn">검색</button>
                    <input class="loadNum" placeholder="도로명 주소">
                    <h5>입력하신 거래지역의 상세주소는 표시되지 않습니다.</h5>
                    <button>취소</button>
                    <button>확인</button>
                </div>
            </div>
            <button type="button" class="btn-open-modal-addr">거래지역 등록/수정</button>
        </div>

        <div class="container-image">
            <h4>상품이미지</h4>
            <hr>
            <img src="image/plus.jpg" alt="">
        </div>

        <div class="container-content">
            <textarea name="" id="" placeholder="내용을 입력하세요"></textarea>
        </div>

        <button type="submit">확인</button>
    </form>
</body>
</html>