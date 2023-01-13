package com.sp.app.main;

public class MainCategory {
	private int categoryNo;
	private String categoryName;
	private int pcategoryNo;
	
	private int memberNo;
	//뉴스글 관련? 추가할수도
	private int newsNo;
	private String newsName;
	private String title;
	
	public final int getCategoryNo() {
		return categoryNo;
	}
	public final void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public final String getCategoryName() {
		return categoryName;
	}
	public final void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public final int getPcategoryNo() {
		return pcategoryNo;
	}
	public final void setPcategoryNo(int pcategoryNo) {
		this.pcategoryNo = pcategoryNo;
	}
	public final int getMemberNo() {
		return memberNo;
	}
	public final void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public final int getNewsNo() {
		return newsNo;
	}
	public final void setNewsNo(int newsNo) {
		this.newsNo = newsNo;
	}
	public final String getNewsName() {
		return newsName;
	}
	public final void setNewsName(String newsName) {
		this.newsName = newsName;
	}
	public final String getTitle() {
		return title;
	}
	public final void setTitle(String title) {
		this.title = title;
	}
	
}

