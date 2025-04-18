<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="css/wishList.css" />

<h2>찜한 상품</h2>

<!-- <form id="wishlistForm" method="post" action="deleteWishlist.do"> -->
<form>
  <div class="wishlist-header">
    <input type="checkbox" id="checkAll" />
    <button type="submit" class="delete-btn">선택 삭제</button>
  </div>

  <div class="wishlist-grid">
  
  	<div class="wishlist-item">
        <input type="checkbox" name="wishlistIds" value="" class="check-item" />
        <img src="" alt="상품 이미지" />
        <div class="item-info">
          <strong>아이패드프로6</strong>
          <p><span class="price">60,000원</span></p>
          <p>5시간전</p>
          <p class="location">서울시 동작구</p>
        </div>
     </div>
  
    <%-- <c:forEach var="item" items="${wishlist}">
      <div class="wishlist-item">
        <input type="checkbox" name="wishlistIds" value="${item.id}" class="check-item" />
        <img src="${item.image}" alt="상품 이미지" />
        <div class="item-info">
          <strong>${item.title}</strong>
          <p><span class="price">${item.price}원</span></p>
          <p>${item.uploadDate}</p>
          <p class="location">${item.location}</p>
        </div>
      </div>
    </c:forEach> --%>
    
  </div>
  
  
</form>

<c:if test="${empty wishlist}">
  <p class="empty-text">찜한 상품이 없습니다.</p>
</c:if>

<script>
  // 전체 선택
  document.getElementById("checkAll").addEventListener("change", function () {
    document.querySelectorAll(".check-item").forEach(el => el.checked = this.checked);
  });
</script>
