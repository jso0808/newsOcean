package com.sp.app.cs.faq;

public class Faq {
	private long faqNo;
	private long memberNo;
	private String nickName;
	private String faqSubject;
	private String faqContent;
	private String faqRegdate;
	
    private long categoryNum;
    private String category;
    private int enabled;
    private int orderNo;
    
	public long getFaqNo() {
		return faqNo;
	}
	public void setFaqNo(long faqNo) {
		this.faqNo = faqNo;
	}
	public long getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(long memberNo) {
		this.memberNo = memberNo;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getFaqSubject() {
		return faqSubject;
	}
	public void setFaqSubject(String faqSubject) {
		this.faqSubject = faqSubject;
	}
	public String getFaqContent() {
		return faqContent;
	}
	public void setFaqContent(String faqContent) {
		this.faqContent = faqContent;
	}
	public String getFaqRegdate() {
		return faqRegdate;
	}
	public void setFaqRegdate(String faqRegdate) {
		this.faqRegdate = faqRegdate;
	}
	public long getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(long categoryNum) {
		this.categoryNum = categoryNum;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	

}
