 package com.sp.app.main;


public class Search {
	private int searchNo;
	private Long memberNo;
	private String searchName;
	//private String tagName;//필요x
	private String categoryNo;//203, 204, 205 형태의 string으로 받음
	private String searchNowdate; //검색하는 현재시간
	private int pcategoryNo;
	private int newsNo;
	//private int tagNo;//필요x
	
	private String authority;

	private String newsName;
	private String title;
	
	private String searchDate;// 검색할 기간 ->staDate, endDate
	private String staDate;
	private String endDate;
	private String keyword;
	
	public final String getKeyword() {
		return keyword;
	}
	public final void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public final String getStaDate() {
		return staDate;
	}
	public final void setStaDate(String staDate) {
		this.staDate = staDate;
	}
	public final String getEndDate() {
		return endDate;
	}
	public final void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public final String getAuthority() {
		return authority;
	}
	public final void setAuthority(String authority) {
		this.authority = authority;
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
	public final String getSearchDate() {
		return searchDate;
	}
	public final void setSearchDate(String searchDate) {
		this.searchDate = searchDate;
	}
	public final int getSearchNo() {
		return searchNo;
	}
	public final void setSearchNo(int searchNo) {
		this.searchNo = searchNo;
	}
	public final Long getMemberNo() {
		return memberNo;
	}
	public final void setMemberNo(Long memberNo) {
		this.memberNo = memberNo;
	}
	public final String getSearchName() {
		return searchName;
	}
	public final void setSearchName(String searchName) {
		this.searchName = searchName;
	}

	public final String getCategoryNo() {
		return categoryNo;
	}
	public final void setCategoryNo(String categoryNo) {
		this.categoryNo = categoryNo;
	}
	public final String getSearchNowdate() {
		return searchNowdate;
	}
	public final void setSearchNowdate(String searchNowdate) {
		this.searchNowdate = searchNowdate;
	}
	public final int getPcategoryNo() {
		return pcategoryNo;
	}
	public final void setPcategoryNo(int pcategoryNo) {
		this.pcategoryNo = pcategoryNo;
	}
	public final int getNewsNo() {
		return newsNo;
	}
	public final void setNewsNo(int newsNo) {
		this.newsNo = newsNo;
	}
	
	
}
