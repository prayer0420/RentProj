package dto;

public class Grade {
    private int gradeNo;
    private String gradeName;
    private double gradeRate;
    private double gradeCount;
    
    public Grade() {}

	public Grade(int gradeNo, String gradeName, double gradeRate, double gradeCount) {
		super();
		this.gradeNo = gradeNo;
		this.gradeName = gradeName;
		this.gradeRate = gradeRate;
		this.gradeCount = gradeCount;
	}

	public int getGradeNo() {
		return gradeNo;
	}

	public void setGradeNo(int gradeNo) {
		this.gradeNo = gradeNo;
	}

	public String getGradeName() {
		return gradeName;
	}

	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}

	public double getGradeRate() {
		return gradeRate;
	}

	public void setGradeRate(double gradeRate) {
		this.gradeRate = gradeRate;
	}

	public double getGradeCount() {
		return gradeCount;
	}

	public void setGradeCount(double gradeCount) {
		this.gradeCount = gradeCount;
	}

	@Override
	public String toString() {
		return "Grade [gradeNo=" + gradeNo + ", gradeName=" + gradeName + ", gradeRate=" + gradeRate + ", gradeCount="
				+ gradeCount + "]";
	}
    
    
    
}
