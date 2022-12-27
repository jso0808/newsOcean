package com.sp.app.sub;

// 결제 요청 VO
public class ReadyResponse {
	/*
	private String cid; // 가맹점 코드
	private String next_redirect_pc_url; // 가맹점 주문번호
	private String partner_order_id; // 가맹점 
	private String partner_user_id; // 가맹점 회원 id
	private String item_name; // 상품명
	private String total_amount; // 상품 총액
	private String tax_free_amount; // 상품 비과세 금액
	private String approval_url; // 결제 성공
	*/
	
	// quantity  approval_url  cancel_url  fail_url
	
	private String tid;
	private String next_redirect_pc_url;
	private String created_at;
	
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getNext_redirect_pc_url() {
		return next_redirect_pc_url;
	}
	public void setNext_redirect_pc_url(String next_redirect_pc_url) {
		this.next_redirect_pc_url = next_redirect_pc_url;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	
	
}
