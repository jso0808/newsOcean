package com.sp.app.sub;

// 결제 요청 VO (payReady)
public class ReadyResponse {
	
	private String cid; // 가맹점 코드
	private String next_redirect_pc_url; // 가맹점 주문번호
	private String partner_order_id; // 가맹점 
	private String partner_user_id; // 가맹점 회원 id
	private String item_name; // 상품명
	private String quantity;
	private String total_amount; // 상품 총액
	private String tax_free_amount; // 상품 비과세 금액
	private String approval_url; // 결제 성공
	private String cancel_url;
	private String fail_url;
	private String tid;
	private String created_at;
	
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getNext_redirect_pc_url() {
		return next_redirect_pc_url;
	}
	public void setNext_redirect_pc_url(String next_redirect_pc_url) {
		this.next_redirect_pc_url = next_redirect_pc_url;
	}
	public String getPartner_order_id() {
		return partner_order_id;
	}
	public void setPartner_order_id(String partner_order_id) {
		this.partner_order_id = partner_order_id;
	}
	public String getPartner_user_id() {
		return partner_user_id;
	}
	public void setPartner_user_id(String partner_user_id) {
		this.partner_user_id = partner_user_id;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public String getTotal_amount() {
		return total_amount;
	}
	public void setTotal_amount(String total_amount) {
		this.total_amount = total_amount;
	}
	public String getTax_free_amount() {
		return tax_free_amount;
	}
	public void setTax_free_amount(String tax_free_amount) {
		this.tax_free_amount = tax_free_amount;
	}
	public String getApproval_url() {
		return approval_url;
	}
	public void setApproval_url(String approval_url) {
		this.approval_url = approval_url;
	}
	public String getCancel_url() {
		return cancel_url;
	}
	public void setCancel_url(String cancel_url) {
		this.cancel_url = cancel_url;
	}
	public String getFail_url() {
		return fail_url;
	}
	public void setFail_url(String fail_url) {
		this.fail_url = fail_url;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	
	
}
