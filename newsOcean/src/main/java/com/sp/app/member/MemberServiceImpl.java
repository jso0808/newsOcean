package com.sp.app.member;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private CommonDAO dao;
	
	//@Autowired
	//private BCryptPasswordEncoder bcrytp;
	
	// 로그인
	@Override
	public Member loginMember(String email) {
		Member dto = null;
		
		try {
			dto = dao.selectOne("member.loginMember", email);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	// 회원가입
	@Override
	public void insertMember(Member dto) throws Exception {
		try {
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}

	@Override
	public void updateLastLogin(String email) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateMember(Member dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Member readMember(String email) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteMember(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void generatePwd(Member dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean isPasswordCheck(String email, String userPwd) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void updatePwd(Member dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int checkFailureCount(String email) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void updateFailureCount(String email) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateFailureCountReset(String email) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateMemberEnabled(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertMemberState(Member dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
