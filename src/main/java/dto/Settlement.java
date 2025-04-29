package dto;

public class Settlement {

    private int settlementNo;      // 정산 번호 (settlement)
    private int orderNo;           // 주문 번호 (order)
    private int memberNo;          // 회원 번호 (order)
    private int productNo;         // 상품 번호 (order)
    private String productTitle;   // 상품명 (product.title)

    private int price;             // 물품가 (order.price)
    private int deliveryPrice;     // 배송비 (product.deliveryPrice)
    private int secPrice;          // 보증금 (order.secPrice)

    private double gradeRate;      // 수수료율 (grade.gradeRate)
    private int feeAmount;         // 수수료 금액 (price * gradeRate)

    private int finalSettleAmount; // 최종 정산 금액 (물품가 - 수수료 + 배송비 + 보증금)

    private String orderStatus;    // 주문 상태 (order.orderStatus)
    private String feeStatus;      // 정산 상태 (settlement.feeStatus) ex) WAIT, COMPLETE

    private String payTime;        // 결제 일시 (settlement.payTime)
    private String settlementCompletedAt; // 정산 완료 일시 (settlement.settlementCompletedAt)
    
    private String revenueType;

    // 검색 조건용 필드
    private String searchStartDate; // 검색 시작 날짜
    private String searchEndDate;   // 검색 끝 날짜
    private String searchRevenueType; // 판매/대여 타입
    private String searchFeeStatus; // 검색 정산 상태 (COMPLETE 고정해서 쓸 수도 있음)
    
    private String orderType;
	
    public int getSettlementNo() {
		return settlementNo;
	}
	public void setSettlementNo(int settlementNo) {
		this.settlementNo = settlementNo;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public String getProductTitle() {
		return productTitle;
	}
	public void setProductTitle(String productTitle) {
		this.productTitle = productTitle;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getDeliveryPrice() {
		return deliveryPrice;
	}
	public void setDeliveryPrice(int deliveryPrice) {
		this.deliveryPrice = deliveryPrice;
	}
	public int getSecPrice() {
		return secPrice;
	}
	public void setSecPrice(int secPrice) {
		this.secPrice = secPrice;
	}
	public double getGradeRate() {
		return gradeRate;
	}
	public void setGradeRate(double gradeRate) {
		this.gradeRate = gradeRate;
	}
	public int getFeeAmount() {
		return feeAmount;
	}
	public void setFeeAmount(int feeAmount) {
		this.feeAmount = feeAmount;
	}
	public int getFinalSettleAmount() {
		return finalSettleAmount;
	}
	public void setFinalSettleAmount(int finalSettleAmount) {
		this.finalSettleAmount = finalSettleAmount;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	public String getFeeStatus() {
		return feeStatus;
	}
	public void setFeeStatus(String feeStatus) {
		this.feeStatus = feeStatus;
	}
	public String getPayTime() {
		return payTime;
	}
	public void setPayTime(String payTime) {
		this.payTime = payTime;
	}
	public String getSettlementCompletedAt() {
		return settlementCompletedAt;
	}
	public void setSettlementCompletedAt(String settlementCompletedAt) {
		this.settlementCompletedAt = settlementCompletedAt;
	}
	public String getSearchStartDate() {
		return searchStartDate;
	}
	public void setSearchStartDate(String searchStartDate) {
		this.searchStartDate = searchStartDate;
	}
	public String getSearchEndDate() {
		return searchEndDate;
	}
	public void setSearchEndDate(String searchEndDate) {
		this.searchEndDate = searchEndDate;
	}
	public String getSearchFeeStatus() {
		return searchFeeStatus;
	}
	public void setSearchFeeStatus(String searchFeeStatus) {
		this.searchFeeStatus = searchFeeStatus;
	}
	public String getSearchRevenueType() {
		return searchRevenueType;
	}
	public void setSearchRevenueType(String searchRevenueType) {
		this.searchRevenueType = searchRevenueType;
	}
	public String getOrderType() {
		return orderType;
	}
	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
    
	public String getRevenueType() {
	    return revenueType;
	}

	public void setRevenueType(String revenueType) {
	    this.revenueType = revenueType;
	}
    

}
