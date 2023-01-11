package com.sp.app.main;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

//컬렉션(테이블명)
@Document(collection = "newsdata")
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
	@Id
	private ObjectId crawlNo; // id컬럼일지 고민
	private String crawlUrl;
	private String crawlPress; // 언론사
	@DateTimeFormat(iso = ISO.DATE_TIME)
	private String crawlDate;
	private String crawlTitle;
	private String crawlContent;
	private String crawlSummary;
	private String category; // 대분류
	
	public String getCrawlSummary() {
		return crawlSummary;
	}
	public void setCrawlSummary(String crawlSummary) {
		this.crawlSummary = crawlSummary;
	}
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
	
	public ObjectId getCrawlNo() {
		return crawlNo;
	}
	public void setCrawlNo(ObjectId crawlNo) {
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
	
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
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
	
}
