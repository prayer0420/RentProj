package dto;

import java.util.Date;

public class Note {
	Integer noteNo;
	Integer productNo;
	Integer memberNo;
	String noteContent;
	String receiver;
	Date curdate;
	
	public Note(){}
	
	public Note(Integer productNo,Integer memberNo,String noteContent,String receiver){
		this.productNo = productNo;
		this.memberNo = memberNo;
		this.noteContent = noteContent;
		this.receiver = receiver;
	}

	public Integer getNoteNo() {
		return noteNo;
	}

	public void setNoteNo(Integer noteNo) {
		this.noteNo = noteNo;
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

	public String getNoteContent() {
		return noteContent;
	}

	public void setNoteContent(String noteContent) {
		this.noteContent = noteContent;
	}

	public String getReciver() {
		return receiver;
	}

	public void setReciver(String receiver) {
		this.receiver = receiver;
	}

	public Date getCurdate() {
		return curdate;
	}

	public void setCurdate(Date curdate) {
		this.curdate = curdate;
	}
	
	
	

}
