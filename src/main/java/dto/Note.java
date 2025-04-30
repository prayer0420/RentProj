package dto;

import java.util.Date;

public class Note {
	private Integer noteNo;
	private Integer productNo;
	private Integer memberNo;       // 보내는 사람 번호
	private Integer receiverNo;     // 받는 사람 번호
	private String senderNickname;  
	private String receiverNickname;
	private String productTitle;    
	private String noteContent;
	private Date curdate;

	public Note() {}

	public Note(Integer productNo, Integer memberNo, Integer receiverNo, String noteContent) {
		this.productNo = productNo;
		this.memberNo = memberNo;
		this.receiverNo = receiverNo;
		this.noteContent = noteContent;
	}

	// Getter/Setter
	public Integer getNoteNo() { return noteNo; }
	public void setNoteNo(Integer noteNo) { this.noteNo = noteNo; }

	public Integer getProductNo() { return productNo; }
	public void setProductNo(Integer productNo) { this.productNo = productNo; }

	public Integer getMemberNo() { return memberNo; }
	public void setMemberNo(Integer memberNo) { this.memberNo = memberNo; }

	public Integer getReceiverNo() { return receiverNo; }
	public void setReceiverNo(Integer receiverNo) { this.receiverNo = receiverNo; }

	public String getSenderNickname() { return senderNickname; }
	public void setSenderNickname(String senderNickname) { this.senderNickname = senderNickname; }

	public String getReceiverNickname() { return receiverNickname; }
	public void setReceiverNickname(String receiverNickname) { this.receiverNickname = receiverNickname; }

	public String getProductTitle() { return productTitle; }
	public void setProductTitle(String productTitle) { this.productTitle = productTitle; }

	public String getNoteContent() { return noteContent; }
	public void setNoteContent(String noteContent) { this.noteContent = noteContent; }

	public Date getCurdate() { return curdate; }
	public void setCurdate(Date curdate) { this.curdate = curdate; }
}
