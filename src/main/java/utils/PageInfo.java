package utils;

public class PageInfo {
	private Integer curPage;
	private Integer allPage;
	private Integer startPage;
	private Integer endPage;
	private int pageSize = 10; // 한 페이지당 12개 설정

	public PageInfo() {}
	
	public PageInfo(Integer curPage) {
		this.curPage=curPage;
	}
	
	public PageInfo(Integer curPage, Integer allPage, Integer startPage, Integer endPage) {
		super();
		this.curPage = curPage;
		this.allPage = allPage;
		this.startPage = startPage;
		this.endPage = endPage;
	}
	public Integer getCurPage() {
		return curPage;
	}
	public void setCurPage(Integer curPage) {
		this.curPage = curPage;
	}
	public Integer getAllPage() {
		return allPage;
	}
	public void setAllPage(Integer allPage) {
		this.allPage = allPage;
	}
	public Integer getStartPage() {
		return startPage;
	}
	public void setStartPage(Integer startPage) {
		this.startPage = startPage;
	}
	public Integer getEndPage() {
		return endPage;
	}
	public void setEndPage(Integer endPage) {
		this.endPage = endPage;
	} 
	public Integer getPageSize() {
	    return pageSize;
	}
	public void setPageSize(Integer pageSize) {
	    this.pageSize = pageSize;
	}
}
