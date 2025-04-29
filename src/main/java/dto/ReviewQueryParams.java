package dto;

public class ReviewQueryParams {
    private Integer memberNo;
    private String type; // 'writable', 'written', 'myproduct'
    private Integer page;     // 요청받은 현재 페이지 번호
    private Integer startRow; // DB에서 조회할 시작 인덱스
    private Integer pageSize; // 한 페이지당 데이터 수

    public ReviewQueryParams() {}

    public ReviewQueryParams(Integer memberNo, String type, Integer page) {
        this.memberNo = memberNo;
        this.type = type;
        this.page = page;
        this.pageSize = 6; // 기본 한 페이지당 6개 (필요하면 조절)
        this.startRow = (page - 1) * pageSize;  // 🔥 자동계산
    }

    // getter, setter
    public Integer getMemberNo() { return memberNo; }
    public void setMemberNo(Integer memberNo) { this.memberNo = memberNo; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public Integer getPage() { return page; }
    public void setPage(Integer page) {
        this.page = page;
        this.startRow = (page - 1) * pageSize; // 페이지 변경 시 startRow 재계산
    }

    public Integer getStartRow() { return startRow; }
    public void setStartRow(Integer startRow) { this.startRow = startRow; }

    public Integer getPageSize() { return pageSize; }
    public void setPageSize(Integer pageSize) { 
        this.pageSize = pageSize;
        this.startRow = (page - 1) * pageSize; // pageSize 변경 시 startRow 재계산
    }
}
