package com.sp.app.member;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private BCryptPasswordEncoder bcrytp;
	
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
	
	// 회원 가입 및 권한 insert 
	@Override
	public void insertMember(Member dto) throws Exception {
		try {
			// 이메일 합치기 
			if (dto.getEmail1().length()!=0 && dto.getEmail2().length()!=0) {
				dto.setUserEmail(dto.getEmail1()+"@"+dto.getEmail2());
			}
			
			// 권한 테이블 저장을 위해 시퀀스 가져오기
			long memberSeq = dao.selectOne("member.memberSeq");
			dto.setMemberNo(memberSeq);
			
			// 패스워드 암호화
			String encPassword = bcrytp.encode(dto.getUserPwd());
			dto.setUserPwd(encPassword);
			
			// 회원 테이블에 정보 저장 (회원 가입)
			dao.insertData("member.insertMember", dto);
			// 권한 테이블에 정보 저장
			dto.setAuthority("ROLE_USER");
			dao.insertData("member.insertAuthority", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
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
		Member dto = null;
		
		try {
			dto = dao.selectOne("member.readMember", email);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
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
		Member dto = readMember(email);
		
		if(dto == null) {
			return false;
		}

		return bcrytp.matches(userPwd, dto.getUserPwd());
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
