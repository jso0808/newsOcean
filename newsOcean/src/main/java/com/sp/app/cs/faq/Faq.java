package com.sp.app.cs.faq;

public class Faq {
	private long faqNo;
	private long memberNo;
	private String faqSubject;
	private String faqContent;
	private String faqRegdate;
	
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
	
}
