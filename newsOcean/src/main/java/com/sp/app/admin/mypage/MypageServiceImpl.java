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




	@Override
	public int findNickname(Mypage dto) {
		int result = 0;
		
		try {
			result = dao.selectOne("adminMypage.findNickname", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}




	@Override
	public int count_Admin() {
		int result = 0;
		
		try {
			result = dao.selectOne("adminMypage.count_Admin");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}





	@Override
	public void updateAdmin(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("adminMypage.updateAdmin_1", map);
			dao.updateData("adminMypage.updateAdmin_2", map);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	@Override
	public void addAdmin(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("adminMypage.addAdmin_1", map);
			dao.updateData("adminMypage.addAdmin_2", map);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	@Override
	public Mypage findEmail(Map<String, Object> map) {
		Mypage dto = null;
		
		try {
			
			dto = dao.selectOne("adminMypage.findEmail", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}


}
