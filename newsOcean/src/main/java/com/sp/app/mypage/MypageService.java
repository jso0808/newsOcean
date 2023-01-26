package com.sp.app.mypage;

import java.util.List;
import java.util.Map;

import com.sp.app.member.Member;
import com.sp.app.news.News;


public interface MypageService {
	//나의 키워드 구독 리스트, 구독리스트 추가,삭제
	public List<Keyword> readMyKeyword(Map<String, Object> map);
	public void insertMyKeyword(Map<String, Object> map) throws Exception;
	public void updateMyKeyword(Map<String, Object> map) throws Exception;
	public void deleteMyKeyword(Map<String, Object> map) throws Exception;
	
	//나의 회원정보 리스트, 수정
	public Member readMyInfo(String email);
	public void updateMyInfo(Member dto) throws Exception;
	public void updateMyInfoPwd(Member dto) throws Exception;
	public void deleteMyInfo(Member dto) throws Exception;
	/*회원탈퇴->
	 - 정보삭제? 
	 - 아니면 따로저장, 세션삭제, 30일후 삭제
	 */
	
	//나의 댓글 리스트
	public List<Reply> readMyReply(Map<String, Object> 	map);
	public void deleteMyReply(Map<String, Object> map) throws Exception;
	public List<QnaReply> readMyQnaReply(Map<String, Object> map);
	public void deleteMyQnaReply(Map<String, Object> map) throws Exception;
	public boolean checkAuthority(long memberNo) throws Exception;
	//나의 북마크
	public List<Bookmark> readMyBookmark(long memberNo);
	//public void updateMyBookmark(Map<String, Object> map) throws Exception;
	public void deleteMyBookmark(Map<String, Object> map) throws Exception;
	
	public News readNews(News news);
	//광고신청 ? 
	
}
