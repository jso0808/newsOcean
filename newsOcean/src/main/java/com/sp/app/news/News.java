package com.sp.app.news;

import org.bson.types.ObjectId;

public class News {
	
	private long memberNo;
	
	private long newsNo;
	private String title;
	private String originLink;
	private int hitCount;
	private long categoryNo;
	private int bookMarked;
	private long bookMarkNum;

	
	// 몽고DB
	private ObjectId crawlNo;
	private String crawlUrl;
	private String crawlPress; // 언론사
	private String crawlDate;
	private String crawlTitle;
	private String crawlContent;
	private String crawlSummary;
	private String bCategory; // 대분류
	private String sCategory; // 소분류
	
	public long getNewsNo() {
		return newsNo;
	}
	public void setNewsNo(long newsNo) {
		this.newsNo = newsNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getOriginLink() {
		return originLink;
	}
	public void setOriginLink(String originLink) {
		this.originLink = originLink;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public long getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(long categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getCrawlUrl() {
		return crawlUrl;
	}
	public void setCrawlUrl(String crawlUrl) {
		this.crawlUrl = crawlUrl;
	}
	public String getCrawlPress() {
		return crawlPress;
	}
	public void setCrawlPress(String crawlPress) {
		this.crawlPress = crawlPress;
	}
	public String getCrawlDate() {
		return crawlDate;
	}
	public void setCrawlDate(String crawlDate) {
		this.crawlDate = crawlDate;
	}
	public String getCrawlTitle() {
		return crawlTitle;
	}
	public void setCrawlTitle(String crawlTitle) {
		this.crawlTitle = crawlTitle;
	}
	public String getCrawlContent() {
		return crawlContent;
	}
	public void setCrawlContent(String crawlContent) {
		this.crawlContent = crawlContent;
	}
	public String getbCategory() {
		return bCategory;
	}
	public void setbCategory(String bCategory) {
		this.bCategory = bCategory;
	}
	public String getsCategory() {
		return sCategory;
	}
	public void setsCategory(String sCategory) {
		this.sCategory = sCategory;
	}
	public int getBookMarked() {
		return bookMarked;
	}
	public void setBookMarked(int bookMarked) {
		this.bookMarked = bookMarked;
	}
	public long getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(long memberNo) {
		this.memberNo = memberNo;
	}
	public long getBookMarkNum() {
		return bookMarkNum;
	}
	public void setBookMarkNum(long bookMarkNum) {
		this.bookMarkNum = bookMarkNum;
	}
	public ObjectId getCrawlNo() {
		return crawlNo;
	}
	public void setCrawlNo(ObjectId crawlNo) {
		this.crawlNo = crawlNo;
	}
	public String getCrawlSummary() {
		return crawlSummary;
	}
	public void setCrawlSummary(String crawlSummary) {
		this.crawlSummary = crawlSummary;
	}
	
}
