package com.sp.app.mypage;

import java.util.List;

import com.sp.app.admin.member.Member;

public class News {
	private int newsNo;
	private String title;
	private String originalLink;
	private int hitCount;
	private int categoryNo;
	private String categoryName;
	private String content;
	private String regDate;
	private List<Member> memberNo;//뉴스기사별 읽은? member 파트의 member class
	//답글관련
	private int newsLikeNum;//기사별 좋아요 개수 -> newslike에서 newsno별 membertNo개수 count
	private int replyNo;
	private int rereplyNo;
	private String rereplyContent;
	private String rereplyRegDate;
	private String rereplyParent;
	
	public final String getRereplyContent() {
		return rereplyContent;
	}
	public final void setRereplyContent(String rereplyContent) {
		this.rereplyContent = rereplyContent;
	}
	public final String getRereplyRegDate() {
		return rereplyRegDate;
	}
	public final void setRereplyRegDate(String rereplyRegDate) {
		this.rereplyRegDate = rereplyRegDate;
	}
	public final String getRereplyParent() {
		return rereplyParent;
	}
	public final void setRereplyParent(String rereplyParent) {
		this.rereplyParent = rereplyParent;
	}
	public final int getNewsNo() {
		return newsNo;
	}
	public final void setNewsNo(int newsNo) {
		this.newsNo = newsNo;
	}
	public final String getTitle() {
		return title;
	}
	public final void setTitle(String title) {
		this.title = title;
	}
	public final String getOriginalLink() {
		return originalLink;
	}
	public final void setOriginalLink(String originalLink) {
		this.originalLink = originalLink;
	}
	public final int getHitCount() {
		return hitCount;
	}
	public final void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
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
	public final int getNewsLikeNum() {
		return newsLikeNum;
	}
	public final void setNewsLikeNum(int newsLikeNum) {
		this.newsLikeNum = newsLikeNum;
	}
	public final int getReplyNo() {
		return replyNo;
	}
	public final void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	public final String getContent() {
		return content;
	}
	public final void setContent(String content) {
		this.content = content;
	}
	public final String getRegDate() {
		return regDate;
	}
	public final void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public final int getRereplyNo() {
		return rereplyNo;
	}
	public final void setRereplyNo(int rereplyNo) {
		this.rereplyNo = rereplyNo;
	}
	public final List<Member> getMemberNo() {
		return memberNo;
	}
	public final void setMemberNo(List<Member> memberNo) {
		this.memberNo = memberNo;
	}
	
}
