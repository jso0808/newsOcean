package com.sp.app.sub;

import java.util.List;

public interface SubService {
	
	public void insertSubPay(Subscript sb);
	public List<Subscript> listSubPay(long memberNo);
}
