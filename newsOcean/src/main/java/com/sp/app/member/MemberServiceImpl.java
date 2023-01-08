package com.sp.app.member;

import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;
import com.sp.app.sub.mail.Mail;
import com.sp.app.sub.mail.MailSender;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private BCryptPasswordEncoder bcrytp;
	
	@Autowired
	private MailSender mailSender;
	
	
	
	// 로그인
	/*
	@Override
	public Member loginMember(String userEmail) {
		Member dto = null;
		
		try {
			dto = dao.selectOne("member.loginMember", userEmail);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	*/
	
	// 회원 가입 및 권한 insert 
	@Override
	public void insertMember(Member dto) throws Exception {
		try {
			// 이메일 합치기 
			if (dto.getEmail1().length()!=0 && dto.getEmail2().length()!=0) {
				dto.setEmail(dto.getEmail1()+"@"+dto.getEmail2());
			}
			
			// 권한 테이블 저장을 위해 시퀀스 가져오기
			long memberSeq = dao.selectOne("member.memberSeq");
			dto.setMemberNo(memberSeq);
			
			// 패스워드 암호화
			String encPassword = bcrytp.encode(dto.getPwd());
			dto.setPwd(encPassword);
			
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
	public void updateLastLogin(String userEmail) throws Exception {
		try {
			dao.updateData("member.updateLastLogin", userEmail);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
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
	public Member readNickNameMember(String nickName) {
		Member dto = null;
		
		try {
			dto = dao.selectOne("member.readNickNameMember", nickName);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public void deleteMember(Map<String, Object> map) throws Exception {
		
	}

	@Override
	public void generatePwd(Member dto) throws Exception {
		// 10 자리 임시 패스워드 생성
		StringBuilder sb = new StringBuilder();
		Random rd = new Random();
		String s = "!@#$%^&*~-+ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz";
		for (int i = 0; i < 10; i++) {
			int n = rd.nextInt(s.length());
			sb.append(s.substring(n, n + 1));
		}

		String result;
		result = dto.getNickName() + "님의 새로 발급된 임시 패스워드는 <b>" 
				+ sb.toString() + "</b> 입니다.<br>"
				+ "로그인 후 반드시 패스워드를 변경 하시기 바랍니다.";

		Mail mail = new Mail();
		mail.setReceiverEmail(dto.getEmail());

		mail.setSenderEmail("thdus_17@naver.com");
		mail.setSenderName("NewsOcean");
		mail.setSubject("임시 패스워드 발급");
		mail.setContent(result);

		boolean b = mailSender.mailSend(mail);

		if (b) {
			dto.setPwd(sb.toString());
			updatePwd(dto);
		} else {
			throw new Exception("이메일 전송 중 오류가 발생했습니다.");
		}

	}

	@Override
	public boolean isPasswordCheck(String userEmail, String userPwd) {
		Member dto = readMember(userEmail);
		
		if(dto == null) {
			return false;
		}

		return bcrytp.matches(userPwd, dto.getPwd());
	}

	@Override
	public void updatePwd(Member dto) throws Exception {
			try {
			
			if(isPasswordCheck(dto.getEmail(), dto.getPwd())) {
				throw new RuntimeException("패스워드가 기존 패스워드와 일치합니다.");
			}
			
			String encPassword = bcrytp.encode(dto.getPwd());
			dto.setPwd(encPassword);
			
			dao.updateData("member.updateMember", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
		
	}

	@Override
	public int checkFailureCount(String userEmail) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void updateFailureCount(String userEmail) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateFailureCountReset(String userEmail) throws Exception {
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
