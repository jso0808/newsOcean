package com.sp.app.mypage;

import java.util.List;
import java.util.Map;

public interface MypageService {
	
	//나의정보 가져오기
	public List<Mypage> listMypage(Map<String, Object> map);
	public void updateMypage(Mypage dto) throws Exception;
	
	public Mypage readMypage(long memberNo);
	
	//내가 작성 - qna
	public List<Mypage> listMyqna(Map<String, Object> map);
	
	//내가 작성 - faq
	public List<Mypage> listMyfaq(Map<String, Object> map);
	
}
