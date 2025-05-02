<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<link rel="stylesheet" href="${contextPath}/CSS/mypage/mypageModal.css">


<!-- 모달 추가 -->
<div id="confirmReturnModal" class="modal" >
  <div class="modal-content">
    <p>상품을 잘 돌려받으셨나요? <br>'확인' 버튼을 누르시면 대여거래가 완료돼요.</p>
    <button id="confirmReturn">확인</button>
    <button id="cancelReturn">취소</button>
  </div>
</div>


<!-- 대여시 AJAX -->
	<script type="text/javascript">
	$(document).ready(function() {
	    let selectedOrderNo = null;  // 주문번호 저장용
	
	    // 상품반납확인 버튼 클릭 시 (이벤트 위임)
	    $(document).on('click','.confirmReturn-btn',function(){
	    	console.log("버튼 클릭됨!"); // 확인용
	    	
	        selectedOrderNo = $(this).data('orderno'); // 버튼에 심어놓은 주문번호 읽어오기
	        console.log(selectedOrderNo);
	        $('#confirmReturnModal').fadeIn(); // 모달 띄우기
	    });
	    
	 // 모달에서 '취소' 클릭 시
	    $('#cancelReturn').click(function() {
	        $('#confirmReturnModal').fadeOut(); // 모달 닫기
	        selectedOrderNo = null; // 초기화
	    });
	
	    // 모달에서 '확인' 클릭 시 
	    $('#confirmReturn').click(function() {
	        if (selectedOrderNo) {
	        	const $button = $('.confirmReturn-btn[data-orderno="' + selectedOrderNo + '"]');
	            $button.prop('disabled', true).text('처리중...'); // ✅ 중복 클릭 방지
	            
	            $.ajax({
	                url: '${contextPath}/confirmReturn',
	                method: 'POST',
	                data: { orderNo: selectedOrderNo },
	                dataType: 'json',
	                success: function(response) {
	                    if (response.success) {
	                        alert('대여 거래가 완료됐어요!');
	                        $button.replaceWith('<span class="confirmed-label">거래완료</span>');
	                    } else {
	                        alert('예외가 발생했어요. 다시 확인해주세요');
	                        $button.prop('disabled', false).text('대여거래완료');
	                    }
	                    $('#confirmReturnModal').fadeOut();
	                },
	                error: function(xhr, status, error) {
	                    alert('서버 오류예요. 다시 확인해주세요');
	                    console.error(error);
	                    $button.prop('disabled', false).text('대여거래완료');
	                    $('#confirmReturnModal').fadeOut();
	                }
	            });
	        }
	    });
	});
	</script>