package dto;

import java.util.Date;

public class Product {
	private Integer no;
	private Integer categoryNo;
	private Date createDate;
	private String title;
	private String content;
	private String state;
	private String img1;
	private String img2;
	private String img3;
	private String img4;
	private String img5;
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
	private String nickname;
	
	public Product() {}
	public Product(
			Integer categoryNo,String title,
			String content,String state,String img1,String img2,String img3,String img4,String img5,
			String deliveryAddr,Integer deliveryPrice,String tradeType,Integer secPrice,Integer memberNo,
			String startDate,String endDate,Integer rentPrice, String deliveryStatus) {
		this.categoryNo = categoryNo;
		this.title = title;
		this.content = content;
		this.state = state;
		this.img1 = img1;
		this.img2 = img2;
		this.img3 = img3;
		this.img4 = img4;
		this.img5 = img5;
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
	
	public Product(Integer categoryNo,String title,String content,String state,String img1,
			String img2,String img3,String img4,String img5, String deliveryAddr,Integer deliveryPrice,
			String tradeType,Integer memberNo, Integer salePrice,String deliveryStatus) {
		this.categoryNo = categoryNo;
		this.title = title;
		this.content = content;
		this.state = state;
		this.img1 = img1;
		this.img2 = img2;
		this.img3 = img3;
		this.img4 = img4;
		this.img5 = img5;
		this.deliveryAddr = deliveryAddr;
		this.deliveryPrice = deliveryPrice;
		this.tradeType = tradeType;
		this.memberNo = memberNo;
		this.salePrice = salePrice;
		this.deliveryStatus = deliveryStatus;
	}
	
	public Product(Integer categoryNo,String title,
			String content,String state,String img1,String img2,String img3,String img4,String img5,
			String deliveryAddr,Integer deliveryPrice,String tradeType,Integer secPrice,Integer memberNo,
			String startDate,String endDate,Integer rentPrice,Integer salePrice,
			String deliveryStatus) {
		this.categoryNo = categoryNo;
		this.title = title;
		this.content = content;
		this.state = state;
		this.img1 = img1;
		this.img2 = img2;
		this.img3 = img3;
		this.img4 = img4;
		this.img5 = img5;
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
	
	public Product(Integer categoryNo,String title,String content, String img1,
			String img2,String img3,String img4,String img5,
			String deliveryAddr, String tradeType,Integer memberNo) {
		this.categoryNo = categoryNo;
		this.title = title;
		this.content = content;
		this.img1 = img1;
		this.img2 = img2;
		this.img3 = img3;
		this.img4 = img4;
		this.img5 = img5;
		this.deliveryAddr = deliveryAddr;
		this.tradeType = tradeType;
		this.memberNo = memberNo;
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
	public String getImg1() {
		return img1;
	}
	public void setImg1(String img1) {
		this.img1 = img1;
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
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	public String getImg2() {
		return img2;
	}
	public void setImg2(String img2) {
		this.img2 = img2;
	}
	public String getImg3() {
		return img3;
	}
	public void setImg3(String img3) {
		this.img3 = img3;
	}
	public String getImg4() {
		return img4;
	}
	public void setImg4(String img4) {
		this.img4 = img4;
	}
	public String getImg5() {
		return img5;
	}
	public void setImg5(String img5) {
		this.img5 = img5;
	}
	public String getTimeAgo() {
        if (createDate == null) return "";
        long diff = System.currentTimeMillis() - createDate.getTime();
        long seconds = diff / 1000;
        if (seconds < 60) {
            return seconds + "초 전";
        }
        long minutes = seconds / 60;
        if (minutes < 60) {
            return minutes + "분 전";
        }
        long hours = minutes / 60;
        if (hours < 24) {
            return hours + "시간 전";
        }
        long days = hours / 24;
        return days + "일 전";
    }
	
}
