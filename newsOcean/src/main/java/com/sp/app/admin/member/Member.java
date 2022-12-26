package com.sp.app.admin.member;

public class Member {
	private int memberNo;
	private String email;
	private String pwd;
	private String name;
	private String nickname;
	private String birth;
	
	private String gender;
	private String joindate;
	private String recentdate;
	private int wrongcnt;
	private String profile;
	private String modifydate;
	private int enabled;
	private int membership;
	private String authority;
	
	
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
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
	public String getJoindate() {
		return joindate;
	}
	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
	public String getRecentdate() {
		return recentdate;
	}
	public void setRecentdate(String recentdate) {
		this.recentdate = recentdate;
	}
	public int getWrongcnt() {
		return wrongcnt;
	}
	public void setWrongcnt(int wrongcnt) {
		this.wrongcnt = wrongcnt;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getModifydate() {
		return modifydate;
	}
	public void setModifydate(String modifydate) {
		this.modifydate = modifydate;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	public int getMembership() {
		return membership;
	}
	public void setMembership(int membership) {
		this.membership = membership;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	
	
	
	private long subno;
	private String substart;
	private String subend;
	private int subtype;
	private int pay;
	private String memo;


	public long getSubno() {
		return subno;
	}
	public void setSubno(long subno) {
		this.subno = subno;
	}
	public String getSubstart() {
		return substart;
	}
	public void setSubstart(String substart) {
		this.substart = substart;
	}
	public String getSubend() {
		return subend;
	}
	public void setSubend(String subend) {
		this.subend = subend;
	}
	public int getSubtype() {
		return subtype;
	}
	public void setSubtype(int subtype) {
		this.subtype = subtype;
	}
	public int getPay() {
		return pay;
	}
	public void setPay(int pay) {
		this.pay = pay;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	
	
}
