<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${contextPath}/CSS/mypage/mypageModal.css">



<!-- 모달 추가 -->
<div id="confirmModal" class="modal" >
  <div class="modal-content">
    <p>우리... 오늘부터 대여 1일!</p>
    <button id="confirmRent">확인</button>
  </div>
</div>


<!-- 구매확정 AJAX -->
	<script>
	$(document).ready(function() {
	    let selectedOrderNo = null;  // 주문번호 저장용
	
	    // 구매확정 버튼 클릭 시 (이벤트 위임)
	    $(document).on('click','.rent-start-btn',function(){
	    	console.log("버튼 클릭됨!"); // 확인용
	    	
	        selectedOrderNo = $(this).data('orderno'); // 버튼에 심어놓은 상품번호 읽어오기
	        $('#rentStartModal').fadeIn(); // 모달 띄우기
	    });
	
	
	    // 모달에서 '확인' 클릭 시 (삭제 실행)
	    $('#rentStartModal').click(function() {
	        if (selectedOrderNo) {
	        	const $button = $('.rent-start-btn[data-orderno="' + selectedOrderNo + '"]');
	            $button.prop('disabled', true).text('처리중...'); // ✅ 중복 클릭 방지
	            
	            $.ajax({
	                url: '${contextPath}/rentStart',
	                method: 'POST',
	                data: { orderNo: selectedOrderNo },
	                dataType: 'json',
	                success: function(response) {
	                    if (response.success) {
	                        alert('대여가 시작됩니다!');
	                        $button.replaceWith('<span class="confirmed-label">대여 시작!</span>');
	                    } else {
	                        alert('아직 대여를 시작하지 못했어요. 확인해주세요');
	                        $button.prop('disabled', false).text('빌리기시작');
	                    }
	                    $('#rentStartModal').fadeOut();
	                },
	                error: function(xhr, status, error) {
	                    alert('서버 오류예요. 다시 확인해주세요');
	                    console.error(error);
	                    $button.prop('disabled', false).text('빌리기시작');
	                    $('#rentStartModal').fadeOut();
	                }
	            });
	        }
	    });
	});
	</script>