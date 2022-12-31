package com.sp.app.sub;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("sub.subService")
public class SubServiceImpl implements SubService {
	
	@Autowired
	private CommonDAO dao;

	@Override
	public void insertSubPay(Subscript sb) {
		try {
			dao.insertData("subscript.insertSubPay", sb);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}  
	
	@Override
	public List<Subscript> listSubPay(long memberNo) {
		
		List<Subscript> list = null;
		
		try {
			list = dao.selectList("subscript.listSubPay", memberNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	

}
