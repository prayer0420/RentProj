package dto;

import java.util.Date;

public class Product {
	private Integer no;
	private Integer categoryNo;
	private Date createDate;
	private String title;
	private String content;
	private String state;
	private String img;
	private String deliveryAddr;
	private Integer deliveryPrice;
	private String tradeType;
	private Integer secPrice;
	private Integer memberNo;
	private String startDate;
	private String endDate;
	private Integer salePrice;
	private Integer rentPrice;
	private Integer isHide;
	private Integer viewCnt;
	private String deliveryStatus;
	
	public Product() {}
	public Product(
			Integer categoryNo,String title,
			String content,String state,String img,String deliveryAddr,
			Integer deliveryPrice,String tradeType,Integer secPrice,Integer memberNo,
			String startDate,String endDate,Integer rentPrice,
			String deliveryStatus) {
		this.categoryNo = categoryNo;
		this.title = title;
		this.content = content;
		this.state = state;
		this.img = img;
		this.deliveryAddr = deliveryAddr;
		this.deliveryPrice = deliveryPrice;
		this.tradeType = tradeType;
		this.secPrice = secPrice;
		this.memberNo = memberNo;
		this.startDate = startDate;
		this.endDate = endDate;
		this.rentPrice = rentPrice;
		this.deliveryStatus = deliveryStatus;
	}
	
	public Product(Integer categoryNo,String title,String content,String state,String img,
			String deliveryAddr,Integer deliveryPrice,String tradeType,Integer memberNo,
			Integer salePrice,String deliveryStatus) {
		this.categoryNo = categoryNo;
		this.title = title;
		this.content = content;
		this.state = state;
		this.img = img;
		this.deliveryAddr = deliveryAddr;
		this.deliveryPrice = deliveryPrice;
		this.tradeType = tradeType;
		this.memberNo = memberNo;
		this.salePrice = salePrice;
		this.deliveryStatus = deliveryStatus;
	}
	
	public Product(Integer categoryNo,String title,
			String content,String state,String img,String deliveryAddr,
			Integer deliveryPrice,String tradeType,Integer secPrice,Integer memberNo,
			String startDate,String endDate,Integer rentPrice,Integer salePrice,
			String deliveryStatus) {
		this.categoryNo = categoryNo;
		this.title = title;
		this.content = content;
		this.state = state;
		this.img = img;
		this.deliveryAddr = deliveryAddr;
		this.deliveryPrice = deliveryPrice;
		this.tradeType = tradeType;
		this.secPrice = secPrice;
		this.memberNo = memberNo;
		this.startDate = startDate;
		this.endDate = endDate;
		this.rentPrice = rentPrice;
		this.salePrice = salePrice;
		this.deliveryStatus = deliveryStatus;
	}
	
	
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public Integer getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(Integer categoryNo) {
		this.categoryNo = categoryNo;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
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
	public String getTradeType() {
		return tradeType;
	}
	public void setTradeType(String tradeType) {
		this.tradeType = tradeType;
	}
	public Integer getSecPrice() {
		return secPrice;
	}
	public void setSecPrice(Integer secPrice) {
		this.secPrice = secPrice;
	}
	public Integer getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(Integer memberNo) {
		this.memberNo = memberNo;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEnd_date() {
		return endDate;
	}
	public void setEnd_date(String endDate) {
		this.endDate = endDate;
	}
	public Integer getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(Integer salePrice) {
		this.salePrice = salePrice;
	}
	public Integer getRentPrice() {
		return rentPrice;
	}
	public void setRentPrice(Integer rentPrice) {
		this.rentPrice = rentPrice;
	}
	public Integer getIsHide() {
		return isHide;
	}
	public void setIsHide(Integer isHide) {
		this.isHide = isHide;
	}
	public Integer getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(Integer viewCnt) {
		this.viewCnt = viewCnt;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getDeliveryStatus() {
		return deliveryStatus;
	}
	public void setDeliveryStatus(String deliveryStatus) {
		this.deliveryStatus = deliveryStatus;
	}
	
	
	
}
