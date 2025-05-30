package dto;

import java.sql.Date;

public class Order {
	private Integer orderNo;
	private Integer memberNo;
	private Date orderDate;
	private String orderType;
	private Integer price;
	private Integer secPrice;
	private String deliveryAddr;
	private Integer deliveryPrice;
	private String orderStatus;
	private Date startDate;
	private Date endDate;
	private Integer productNo;
	private String paymentType;
	private String invoiceNo;
	private String deliveryComp;
	private String orderId;
	private String paymentKey;
	
	//reviewList조회용
    private String title;
    private String img1;

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getImg() {
        return img1;
    }
    public void setImg(String img) {
        this.img1 = img;
    }
	
	// admin 주문조회용
    private String productName; // product.title (조인 결과)
    private String buyerId;     // member.id (조인 결과)
    private String sellerId;    // member.id (조인 결과)
    
    private String revenueType; // "판매" / "대여" (정산용)

	// 기본생성자
	public Order() {}
	
	// 매개변수 모두 포함한 생성자 (대여거래 경우)
	public Order(Integer orderNo, Integer memberNo, Date orderDate, String orderType, 
			Integer price, Integer secPrice, String deliveryAddr, Integer deliveryPrice,
			String orderStatus, Date startDate, Date endDate,Integer productNo, 
			String paymentType, String invoiceNo, String deliveryComp) {
		super();
		this.orderNo = orderNo;
		this.memberNo = memberNo;
		this.orderDate = orderDate;
		this.orderType = orderType;
		this.price = price;
		this.secPrice = secPrice;
		this.deliveryAddr = deliveryAddr;
		this.deliveryPrice = deliveryPrice;
		this.orderStatus = orderStatus;
		this.startDate = startDate;
		this.endDate = endDate;
		this.productNo = productNo;
		this.paymentType = paymentType;
		this.invoiceNo = invoiceNo;
		this.deliveryComp = deliveryComp;
	}
	

	// 일반 구매(보증금, 대여기간 없음)
	public Order(Integer memberNo, Integer price, Integer productNo, String deliveryAddr,String orderId,
			String orderType,Date startDate,Date endDate,String paymentKey,Integer deliveryPrice,Integer secPrice ) {
		this.memberNo = memberNo;
		this.price = price;
		this.productNo = productNo;
		this.deliveryAddr = deliveryAddr;
		this.orderId=orderId;
		this.orderType=orderType;
		this.startDate=startDate;
		this.endDate=endDate;
		this.paymentKey=paymentKey;
		this.deliveryPrice = deliveryPrice;
		this.secPrice = secPrice;
	}
	
	// 나눔(택배 경우)
	public Order(Integer orderNo, Integer memberNo, Date orderDate, String orderType, 
			String deliveryAddr, Integer deliveryPrice, 
			Integer productNo, String paymentType, String invoiceNo, 
			String deliveryComp, String orderStatus) {
		this.orderNo = orderNo;
		this.memberNo = memberNo;
		this.orderDate = orderDate;
		this.orderType = orderType;
		this.deliveryAddr = deliveryAddr;
		this.deliveryPrice = deliveryPrice;
		this.orderStatus = orderStatus;
		this.productNo = productNo;
		this.paymentType = paymentType;
		this.invoiceNo = invoiceNo;
		this.deliveryComp = deliveryComp;
	}
	
	
	// 나눔(직접거래 경우)
	public Order(Integer orderNo, Integer memberNo, Date orderDate, String orderType,  
			Integer productNo, String orderStatus) {
		this.orderNo = orderNo;
		this.memberNo = memberNo;
		this.orderDate = orderDate;
		this.orderType = orderType;
		this.orderStatus = orderStatus;
		this.productNo = productNo;
		
	}
	
	
	
	
	public String getPaymentKey() {
		return paymentKey;
	}
	public void setPaymentKey(String paymentKey) {
		this.paymentKey = paymentKey;
	}
	public String getImg1() {
		return img1;
	}
	public void setImg1(String img1) {
		this.img1 = img1;
	}
	public Integer getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}

	public Integer getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(Integer memberNo) {
		this.memberNo = memberNo;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public Integer getSecPrice() {
		return secPrice;
	}

	public void setSecPrice(Integer secPrice) {
		this.secPrice = secPrice;
	}

	public String getDeliveryAddr() {
		return deliveryAddr;
	}

	public void setDeliveryAddr(String deliveryAddr) {
		this.deliveryAddr = deliveryAddr;
	}

	public Integer getDeliveryPrice() {
		return deliveryPrice;
	}

	public void setDeliveryPrice(Integer deliveryPrice) {
		this.deliveryPrice = deliveryPrice;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Integer getProductNo() {
		return productNo;
	}

	public void setProductNo(Integer productNo) {
		this.productNo = productNo;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public String getInvoiceNo() {
		return invoiceNo;
	}

	public void setInvoiceNo(String invoiceNo) {
		this.invoiceNo = invoiceNo;
	}

	public String getDeliveryComp() {
		return deliveryComp;
	}

	public void setDeliveryComp(String deliveryComp) {
		this.deliveryComp = deliveryComp;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}


	// admin 주문조회용 + Getter/Setter
	public String getProductName() {
		return productName;
	}
	
	public void setProductName(String productName) {
		this.productName = productName;
	}
	
	public String getBuyerId() {
		return buyerId;
	}
	
	public void setBuyerId(String buyerId) {
		this.buyerId = buyerId;
	}
	
	public String getSellerId() {
		return sellerId;
	}
	
	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}
	public String getRevenueType() {
		return revenueType;
	}
	public void setRevenueType(String revenueType) {
		this.revenueType = revenueType;
	}
	
	
	
}
