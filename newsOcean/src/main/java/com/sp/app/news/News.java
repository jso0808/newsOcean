package com.sp.app.news;

public class News {
	private long newsNo;
	private String title;
	private String originLink;
	private int hitCount;
	private long categoryNo;
	private long tagNo; 
	//newsNo, title, originLink, hitCount, categoryNo, tagNo
	
	// 몽고DB
	// 위 변수에 합칠지 고민
	private long crawlNo; // id컬럼일지 고민
	private String crawlUrl;
	private String crawlPress; // 언론사
	private String crawlDate;
	private String crawlTitle;
	private String crawlContent;
	private String crawlReport; // 기자 연락처
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
	public long getTagNo() {
		return tagNo;
	}
	public void setTagNo(long tagNo) {
		this.tagNo = tagNo;
	}
	public long getCrawlNo() {
		return crawlNo;
	}
	public void setCrawlNo(long crawlNo) {
		this.crawlNo = crawlNo;
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
	public String getCrawlReport() {
		return crawlReport;
	}
	public void setCrawlReport(String crawlReport) {
		this.crawlReport = crawlReport;
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
	
}
