package dto;

public class ReportQueryParams {

    private String type;
    private String start;
    private String end;

    public ReportQueryParams() {}

    public ReportQueryParams(String type, String start, String end) {
        this.type = type;
        this.start = start;
        this.end = end;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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