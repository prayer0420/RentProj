package dto;

import java.sql.Date;

public class Alarm {
	
	int num;
	String sendId;
	String sendName;
	String recvId;
	String title;
	String body;
	boolean confirm;
	Date createDate;
	
	public boolean isConfirm() {
		return confirm;
	}
	public void setConfirm(boolean confirm) {
		this.confirm = confirm;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Alarm(String sendId, String sendName, String recvId, String title, String body) {
		super();
		this.sendId = sendId;
		this.sendName = sendName;
		this.recvId = recvId;
		this.title = title;
		this.body = body;
	}
	public String getRecvId() {
		return recvId;
	}
	public void setRecvId(String recvId) {
		this.recvId = recvId;
	}

	public Alarm(int num, String sendId, String sendName, String recvId, String title, String body) {
		super();
		this.num = num;
		this.sendId = sendId;
		this.sendName = sendName;
		this.recvId = recvId;
		this.title = title;
		this.body = body;
	}
	public Alarm() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getSendId() {
		return sendId;
	}
	public void setSendId(String sendId) {
		this.sendId = sendId;
	}
	public String getSendName() {
		return sendName;
	}
	public void setSendName(String sendName) {
		this.sendName = sendName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	
}
