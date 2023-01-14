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
		Subscript s = null;
		
		try {
			s = dao.selectOne("subscript.findBySubPayInfo", imp_uid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return s;
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
		int refundOrNot = 0;
		Long subNo = null;
		int ing = 0;
		try {
			subNo = dao.selectOne("subscript.findBySubIng", memberNo);
			if(subNo != null) {
				refundOrNot = dao.selectOne("subscript.findBySubRefund", subNo);
			}
			
			// 구독중X(ing=0): 구독권이 있으나 환불된 경우, 구독권 없는 경우 
			// 구독중O(ing=1): 구독권 있으나 환불데이터 없는 경우, 구독권 있는 경우
			if(subNo == null || (subNo!=null&&refundOrNot==1)) {
				ing = 0;
			} else if(subNo!=null || (subNo!=null&&refundOrNot==0)) {
				ing = 1;
			}
			
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

	@Override
	public int findBySubRefund(long subNo) {
		int result = 0;
		try {
			result = dao.selectOne("subscript.findBySubRefund", subNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
