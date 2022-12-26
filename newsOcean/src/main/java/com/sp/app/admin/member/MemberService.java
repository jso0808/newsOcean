package com.sp.app.admin.member;

import java.util.List;
import java.util.Map;

public interface MemberService {
	
	//회원 정보 가져오기
	public List<Member> listMember(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	
	//회원 enabled 변경 (풀어주기)
	public void updateEnabled(Member dto) throws Exception;
	
	//회원 권한 변경하기
	public void updateAuthority(Member dto) throws Exception;
	
	//회원 구독 정보/ 가져오기
	//회원 활동 리스트 읽어오기 (qna, 뉴스댓글, 등)
	
	
	//오늘 가입한 회원수 
	public int todayCount(Map<String, Object> map);
	
	
	
	
}
