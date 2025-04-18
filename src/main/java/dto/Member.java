package dto;

import java.sql.Date;

public class Member {

	Integer no;
	Integer gradeId;
	String id;
	String password;
	String name;
	String nickname;
	String phone;
	String address1;
	String region1;
	String address2;
	String address3;
	String region2;
	String region3;
	String profileImage;
	String location;
	Integer orderCount;
	Integer adminNo;
	Date regDate;
	String fcmToken;
	
	//기본생성자(myBatis용)
	public Member() {}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getNo() {
		return no;
	}

	public void setNo(Integer no) {
		this.no = no;
	}

	public Integer getGradeId() {
		return gradeId;
	}

	public void setGradeId(Integer gradeId) {
		this.gradeId = gradeId;
	}

	public String getAddress2() {
		return address2;
	}

	public Member(Integer no, Integer gradeId, String id, String password, String name, String nickname, String phone,
			String address1, String region1, String address2, String address3, String region2, String region3,
			String profileImage, String location, Integer orderCount, Integer adminNo, Date regDate, String fcmToken) {
		super();
		this.no = no;
		this.gradeId = gradeId;
		this.id = id;
		this.password = password;
		this.name = name;
		this.nickname = nickname;
		this.phone = phone;
		this.address1 = address1;
		this.region1 = region1;
		this.address2 = address2;
		this.address3 = address3;
		this.region2 = region2;
		this.region3 = region3;
		this.profileImage = profileImage;
		this.location = location;
		this.orderCount = orderCount;
		this.adminNo = adminNo;
		this.regDate = regDate;
		this.fcmToken = fcmToken;
	}

	public Member(String id, String name, String nickname, String profileImage) {
		super();
		this.id = id;
		this.name = name;
		this.nickname = nickname;
		this.profileImage = profileImage;
	}

	public Member(String id, String nickname, String profileImage) {
		super();
		this.id = id;
		this.nickname = nickname;
		this.profileImage = profileImage;
	}

	public Member(String id, String password, String name, String nickname, String phone, String address1,
			String region1) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
		this.nickname = nickname;
		this.phone = phone;
		this.address1 = address1;
		this.region1 = region1;
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

	public Integer getOrderCount() {
		return orderCount;
	}

	public void setOrderCount(Integer orderCount) {
		this.orderCount = orderCount;
	}

	public Integer getAdminNo() {
		return adminNo;
	}

	public void setAdminNo(Integer adminNo) {
		this.adminNo = adminNo;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
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

	public String getName(String name) {
		return name;
	}


}