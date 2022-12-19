package com.sp.app.member;

public class Member {
	private int memberNo;
	private String userEmail;
	private String userPwd;
	private String userName;
	private String ninkName;
	private String birth;
	private String gender;
	private String joinDate;
	private String recentDate; // 최근 방문일
	private int wrongCnt;
	private String profile;
	private String modifyDate; // 비번변경일
	private int enabled;
	
	private String authority;
	private long num;
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getNinkName() {
		return ninkName;
	}
	public void setNinkName(String ninkName) {
		this.ninkName = ninkName;
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
	public long getNum() {
		return num;
	}
	public void setNum(long num) {
		this.num = num;
	}
	
}
