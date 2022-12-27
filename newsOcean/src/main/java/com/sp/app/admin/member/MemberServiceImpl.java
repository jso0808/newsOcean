package com.sp.app.admin.member;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("admin.member.memberService")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private CommonDAO dao;
		
	@Override
	public List<Member> listMember(Map<String, Object> map) {
		List<Member> list = null;
		
		try {
			list = dao.selectList("adminMember.listMember", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("adminMember.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return result;
	}

	@Override
	public void updateEnabled(Map<String, Object> map) throws Exception {
		
		try {
			dao.updateData("adminMember.updateEnabled", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	

	@Override
	public void updateAuthority(Member dto) throws Exception {
		// TODO Auto-generated method stub
		
	}


	@Override
	public int todayCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("adminMember.todayCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}


	@Override
	public int todaySubCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("adminMember.todaySubCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}


	//유료 회원 리스트 , 카운트 
	@Override
	public List<Member> listSub(Map<String, Object> map) {
		List<Member> list = null;
		
		try {
			list = dao.selectList("adminMember.listSub", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	@Override
	public int dataCount_sub(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("adminMember.dataCount_sub", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return result;
	}


	@Override
	public List<Member> listEn(Map<String, Object> map) {
		List<Member> list = null;
		
		try {
			list = dao.selectList("adminMember.listEn", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}


	@Override
	public int dataCount_en(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("adminMember.dataCount_en", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return result;
	}


	@Override
	public Member readMember(Map<String, Object> map) {
		Member dto = null;
		
		try {
			dto = dao.selectOne("adminMember.readMember", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}


	
}
