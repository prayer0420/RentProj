package dto;

public class Mark {
	private Integer no;
	private Integer productNo;
	private Integer memberNo;
	
	public Mark(){}
	public Mark(Integer productNo,Integer memberNo){
		this.productNo = productNo;
		this.memberNo = memberNo;
	}
	
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public Integer getProductNo() {
		return productNo;
	}
	public void setProductNo(Integer productNo) {
		this.productNo = productNo;
	}
	public Integer getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(Integer memberNo) {
		this.memberNo = memberNo;
	}
	
	

}
