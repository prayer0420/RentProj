<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${contextPath}/CSS/mypage/mypageModal.css">



<!-- 모달 추가 -->
<div id="confirmModal" class="modal" >
  <div class="modal-content">
    <p>구매를 확정하시겠습니까?</p>
    <button id="confirmYesBtn">확인</button>
    <button id="confirmNoBtn">취소</button>
  </div>
</div>


<!-- 구매확정 AJAX -->
	<script>
	$(document).ready(function() {
	    let selectedOrderNo = null;  // 주문번호 저장용
	
	    // 구매확정 버튼 클릭 시 (이벤트 위임)
	    $(document).on('click','.confirm-btn',function(){
	    	console.log("버튼 클릭됨!"); // 확인용
	    	
	        selectedOrderNo = $(this).data('orderno'); // 버튼에 심어놓은 상품번호 읽어오기
	        $('#confirmModal').fadeIn(); // 모달 띄우기
	    });
	
	    // 모달에서 '취소' 클릭 시
	    $('#confirmNoBtn').click(function() {
	        $('#confirmModal').fadeOut(); // 모달 닫기
	        selectedOrderNo = null; // 초기화
	    });
	
	    // 모달에서 '확인' 클릭 시 (삭제 실행)
	    $('#confirmYesBtn').click(function() {
	        if (selectedOrderNo) {
	        	const $button = $('.confirm-btn[data-orderno="' + selectedOrderNo + '"]');
	            $button.prop('disabled', true).text('처리중...'); // ✅ 중복 클릭 방지
	            
	            $.ajax({
	                url: '${contextPath}/confirmOrder',
	                method: 'POST',
	                data: { orderNo: selectedOrderNo },
	                dataType: 'json',
	                success: function(response) {
	                    if (response.success) {
	                        alert('상품 구매가 확정되었습니다.');
	                        $button.replaceWith('<span class="confirmed-label">구매확정 완료</span>');
	                    } else {
	                        alert('상품 구매 확정에 실패했습니다.');
	                        $button.prop('disabled', false).text('구매확정');
	                    }
	                    $('#confirmModal').fadeOut();
	                },
	                error: function(xhr, status, error) {
	                    alert('서버 오류로 구매 확정에 실패했습니다.');
	                    console.error(error);
	                    $button.prop('disabled', false).text('구매확정');
	                    $('#confirmModal').fadeOut();
	                }
	            });
	        }
	    });
	});
	</script>

