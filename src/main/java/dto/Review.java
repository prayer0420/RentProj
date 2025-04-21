package dto;

import java.util.Date;

public class Review {

	Integer no;
	Integer memberNo;
	String title;
	String contents;
	Integer score;
	Date date;
	Integer productNo;
	
	Review(){}
	Review(Integer memberNo,String title,String contents,Integer score,Integer productNo){
		this.memberNo = memberNo;
		this.title = title;
		this.contents = contents;
		this.score = score;
		this.productNo = productNo;
	}

	public Integer getNo() {
		return no;
	}

	public void setNo(Integer no) {
		this.no = no;
	}

	public Integer getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(Integer memberNo) {
		this.memberNo = memberNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Integer getProductNo() {
		return productNo;
	}

	public void setProductNo(Integer productNo) {
		this.productNo = productNo;
	}
	
	
	
}
