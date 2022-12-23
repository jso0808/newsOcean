package com.sp.app.admin.mypage;

public class Mypage {
	
	private long memberNo;
	private String email;
	private String pwd;
	private String name;
	private String nickName;
	private String birth;
	private String joindate;
	private String recentdate;
	private String wrongcnt;
	private String modifydate;
	private int enabled;
	private int membership;
	private String gender;
	
	
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
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
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
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
	public String getWrongcnt() {
		return wrongcnt;
	}
	public void setWrongcnt(String wrongcnt) {
		this.wrongcnt = wrongcnt;
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
	
	
	private String companySubject;
	private long companyNo;
	private String companyDate;
	
	
	public String getCompanySubject() {
		return companySubject;
	}
	public void setCompanySubject(String companySubject) {
		this.companySubject = companySubject;
	}
	public long getCompanyNo() {
		return companyNo;
	}
	public void setCompanyNo(long companyNo) {
		this.companyNo = companyNo;
	}
	public String getCompanyDate() {
		return companyDate;
	}
	public void setCompanyDate(String companyDate) {
		this.companyDate = companyDate;
	}


	private long qnaNo;
	private String qnaacontent;
	private String qnaaregdate;


	public long getQnaNo() {
		return qnaNo;
	}
	public void setQnaNo(long qnaNo) {
		this.qnaNo = qnaNo;
	}
	public String getQnaacontent() {
		return qnaacontent;
	}
	public void setQnaacontent(String qnaacontent) {
		this.qnaacontent = qnaacontent;
	}
	public String getQnaaregdate() {
		return qnaaregdate;
	}
	public void setQnaaregdate(String qnaaregdate) {
		this.qnaaregdate = qnaaregdate;
	}
	
	private long faqNo;
	private String faqsubject;
	private String faqregdate;


	public long getFaqNo() {
		return faqNo;
	}
	public void setFaqNo(long faqNo) {
		this.faqNo = faqNo;
	}
	public String getFaqsubject() {
		return faqsubject;
	}
	public void setFaqsubject(String faqsubject) {
		this.faqsubject = faqsubject;
	}
	public String getFaqregdate() {
		return faqregdate;
	}
	public void setFaqregdate(String faqregdate) {
		this.faqregdate = faqregdate;
	}
	
	

}
