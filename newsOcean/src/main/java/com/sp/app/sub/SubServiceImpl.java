package com.sp.app.sub;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("sub.subService")
public class SubServiceImpl implements SubService {
	
	@Autowired
	private CommonDAO dao;

	@Override
	public void insertSubPay(Subscript sb) throws Exception {
		try {
			dao.insertData("subscript.insertSubPay", sb);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}  
	
	// 조건 X
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
	
	// 조건: 1개월권 or 12개월권. selectSub
	@Override
	public List<Subscript> listSubPaySelectSub(Map<String, Object> map) {
		List<Subscript> list = null;
		
		try {
			list = dao.selectList("subscript.listSubPaySelectSub", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public Subscript findBysubPayInfo(String imp_uid) {
		Subscript sb = null;
		
		try {
			sb = dao.selectOne("subscript.findBySubPayInfo", imp_uid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return sb;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("subscript.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int dataCountSub(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("subscript.dataCountSub", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int findBySubIng(long memberNo) {
		int ing = 0;
		try {
			ing = dao.selectOne("subscript.findBySubIng", memberNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return ing;
	}

	@Override
	public void insertSubRefund(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("subscript.insertSubRefund", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
