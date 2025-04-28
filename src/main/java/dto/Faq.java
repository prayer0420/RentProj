package dto;

import java.sql.Date;

public class Faq {
    private int no;
    private int categoryNo;
    private String title;
    private String content;
    private Date createdAt;
    private Date updatedAt;
    private String imgUrl;
    // 추가: 카테고리 이름 (JOIN 조회용)
    private String categoryName;

    // 기본 생성자
    public Faq() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
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

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	@Override
	public String toString() {
		return "Faq [no=" + no + ", categoryNo=" + categoryNo + ", title=" + title + ", content=" + content
				+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", imgUrl=" + imgUrl + ", categoryName="
				+ categoryName + "]";
	}
    
    
	
}
