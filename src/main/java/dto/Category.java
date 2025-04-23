package dto;

public class Category {

	Integer no;
	String name;
	Integer sortOrder;
	boolean isActive;
	String imgFilename;
	
	public Category() {}
	public Category(String name, String imgFilename) {
		this.name = name;
	    this.imgFilename = imgFilename;
	}
	public Category(Integer no, String name, Integer sortOrder, boolean isActive) {
		super();
		this.no = no;
		this.name = name;
		this.sortOrder = sortOrder;
		this.isActive = isActive;
	}

	public Integer getNo() {
		return no;
	}

	public void setNo(Integer no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(Integer sortOrder) {
		this.sortOrder = sortOrder;
	}

	public boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(boolean isActive) {
		this.isActive = isActive;
	}
	
	

	public String getImgFilename() {
		return imgFilename;
	}
	public void setImgFilename(String imgFilename) {
		this.imgFilename = imgFilename;
	}
	@Override
	public String toString() {
		return "Category [no=" + no + ", name=" + name + ", sortOrder=" + sortOrder + ", isActive=" + isActive + "]";
	}
	
	
	
}
