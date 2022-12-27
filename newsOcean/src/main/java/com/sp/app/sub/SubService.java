package com.sp.app.sub;

public interface SubService {
	public ReadyResponse payReady(int totalAmout);
	public ApproveResponse payApprove(String tid, String pgToken);
	public String kakaoPayReady();
	public ApproveResponse kakaoPayInfo(String pg_token);

}
