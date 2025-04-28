/**
 * 
 */
$(document).ready(function() {
    let selectedProductNo = null;  // 선택한 상품번호 저장용

    // 삭제 버튼 클릭 시 (이벤트 위임)
    $(document).on('click', '.delete-btn',function() {
    	console.log("버튼 클릭됨!"); // 확인용
        selectedProductNo = $(this).data('product-no'); // 버튼에 심어놓은 상품번호 읽어오기
        $('#deleteModal').fadeIn(); // 모달 띄우기
    });

    // 모달에서 '취소' 클릭 시
    $('#cancelDelete').click(function() {
        $('#deleteModal').fadeOut(); // 모달 닫기
        selectedProductNo = null; // 초기화
    });

    // 모달에서 '확인' 클릭 시 (삭제 실행)
    $('#confirmDelete').click(function() {
        if (selectedProductNo) {
            $.ajax({
                url: '${contextPath}/deleteProduct',
                method: 'POST',
                data: { productNo: selectedProductNo },
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        alert('상품이 삭제되었습니다.');
                        $('#product-' + selectedProductNo).fadeOut(500, function() {
                            $(this).remove();
                        });
                    } else {
                        alert('상품 삭제에 실패했습니다.');
                    }
                    $('#deleteModal').fadeOut();
                },
                error: function(xhr, status, error) {
                    alert('서버 오류로 삭제에 실패했습니다.');
                    console.error(error);
                    $('#deleteModal').fadeOut();
                }
            });
        }
    });
});