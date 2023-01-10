package com.sp.app.admin.mypage;

import java.util.List;
import java.util.Map;

public interface MypageService {
	
	//관리자 정보 가져오기
	public List<Mypage> listMypage(Map<String, Object> map);
	public void updateMypage(Mypage dto) throws Exception;
	//다른 관리자 계정정보
	public List<Mypage> listAdmin(Map<String, Object> map);
	
	//닉네임 유효성 검사
	public int findNickname(Mypage dto);
	
	public Mypage readMypage(long memberNo);
	public int dataCount(Map<String, Object> map);

	//내가 작성 - qna
	public List<Mypage> listMyqna(Map<String, Object> map);
	
	//내가 작성 - faq
	public List<Mypage> listMyfaq(Map<String, Object> map);
	
	
	//관리자 계정 변경
	public int count_Admin(); //관리자 수
	public void updateAdmin(Map<String, Object> map) throws Exception; //권한변경(취소)

	
}
