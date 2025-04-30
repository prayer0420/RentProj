package dto;

import java.sql.Date;

public class Rental {
	private int no;
	private int productNo;
	private int memberNo;
	private Date startDate;
	private Date endDate;
	private String nickName;
	
	public Rental(){}
	public Rental(int productNo,int memberNo, Date startDate,Date endDate) {
		this.productNo=productNo;
		this.memberNo=memberNo;
		this.startDate=startDate;
		this.endDate=endDate;
	}
	
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
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
	
	
	

}
