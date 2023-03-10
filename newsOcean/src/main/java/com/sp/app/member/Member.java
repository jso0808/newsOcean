package com.sp.app.member;

public class Member {
	private long memberNo;
	private String email;
	private String email1;
	private String email2;
	private String pwd;
	private String name;
	private String nickName;
	private String birth;
	private String gender;
	private String joinDate;
	private String recentDate; // 최근 방문일
	private int wrongCnt;
	private String profile;
	private String modifyDate; // 비번변경일
	private int memberShip; // 회원 등급
	private int enabled;
	
	private String authority;
	
	public long getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(long memberNo) {
		this.memberNo = memberNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String userEmail) {
		this.email = userEmail;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String userPwd) {
		this.pwd = userPwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String userName) {
		this.name = userName;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String userNickName) {
		this.nickName = userNickName;
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
	public String getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
	public String getRecentDate() {
		return recentDate;
	}
	public void setRecentDate(String recentDate) {
		this.recentDate = recentDate;
	}
	public int getWrongCnt() {
		return wrongCnt;
	}
	public void setWrongCnt(int wrongCnt) {
		this.wrongCnt = wrongCnt;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public int getMemberShip() {
		return memberShip;
	}
	public void setMemberShip(int memberShip) {
		this.memberShip = memberShip;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	
}
