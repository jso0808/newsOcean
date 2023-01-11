package com.sp.app.news;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

@Document(collection = "newsdata")
public class NewsOriginal {
	@Id
	private ObjectId crawlNo;
	private String crawlUrl;
	private String crawlPress;
	@DateTimeFormat(iso = ISO.DATE_TIME)
	private String crawlDate;
	private String crawlTitle;
	private String crawlContent;
	private String crawlSummary;
	private String category;
	
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
	public String getCrawlSummary() {
		return crawlSummary;
	}
	public void setCrawlSummary(String crawlSummary) {
		this.crawlSummary = crawlSummary;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
	
}
