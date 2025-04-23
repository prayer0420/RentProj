package dto;

import java.sql.Date;

public class Alarm {
	
	int no;
	String type;
	String recvId;
	String title;
	String content;
	boolean isActive;
	Date sentDate;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getRecvId() {
		return recvId;
	}
	public void setRecvId(String recvId) {
		this.recvId = recvId;
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
	public boolean isActive() {
		return isActive;
	}
	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}
	public Date getSentDate() {
		return sentDate;
	}
	public void setSentDate(Date sentDate) {
		this.sentDate = sentDate;
	}
	public Alarm() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Alarm(int no, String type, String recvId, String title, String content, boolean isActive, Date sentDate) {
		super();
		this.no = no;
		this.type = type;
		this.recvId = recvId;
		this.title = title;
		this.content = content;
		this.isActive = isActive;
		this.sentDate = sentDate;
	}
	public Alarm(String type, String recvId, String title, String content, boolean isActive) {
		super();
		this.type = type;
		this.recvId = recvId;
		this.title = title;
		this.content = content;
		this.isActive = isActive;
	}
}
