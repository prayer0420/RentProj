package dto;

import java.sql.Date;

public class Announce {
    private int no;          // 공지사항 번호
    private String title;    // 공지사항 제목
    private String content;  // 공지사항 내용
    private String imgUrl;   // 이미지 파일 경로
    private Date regDate;    // 등록일
    private int viewCount;   // 조회수

    // 기본 생성자
    public Announce() {}

	public Announce(int no, String title, String content, String imgUrl, Date regDate, int viewCount) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
		this.imgUrl = imgUrl;
		this.regDate = regDate;
		this.viewCount = viewCount;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
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

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	@Override
	public String toString() {
		return "Announce [no=" + no + ", title=" + title + ", content=" + content + ", imgUrl=" + imgUrl + ", regDate="
				+ regDate + ", viewCount=" + viewCount + "]";
	}
    
    
}
