package com.sp.app.news;

public class Reply {

	private long memberNo;
	private String nickName;
	
	private long replyNo;
	private String content;
	private String regDate;
	private long newsNo;
	
	private int likeCount;
	private int userReplyLiked;
	private int complainCount;
	private int bookMarkNum;

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

	public long getReplyNo() {
		return replyNo;
	}

	public void setReplyNo(long replyNo) {
		this.replyNo = replyNo;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public long getNewsNo() {
		return newsNo;
	}

	public void setNewsNo(long newsNo) {
		this.newsNo = newsNo;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public int getComplainCount() {
		return complainCount;
	}

	public void setComplainCount(int complainCount) {
		this.complainCount = complainCount;
	}

	public int getUserReplyLiked() {
		return userReplyLiked;
	}

	public void setUserReplyLiked(int userReplyLiked) {
		this.userReplyLiked = userReplyLiked;
	}

	public int getBookMarkNum() {
		return bookMarkNum;
	}

	public void setBookMarkNum(int bookMarkNum) {
		this.bookMarkNum = bookMarkNum;
	}

}
