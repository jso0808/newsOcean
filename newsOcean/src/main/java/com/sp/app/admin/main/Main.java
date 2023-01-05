package com.sp.app.admin.main;

public class Main {
	
	private long subNo;
	private String substart;
	private String subend;
	private int subtype;
	private int paid_amount;
	private String paid_at;
	private String firstmail;
	
	private long memberNo;
	private String name;
	private String email;
	
	
	public long getSubNo() {
		return subNo;
	}
	public void setSubNo(long subNo) {
		this.subNo = subNo;
	}
	public String getSubstart() {
		return substart;
	}
	public void setSubstart(String substart) {
		this.substart = substart;
	}
	public String getSubend() {
		return subend;
	}
	public void setSubend(String subend) {
		this.subend = subend;
	}
	public int getSubtype() {
		return subtype;
	}
	public void setSubtype(int subtype) {
		this.subtype = subtype;
	}
	public int getPaid_amount() {
		return paid_amount;
	}
	public void setPaid_amount(int paid_amount) {
		this.paid_amount = paid_amount;
	}
	public String getPaid_at() {
		return paid_at;
	}
	public void setPaid_at(String paid_at) {
		this.paid_at = paid_at;
	}
	public String getFirstmail() {
		return firstmail;
	}
	public void setFirstmail(String firstmail) {
		this.firstmail = firstmail;
	}
	public long getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(long memberNo) {
		this.memberNo = memberNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	//sales_goals
	private long golNo;
	private String goltype;
	private int golamount;
	private String golsdate;
	private String goledate;


	public long getGolNo() {
		return golNo;
	}
	public void setGolNo(long golNo) {
		this.golNo = golNo;
	}
	public String getGoltype() {
		return goltype;
	}
	public void setGoltype(String goltype) {
		this.goltype = goltype;
	}
	public int getGolamount() {
		return golamount;
	}
	public void setGolamount(int golamount) {
		this.golamount = golamount;
	}
	public String getGolsdate() {
		return golsdate;
	}
	public void setGolsdate(String golsdate) {
		this.golsdate = golsdate;
	}
	public String getGoledate() {
		return goledate;
	}
	public void setGoledate(String goledate) {
		this.goledate = goledate;
	}
	
	
	//뉴스
	private long newsNo;
	private String title;
	private int hitCount;
	private int categoryNo;
	private int dataLike;
	private int sum_paid_amount;
	private int dataMember;


	public int getDataMember() {
		return dataMember;
	}
	public void setDataMember(int dataMember) {
		this.dataMember = dataMember;
	}
	public int getSum_paid_amount() {
		return sum_paid_amount;
	}
	public void setSum_paid_amount(int sum_paid_amount) {
		this.sum_paid_amount = sum_paid_amount;
	}
	public int getDataLike() {
		return dataLike;
	}
	public void setDataLike(int dataLike) {
		this.dataLike = dataLike;
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
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	
	
	
}
