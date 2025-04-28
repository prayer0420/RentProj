package dto;

public class FaqCategory {
    private int no;         // 카테고리 번호 (PK)
    private String name;    // 카테고리 이름

    public FaqCategory() {}

    public FaqCategory(int no, String name) {
        this.no = no;
        this.name = name;
    }

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "FaqCategory [no=" + no + ", name=" + name + "]";
	}
    
    
}
