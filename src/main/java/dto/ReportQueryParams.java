package dto;

public class ReportQueryParams {
    private Integer memberNo;
    public Integer getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(Integer memberNo) {
		this.memberNo = memberNo;
	}
	private String type;
    private String start;
    private String end;

    public String getType() {
        return type;
    }
    public ReportQueryParams(String type, String start, String end) {
		super();
		this.type = type;
		this.start = start;
		this.end = end;
	}
	public ReportQueryParams(Integer memberNo, String start, String end) {
		super();
		this.memberNo = memberNo;
		this.start = start;
		this.end = end;
	}
	public ReportQueryParams() {
		super();
		// TODO Auto-generated constructor stub
	}
	public void setType(String type) {
        this.type = type;
    }
    public ReportQueryParams(Integer memberNo, String type, String start, String end) {
		super();
		this.memberNo = memberNo;
		this.type = type;
		this.start = start;
		this.end = end;
	}
	public String getStart() {
        return start;
    }
    public void setStart(String start) {
        this.start = start;
    }
    public String getEnd() {
        return end;
    }
    public void setEnd(String end) {
        this.end = end;
    }
}
