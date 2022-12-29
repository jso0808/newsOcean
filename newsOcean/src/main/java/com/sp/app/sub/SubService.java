package com.sp.app.sub;

import org.springframework.util.MultiValueMap;

public interface SubService {
	public ReadyResponse payReady(int totalAmout, MultiValueMap<String, String> params);
	public ApproveResponse payApprove(String tid, String pgToken);
	public String kakaoPayReady(MultiValueMap<String, String> multiValueMap);
	public ApproveResponse kakaoPayInfo(String pg_token);
	
	public int ReadMemberShip(String email);

}
