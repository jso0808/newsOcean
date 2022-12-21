package com.sp.app.cs.qna;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("cs.qnaService")
public class QnaServiceImpl implements QnaService {
	@Autowired
	private CommonDAO dao;
	

	@Override
	public void insertQna(Qna dto, String pathname) throws Exception {
		try {
			dao.insertData("cs.insertQna", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Qna> listQna(Map<String, Object> map) {
		List<Qna> list = null;
		
		try {
			list = dao.selectList("cs.listQna", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Qna readQna(long num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateHitCount(long num) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Qna preReadQna(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Qna nextReadQna(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateQna(Qna dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteQna(long num, String pathname, String userId, int membership) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertAswer(QnaReply dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<QnaReply> listAnswer(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int QnaAnswerCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void deleteQnaAnswer(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<QnaReply> listReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

}
