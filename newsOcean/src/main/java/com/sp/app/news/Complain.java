package com.sp.app.news;

public class Complain {
	private long memberNo;
	
	private long complainyNo;
	private String complain;
	private String complainDate;
	private long replyNo;
	
	private int complainCount;

	public long getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(long memberNo) {
		this.memberNo = memberNo;
	}

	public long getComplainyNo() {
		return complainyNo;
	}

	public void setComplainyNo(long complainyNo) {
		this.complainyNo = complainyNo;
	}

	public String getComplain() {
		return complain;
	}

	public void setComplain(String complain) {
		this.complain = complain;
	}

	public String getComplainDate() {
		return complainDate;
	}

	public void setComplainDate(String complainDate) {
		this.complainDate = complainDate;
	}

	public long getReplyNo() {
		return replyNo;
	}

	public void setReplyNo(long replyNo) {
		this.replyNo = replyNo;
	}

	public int getComplainCount() {
		return complainCount;
	}

	public void setComplainCount(int complainCount) {
		this.complainCount = complainCount;
	}
	
}
