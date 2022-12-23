package com.sp.app.admin.mypage;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.notice.CompanyNotice;

public interface MypageService {
	
	//관리자 정보 가져오기
	public List<Mypage> listMypage(Map<String, Object> map);
	public void updateMypage(Mypage dto) throws Exception;
	
	public Mypage readMypage(long memberNo);
	public int dataCount(Map<String, Object> map);

	//내가 작성 - qna
	public List<Mypage> listMyqna(Map<String, Object> map);
	
	//내가 작성 - faq
	public List<Mypage> listMyfaq(Map<String, Object> map);
	
	
	
}
