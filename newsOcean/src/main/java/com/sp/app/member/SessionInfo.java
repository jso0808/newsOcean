package com.sp.app.member;

// 세션에 저장할 정보 
public class SessionInfo {
	private long memberNo;
	private int memberShip;
	private String email;
	private String name;
	private String nickName;
	
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
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public int getMemberShip() {
		return memberShip;
	}
	public void setMemberShip(int memberShip) {
		this.memberShip = memberShip;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	
}
