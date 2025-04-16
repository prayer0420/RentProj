<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/productRegister/productRegisterFree.css">
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
        }
    </script>
</head>
<body>
<jsp:include page="../Header/header.jsp"></jsp:include>
 <form action="">
        <div class="container">
            <div class="container-header">
                <h2>무료나눔등록</h2>
            </div>
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
        </div>
    </form>
</body>
</html>