package com.sp.app.news;

import org.springframework.data.mongodb.core.mapping.Document;

//컬렉션(테이블명)
@Document(collection = "newsdata")
public class News {
	
	private long memberNo;
	
	private long newsNo;
	private String title;
	private String originLink;
	private int hitCount;
	private long categoryNo;
	private String categoryName;
	private int bookMarked;
	private long bookMarkNum;
	
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

	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
}
