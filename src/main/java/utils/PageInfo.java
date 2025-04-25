package utils;

// 페이징 처리를 위한 정보 저장 및 계산 클래스

public class PageInfo {
	private Integer curPage;     // 현재 페이지 번호
	private Integer allPage;     // 전체 페이지 수
	private Integer startPage;   // 시작 페이지 번호 (네비게이션용)
	private Integer endPage;     // 끝 페이지 번호 (네비게이션용)
	private int pageSize = 12;   // 한 페이지당 데이터 수
	private Integer totalCount;  // 전체 데이터 수

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

	public Integer getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}
	
	
}
