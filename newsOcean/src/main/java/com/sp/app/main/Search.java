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
	public int getSearchNo() {
		return searchNo;
	}
	public void setSearchNo(int searchNo) {
		this.searchNo = searchNo;
	}
	public Long getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(Long memberNo) {
		this.memberNo = memberNo;
	}
	public String getSearchName() {
		return searchName;
	}
	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}
	public String getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(String categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getSearchNowdate() {
		return searchNowdate;
	}
	public void setSearchNowdate(String searchNowdate) {
		this.searchNowdate = searchNowdate;
	}
	public int getPcategoryNo() {
		return pcategoryNo;
	}
	public void setPcategoryNo(int pcategoryNo) {
		this.pcategoryNo = pcategoryNo;
	}
	public int getNewsNo() {
		return newsNo;
	}
	public void setNewsNo(int newsNo) {
		this.newsNo = newsNo;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getNewsName() {
		return newsName;
	}
	public void setNewsName(String newsName) {
		this.newsName = newsName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSearchDate() {
		return searchDate;
	}
	public void setSearchDate(String searchDate) {
		this.searchDate = searchDate;
	}
	public String getStaDate() {
		return staDate;
	}
	public void setStaDate(String staDate) {
		this.staDate = staDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	
	
}
