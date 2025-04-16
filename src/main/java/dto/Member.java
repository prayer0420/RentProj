package dto;

public class Member {

	//필수 매개변수
	private String id;
	private String password;
	private String nickname;
	private String phone;
	private String address1;
	private String region1;
	
	//선택 매개변수
	private int no;
	private int gradeId;
	private String address2;
	private String address3;
	private String region2;
	private String region3;
	private String profileImage;
	private String location;
	private int orderCount;
	private int adminNo;
	private int regDate;
	private String fcmToken;
	
	// private 생성자
	private Member(Builder builder) {
		this.id = builder.id;
		this.password = builder.password;
		this.nickname = builder.nickname;
		this.phone = builder.phone;
		this.address1 = builder.address1;
		this.region1 = builder.region1;
		this.no = builder.no;
		this.gradeId = builder.gradeId;
		this.address2 = builder.address2;
		this.address3 = builder.address3;
		this.region2 = builder.region2;
		this.region3 = builder.region3;
		this.profileImage = builder.profileImage;
		this.location = builder.location;
		this.orderCount = builder.orderCount;
		this.adminNo = builder.adminNo;
		this.regDate = builder.regDate;
		this.fcmToken = builder.fcmToken;
	}

	// Builder 클래스
	public static class Builder {
		private final String id;
		private final String password;
		private final String nickname;
		private final String phone;
		private final String address1;
		private final String region1;

		private int no;
		private int gradeId;
		private String address2;
		private String address3;
		private String region2;
		private String region3;
		private String profileImage;
		private String location;
		private int orderCount;
		private int adminNo;
		private int regDate;
		private String fcmToken;

		public Builder(String id, String password, String nickname, String phone, String address1, String region1) {
			this.id = id;
			this.password = password;
			this.nickname = nickname;
			this.phone = phone;
			this.address1 = address1;
			this.region1 = region1;
		}

		public Builder no(int no) {
			this.no = no;
			return this;
		}

		public Builder gradeId(int gradeId) {
			this.gradeId = gradeId;
			return this;
		}

		public Builder address2(String address2) {
			this.address2 = address2;
			return this;
		}

		public Builder address3(String address3) {
			this.address3 = address3;
			return this;
		}

		public Builder region2(String region2) {
			this.region2 = region2;
			return this;
		}

		public Builder region3(String region3) {
			this.region3 = region3;
			return this;
		}

		public Builder profileImage(String profileImage) {
			this.profileImage = profileImage;
			return this;
		}

		public Builder location(String location) {
			this.location = location;
			return this;
		}

		public Builder orderCount(int orderCount) {
			this.orderCount = orderCount;
			return this;
		}

		public Builder adminNo(int adminNo) {
			this.adminNo = adminNo;
			return this;
		}

		public Builder regDate(int regDate) {
			this.regDate = regDate;
			return this;
		}

		public Builder fcmToken(String fcmToken) {
			this.fcmToken = fcmToken;
			return this;
		}
		
		public Member build() {
			return new Member(this);
		}
	}
	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getGradeId() {
		return gradeId;
	}

	public void setGradeId(int gradeId) {
		this.gradeId = gradeId;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getAddress3() {
		return address3;
	}

	public void setAddress3(String address3) {
		this.address3 = address3;
	}

	public String getRegion2() {
		return region2;
	}

	public void setRegion2(String region2) {
		this.region2 = region2;
	}

	public String getRegion3() {
		return region3;
	}

	public void setRegion3(String region3) {
		this.region3 = region3;
	}

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public int getOrderCount() {
		return orderCount;
	}

	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}

	public int getAdminNo() {
		return adminNo;
	}

	public void setAdminNo(int adminNo) {
		this.adminNo = adminNo;
	}

	public int getRegDate() {
		return regDate;
	}

	public void setRegDate(int regDate) {
		this.regDate = regDate;
	}

	public String getFcmToken() {
		return fcmToken;
	}

	public void setFcmToken(String fcmToken) {
		this.fcmToken = fcmToken;
	}

	public String getId() {
		return id;
	}

	public String getPassword() {
		return password;
	}

	public String getNickname() {
		return nickname;
	}

	public String getPhone() {
		return phone;
	}

	public String getAddress1() {
		return address1;
	}

	public String getRegion1() {
		return region1;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public void setNickname(String nickname) {
		this.nickname= nickname;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public void setRegion1(String region1) {
		this.region1 = region1;
	}
}