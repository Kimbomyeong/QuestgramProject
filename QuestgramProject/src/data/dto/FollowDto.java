package data.dto;

import java.sql.Timestamp;

public class FollowDto {
	// follow 테이블의 칼럼들과 대응시킬 변수
	private String add_user_id;
	private String target_user_id;
	// follow, user 테이블 둘 다 칼럼명이 created_at으로 같아서
	// follow의 dto 변수명을 followed_at 으로 작성함
	private Timestamp followed_at;
	
	
	// user 테이블의 칼럼들과 대응시킬 변수
	private String password;
	private String birth;
	private String gender;
	private String email;
	private String phone;
	private String zipcode;
	private String address1;
	private String address2;
	private Timestamp created_at;
	private Timestamp updated_at;
	private String id;
	private String nickname;
	private String name;
	private String profile_img;
	
	public Timestamp getFollowed_at() {
		return followed_at;
	}
	public void setFollowed_at(Timestamp followed_at) {
		this.followed_at = followed_at;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	public String getAdd_user_id() {
		return add_user_id;
	}
	public void setAdd_user_id(String add_user_id) {
		this.add_user_id = add_user_id;
	}
	public String getTarget_user_id() {
		return target_user_id;
	}
	public void setTarget_user_id(String target_user_id) {
		this.target_user_id = target_user_id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public Timestamp getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}
	public Timestamp getUpdated_at() {
		return updated_at;
	}
	public void setUpdated_at(Timestamp updated_at) {
		this.updated_at = updated_at;
	}
	
}