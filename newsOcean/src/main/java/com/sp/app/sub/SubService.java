package com.sp.app.sub;

import java.util.List;
import java.util.Map;

public interface SubService {
	
	public void insertSubPay(Subscript sb) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public int dataCountSub(Map<String, Object> map);
	
	public List<Subscript> listSubPay(Map<String, Object> map);
	public List<Subscript> listSubPaySelectSub(Map<String, Object> map);
	
	public Subscript findBysubPayInfo(Map<String, Object> map);
	public int findBySubIng(long memberNo);
	public int findBySubRefund(long subNo);
	
	public void insertSubRefund(Map<String, Object> map) throws Exception;
}
