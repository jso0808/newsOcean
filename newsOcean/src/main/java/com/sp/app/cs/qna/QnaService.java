package com.sp.app.cs.qna;

import java.util.List;
import java.util.Map;

public interface QnaService {
	public void insertQna(Qna dto, String pathname) throws Exception;
	public List<Qna> listQna(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Qna readQna(long num);
	public void updateHitCount(long num) throws Exception;
	public Qna preReadQna(Map<String, Object> map);
	public Qna nextReadQna(Map<String, Object> map);
	public void updateQna(Qna dto, String pathname) throws Exception;
	public void deleteQna(long num, String pathname, String userId, int membership) throws Exception;

	public void insertAswer(QnaReply dto) throws Exception;
	public List<QnaReply> listAnswer(Map<String, Object> map);
	public int QnaAnswerCount(Map<String, Object> map);
	public void deleteQnaAnswer(Map<String, Object> map) throws Exception;

	public List<QnaReply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
}