package com.sp.app.mypage.main;

public class Bookmark {
	//북마크 뉴스기사를 분류 보관, 날짜,카테고리별 검색
	private int bookmarkNum;
	private int newsNo;
	private int tabNum;//??
	private int memberNo;
	
	public final int getBookmarkNum() {
		return bookmarkNum;
	}
	public final void setBookmarkNum(int bookmarkNum) {
		this.bookmarkNum = bookmarkNum;
	}
	public final int getNewsNo() {
		return newsNo;
	}
	public final void setNewsNo(int newsNo) {
		this.newsNo = newsNo;
	}
	public final int getTabNum() {
		return tabNum;
	}
	public final void setTabNum(int tabNum) {
		this.tabNum = tabNum;
	}
	public final int getMemberNo() {
		return memberNo;
	}
	public final void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	
}
