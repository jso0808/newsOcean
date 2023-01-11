package com.sp.app.news;

import java.util.List;
import java.util.Map;

public interface NewsService {
	
	// 테스트용 뉴스글 리스트
	public List<News> listNews();
	
	// 뉴스글 가져오기
	public News readNews(String originLink); // 몽고DB
	public void updateHitCount(long newsNo);
	public void deleteNews(String originLink); // 몽고DB
	
	// 몽고DB - 오라클DB 데이터 일치 시키기
	public int readNewsNoFromUrl(String originLink);
	
	// 뉴스글 좋아요
	public void insertNewsLike(Map<String, Object> map) throws Exception;
	public void deleteNewsLike(Map<String, Object> map) throws Exception;
	public int newsLikeCount(long newsNo);
	// 해당 뉴스글의 좋아요 여부 확인
	public boolean userNewsLiked(Map<String, Object> map);
	// 뉴스글 북마크
	public void insertBookMark(Map<String, Object> map) throws Exception;
	public void deleteBookMark(Map<String, Object> map) throws Exception;
	
	// 댓글
	public void insertReply(Reply dto) throws Exception;
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map);
	public void insertReplyLike(Map<String, Object> map) throws Exception;
	public void deleteReplyLike(Map<String, Object>map) throws Exception;
	public int replyLikeCount(long replyNo);
	// 댓글 숨기기
	public void updateReplyShowHide(Map<String, Object> map);
	// 댓글 신고
	public void insertReplyComplain(Map<String, Object> map) throws Exception;
	// 댓글의 신고 건 수 확인
	public int complainCount(long replyNo);
	// 해당 댓글의 신고 여부 확인
	public boolean userReplyComplain(Map<String, Object> map);
}
