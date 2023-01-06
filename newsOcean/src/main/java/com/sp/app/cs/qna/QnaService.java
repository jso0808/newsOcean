package com.sp.app.cs.qna;

import java.util.List;
import java.util.Map;


public interface QnaService {
	public void insertQna(Qna dto, String pathname) throws Exception;
	public List<Qna> listQna(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Qna readQna(long qnaNo);
	public void updateQnaHit(long qnaNo) throws Exception;
	public Qna preReadQna(Map<String, Object> map);
	public Qna nextReadQna(Map<String, Object> map);
	public void updateQna(Qna dto, String pathname) throws Exception;
	public void deleteQna(long qnaNo, String pathname, long memberNo, int memberShip) throws Exception;
	
	public void insertAnswer(QnaReply dto) throws Exception;
	public List<QnaReply> listAnswer(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void deleteAnswer(Map<String, Object> map) throws Exception;
	
	public List<QnaReply> listReply(Map<String, Object> map);
	public int qnaAReplyCount(Map<String, Object> map);
}


