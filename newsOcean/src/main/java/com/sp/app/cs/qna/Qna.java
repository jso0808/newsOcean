package com.sp.app.cs.qna;

public class Qna {
	private long qnaNo;
	private long memberNo;
	private String qnaSubject;
	private String qnaContent;
	private String qnaRegdate;
	private int qnaHit;
	
	public long getQnaNo() {
		return qnaNo;
	}
	public void setQnaNo(long qnaNo) {
		this.qnaNo = qnaNo;
	}
	public long getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(long memberNo) {
		this.memberNo = memberNo;
	}
	public String getQnaSubject() {
		return qnaSubject;
	}
	public void setQnaSubject(String qnaSubject) {
		this.qnaSubject = qnaSubject;
	}
	public String getQnaContent() {
		return qnaContent;
	}
	public void setQnaContent(String qnaContent) {
		this.qnaContent = qnaContent;
	}
	public String getQnaRegdate() {
		return qnaRegdate;
	}
	public void setQnaRegdate(String qnaRegdate) {
		this.qnaRegdate = qnaRegdate;
	}
	public int getQnaHit() {
		return qnaHit;
	}
	public void setQnaHit(int qnaHit) {
		this.qnaHit = qnaHit;
	}
	
}
