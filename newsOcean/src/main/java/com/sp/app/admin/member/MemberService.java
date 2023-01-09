package com.sp.app.admin.member;

import java.util.List;
import java.util.Map;

public interface MemberService {
	
	//1. 전체 회원 정보 가져오기
	public List<Member> listMember(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	
	//2. 유료 회원 정보 가져오기
	public List<Member> listSub(Map<String, Object> map);
	public int dataCount_sub(Map<String, Object> map);
	
	//3. 계정 비활성화 회원
	public List<Member> listEn(Map<String, Object> map);
	public int dataCount_en(Map<String, Object> map);
	
	
	//하나의 회원정보 읽기 (기본정보, 구독 결제 정보)
	public Member readMember(Map<String, Object> map);
	//회원 enabled 변경 (풀어주기)
	public void updateEnabled(Map<String, Object> map) throws Exception;
	//회원 권한 변경하기
	public void updateAuthority(Member dto) throws Exception;
	
	//구독 내역 list
	public List<Member> mysublist(Map<String, Object> map);
	public int dataCount_mysub(Map<String, Object> map);
	
	//신고 내역 list
	public List<Member> complainlist(Map<String, Object> map);
	
	
	//게시글 수
	public int dataCount_qna(Map<String, Object> map);
	public List<Member> myqnalist(Map<String, Object> map);
	//댓글 수
	public int dataCount_reply(Map<String, Object> map);
	public List<Member> myreplylist(Map<String, Object> map);
	
	
	//pdf
	public List<Member> pdflist();
	
	
	//통계
	//오늘 가입한 회원수 , 오늘 유료 회원수 
	public int todayCount(Map<String, Object> map);
	public int todaySubCount(Map<String, Object> map);
	
	
	
	
}
