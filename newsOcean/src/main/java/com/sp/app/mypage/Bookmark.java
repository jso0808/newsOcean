package com.sp.app.mypage;

public class Bookmark {
	//북마크 뉴스기사를 분류 보관, 날짜,카테고리별 검색
	private int bookmarkNum;
	private int newsNo;
	private int memberNo;
	private String bookmarkName;
	public int getBookmarkNum() {
		return bookmarkNum;
	}
	public void setBookmarkNum(int bookmarkNum) {
		this.bookmarkNum = bookmarkNum;
	}
	public int getNewsNo() {
		return newsNo;
	}
	public void setNewsNo(int newsNo) {
		this.newsNo = newsNo;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getBookmarkName() {
		return bookmarkName;
	}
	public void setBookmarkName(String bookmarkName) {
		this.bookmarkName = bookmarkName;
	}
	
}
