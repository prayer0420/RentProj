package dto;

public class Announce {
	private Integer no;
	private String title;
	private String content;
	private String regDate;
	private Integer viewCount;
	private String imgUrl;
	
	public Announce() {}
	public Announce(String title,String content,String regDate,String imgUrl) {
		this.title=title;
		this.content=content;
		this.regDate=regDate;
		this.imgUrl=imgUrl;
	}
	
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
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
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public Integer getViewCount() {
		return viewCount;
	}
	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	
	
	
	
}
