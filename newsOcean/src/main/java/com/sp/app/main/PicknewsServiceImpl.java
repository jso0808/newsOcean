package com.sp.app.main;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service
public class PicknewsServiceImpl implements PicknewsService {
	@Autowired
	private CommonDAO dao;

	@Override
	public List<Picknews> pick_news(Map<String, Object> map) {
		List<Picknews> list = null;

		try {
			list = dao.selectList("picknews.pick_news", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public int total_dataCount_pick_news(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("picknews.total_dataCount_pick_news", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int each_dataCount_pick_news(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("picknews.each_dataCount_pick_news", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	
	
	
}
