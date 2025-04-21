package dto;

import java.sql.Date;

// 신고된 상품과 관련된 정보 dto
public class ReportedProduct {
    // 신고 정보
    private int reportNo;
    private String type;
    private String contents;
    private String title;     // 신고 제목
    private Date date;

    // 상품 정보
    private int productNo;
    private String productTitle;
    private String tradeType;
    private String state;
    private int memberNo;
    private boolean hide;
    
	public int getReportNo() {
		return reportNo;
	}
	public void setReportNo(int reportNo) {
		this.reportNo = reportNo;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
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
	public String getTradeType() {
		return tradeType;
	}
	public void setTradeType(String tradeType) {
		this.tradeType = tradeType;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public boolean isHide() {
	    return hide;
	}
	public void setHide(boolean hide) {
	    this.hide = hide;
	}
    
    
    
}
