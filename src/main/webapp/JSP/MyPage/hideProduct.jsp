<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${contextPath}/CSS/mypage/mypageModal.css">

	<!-- 숨기기 확인 모달 -->
	<div id="hideModal" class="modal">
	  <div class="modal-content">
	    <p>상품을 숨기기 하시겠습니까?</p>
	    <button id="confirmHide">확인</button>
	    <button id="cancelHide">취소</button>
	  </div>
	</div>


        
   <script>       
        $(document).ready(function() {
	    let selectedProductNo = null;  // 선택한 상품번호 저장용
	
	    // 숨기기 버튼 클릭 시 (이벤트 위임)
	    $(document).on('click','.hide-btn',function(){
	    	console.log("버튼 클릭됨!"); // 확인용
	    	
	        selectedProductNo = $(this).data('product-no'); // 버튼에 심어놓은 상품번호 읽어오기
	        $('#hideModal').fadeIn(); // 모달 띄우기
	        console.log("전송 중인 productNo:", selectedProductNo);
	    });
	
	    // 모달에서 '취소' 클릭 시
	    $('#cancelHide').click(function() {
	        $('#hideModal').fadeOut(); // 모달 닫기
	        selectedProductNo = null; // 초기화
	    });
	
	    // 모달에서 '확인' 클릭 시 (삭제 실행)
	    $('#confirmHide').click(function() {
	        if (selectedProductNo) {
	            $.ajax({
	                url: '${contextPath}/hideProduct',
	                method: 'POST',
	                data: { productNo: selectedProductNo },
	                dataType: 'json',
	                success: function(response) {
	                    if (response.success) {
	                        alert('상품이 숨기기 처리되었습니다.');
	                        $('#product-' + selectedProductNo).fadeOut(500, function() {
	                            $(this).remove();
	                        });
	                    } else {
	                        alert('상품 숨기기에 실패했습니다.');
	                    }
	                    $('#hideModal').fadeOut();
	                },
	                error: function(xhr, status, error) {
	                    alert('서버 오류로 숨기기에 실패했습니다.');
	                    console.error(error);
	                    $('#hideModal').fadeOut();
	                }
	            });
	        }
	    });
	});
</script>