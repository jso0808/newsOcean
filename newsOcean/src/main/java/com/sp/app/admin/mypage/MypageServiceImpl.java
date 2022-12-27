package com.sp.app.admin.mypage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("admin.mypage.mypageService")
public class MypageServiceImpl implements MypageService {
	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("adminMypage.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	

	@Override
	public List<Mypage> listMypage(Map<String, Object> map) {
		List<Mypage> list = null;
		
		try {
			list = dao.selectList("adminMypage.listMypage", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public void updateMypage(Mypage dto) throws Exception {
		try {
			dao.updateData("adminMypage.updateMypage", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public Mypage readMypage(long memberNo) {
		Mypage dto = null;
		
		try {
			
			dto = dao.selectOne("adminMypage.readMypage", memberNo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}


	@Override
	public List<Mypage> listMyqna(Map<String, Object> map) {
		List<Mypage> list = null;
		
		try {
			list = dao.selectList("adminMypage.listMyqna", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
				
		return list;
	}

	@Override
	public List<Mypage> listMyfaq(Map<String, Object> map) {
		List<Mypage> list = null;
		
		try {
			list = dao.selectList("adminMypage.listMyfaq", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
				
		return list;
	}




	@Override
	public List<Mypage> listAdmin(Map<String, Object> map) {
		List<Mypage> list = null;
		
		try {
			list = dao.selectList("adminMypage.listAdmin", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}





}
