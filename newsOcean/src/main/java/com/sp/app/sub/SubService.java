package com.sp.app.sub;

import java.util.List;
import java.util.Map;

public interface SubService {
	
	public void insertSubPay(Subscript sb);
	
	public int dataCount(Map<String, Object> map);
	public int dataCountSub(Map<String, Object> map);
	
	public List<Subscript> listSubPay(long memberNo);
	public List<Subscript> listSubPaySelectSub(Map<String, Object> map);
	
	public Subscript findBysubPayInfo(String imp_uid);
}
