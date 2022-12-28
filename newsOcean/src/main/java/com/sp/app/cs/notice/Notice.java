package com.sp.app.cs.notice;

public class Notice {
	private long noticeNo;
	private long memberNo;
	private String nickName;
	private String noticeSubject;
	private String noticeContent;
	private String noticeRegdate;
	private int notice;
	
	private long gap;

	public long getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(long noticeNo) {
		this.noticeNo = noticeNo;
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

	public String getNoticeSubject() {
		return noticeSubject;
	}

	public void setNoticeSubject(String noticeSubject) {
		this.noticeSubject = noticeSubject;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public String getNoticeRegdate() {
		return noticeRegdate;
	}

	public void setNoticeRegdate(String noticeRegdate) {
		this.noticeRegdate = noticeRegdate;
	}

	public int getNotice() {
		return notice;
	}

	public void setNotice(int notice) {
		this.notice = notice;
	}

	public long getGap() {
		return gap;
	}

	public void setGap(long gap) {
		this.gap = gap;
	}
	

	
	
}
