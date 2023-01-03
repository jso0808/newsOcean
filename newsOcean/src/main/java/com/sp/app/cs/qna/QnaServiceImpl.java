package com.sp.app.cs.qna;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("cs.qna.QnaService")
public class QnaServiceImpl implements QnaService {
	@Autowired
	private CommonDAO dao;

	@Override
	public void insertQna(Qna dto, String pathname) throws Exception {
		try {
			dao.insertData("cs.qna.insertQna", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Qna> listQna(Map<String, Object> map) {
		List<Qna> list = null;

		try {
			list = dao.selectList("cs.qna.listQna", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("cs.qna.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public Qna readQna(long qnaNo) {
		Qna dto = null;
		// 게시물 가져오기
		try {
			dto = dao.selectOne("cs.qna.readQna", qnaNo);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public void updateQnaHit(long qnaNo) throws Exception {
		// 조회수 증가
		try {
			dao.updateData("cs.qna.updateQnaHit", qnaNo);

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Qna preReadQna(Map<String, Object> map) {
		Qna dto = null;

		try {
			dto = dao.selectOne("cs.qna.preReadQna", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public Qna nextReadQna(Map<String, Object> map) {
		Qna dto = null;

		try {
			dto = dao.selectOne("cs.qna.nextReadQna", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public void updateQna(Qna dto, String pathname) throws Exception {
		try {
			dao.updateData("cs.qna.updateQna", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteQna(long qnaNo, String pathname, long memberNo, int memberShip) throws Exception {
		try {
			Qna dto = readQna(qnaNo);
			if (dto == null || (memberShip < 51 &&  dto.getMemberNo()!= memberNo)) {
				return;
			}

			dao.deleteData("cs.qna.deleteQna", qnaNo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertAnswer(QnaReply dto) throws Exception {
		try {
			dao.insertData("cs.qna.insertAnswer", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<QnaReply> listAnswer(Map<String, Object> map) {
		List<QnaReply> list = null;
		
		try {
			list = dao.selectList("cs.qna.listAnswer", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int answerCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("cs.qna.answerCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public void deleteAnswer(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("cs.qna.deleteAnswer", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<QnaReply> listReply(Map<String, Object> map) {
		List<QnaReply> list = null;
		
		try {
			list = dao.selectList("cs.qna.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("cs.qna.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
