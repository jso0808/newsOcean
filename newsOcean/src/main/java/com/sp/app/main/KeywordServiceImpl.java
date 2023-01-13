package com.sp.app.main;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service
public class KeywordServiceImpl implements KeywordService {
	@Autowired
	private CommonDAO dao;

	@Override
	public List<Keyword> keyword_news(Map<String, Object> map) {
		List<Keyword> list = null;

		try {
			list = dao.selectList("keyword.keyword_news", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	
}
