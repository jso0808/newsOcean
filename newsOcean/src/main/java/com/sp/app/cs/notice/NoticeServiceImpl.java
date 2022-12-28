package com.sp.app.cs.notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("cs.noticeService")
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private CommonDAO dao;

	@Override
	public void insertNotice(Notice dto, String pathname) throws Exception {
		try {
			long seq = dao.selectOne("notice.seq");
			dto.setNoticeNo(seq);

			dao.insertData("cs.notice.insertNotice", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("cs.notice.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public List<Notice> listNotice(Map<String, Object> map) {
		List<Notice> list = null;

		try {
			list = dao.selectList("cs.notice.listNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<Notice> listNoticeTop() {
		List<Notice> list = null;

		try {
			list = dao.selectList("cs.notice.listNoticeTop");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public Notice readNotice(long noticeNo) {
		Notice dto = null;

		try {
			dto = dao.selectOne("cs.notice.readNotice", noticeNo);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public Notice preReadNotice(Map<String, Object> map) {
		Notice dto = null;

		try {
			dto = dao.selectOne("cs.notice.preReadNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public Notice nextReadNotice(Map<String, Object> map) {
		Notice dto = null;

		try {
			dto = dao.selectOne("cs.notice.nextReadNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public void updateNotice(Notice dto, String pathname) throws Exception {
		try {
			dao.updateData("cs.notice.updateNotice", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteNotice(long noticeNo, String pathname) throws Exception {
		try {

			// 파일 테이블 내용 지우기
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "noticeNo");
			map.put("noticeNo", noticeNo);

			dao.deleteData("cs.notice.deleteNotice", noticeNo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
