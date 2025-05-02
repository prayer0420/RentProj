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
    private String status;  // 뱃지 표시 위한 상태 추가 (new, hidden, active 등)

    // 상품 정보
    private int productNo;
    private String productTitle;
    private String tradeType;
    private String state;
    private int memberNo;
    
	 // 상품의 노출 여부를 나타내는 필드
	 // boolean 타입의 필드는 필드명을 isXXX로 하면, MyBatis에서 getter를 isIsXXX로 찾는 문제가 발생 가능하므로
	 // 필드명은 'hide'로 하고 getter는 'isHide()'로 작성하는 것이 일반적인 패턴
    private boolean hide;
    
    public ReportedProduct() {}
    
    public ReportedProduct(int memberNo,String contents,String type,String title,int productNo) {
    	this.memberNo=memberNo;
    	this.contents=contents;
    	this.type=type;
    	this.title=title;
    	this.productNo=productNo;
    }
    
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
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public boolean isActuallyHidden() {
        return !this.hide;  // DB 1 → false (노출), DB 0 → true (숨김)
    }
    
}
