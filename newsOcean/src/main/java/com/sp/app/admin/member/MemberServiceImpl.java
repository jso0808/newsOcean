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
	public void updateEnabled(Member dto) throws Exception {
		// TODO Auto-generated method stub
		
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


	
}
