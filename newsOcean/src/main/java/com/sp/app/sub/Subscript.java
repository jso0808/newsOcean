package com.sp.app.sub;

public class Subscript {
	
	private long subNo;
	private long memberNo;
	private String subStart;
	private String subEnd;
	private String firstMail;
	private int subType;
	private long paid_amount;
	private String memo;
	private String imp_uid; // 고유 결제 번호. 환불에 사용. 관리자만 보이게!
	private String merchant_uid; // 주문번호(=구독번호). 내역에서 보여도 됨.
	private String paid_at; // 결제승인시각
	private String pg_tid; // PG사 고유 거래번호
	
	private int endOrNot; // 구독 종료 여부
	
	private String email;
	private String nickName;
	
	
	public long getSubNo() {
		return subNo;
	}
	public void setSubNo(long subNo) {
		this.subNo = subNo;
	}
	public long getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(long memberNo) {
		this.memberNo = memberNo;
	}
	public String getSubStart() {
		return subStart;
	}
	public void setSubStart(String subStart) {
		this.subStart = subStart;
	}
	public String getSubEnd() {
		return subEnd;
	}
	public void setSubEnd(String subEnd) {
		this.subEnd = subEnd;
	}
	public String getFirstMail() {
		return firstMail;
	}
	public void setFirstMail(String firstMail) {
		this.firstMail = firstMail;
	}
	public int getSubType() {
		return subType;
	}
	public void setSubType(int subType) {
		this.subType = subType;
	}
	public long getPaid_amount() {
		return paid_amount;
	}
	public void setPaid_amount(long paid_amount) {
		this.paid_amount = paid_amount;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getImp_uid() {
		return imp_uid;
	}
	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}
	public String getMerchant_uid() {
		return merchant_uid;
	}
	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}
	public String getPaid_at() {
		return paid_at;
	}
	public void setPaid_at(String paid_at) {
		this.paid_at = paid_at;
	}
	public String getPg_tid() {
		return pg_tid;
	}
	public void setPg_tid(String pg_tid) {
		this.pg_tid = pg_tid;
	}
	public int getEndOrNot() {
		return endOrNot;
	}
	public void setEndOrNot(int endOrNot) {
		this.endOrNot = endOrNot;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	

}
