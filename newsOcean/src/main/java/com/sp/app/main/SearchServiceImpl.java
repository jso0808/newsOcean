package com.sp.app.main;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service
public class SearchServiceImpl implements SearchService{
	@Autowired
	private CommonDAO dao;

	@Override
	public List<MainCategory> listCategory() {
		List<MainCategory> list = null;

		try {
			list = dao.selectList("search.categorylist");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	@Override
	public void insertSearchHistory(Search search) throws Exception {
		try {
			dao.insertData("search.insertSearchHistory", search);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<MainCategory> sectionlist() {
		List<MainCategory> sectionlist = null;
		try {
			 sectionlist = dao.selectList("search.sectionlist");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sectionlist;
	}

	@Override
	public List<MainCategory> subsectionlist(String categoryNoStr) {
		List<MainCategory> subsectionlist = null;
		int categoryNo = Integer.parseInt(categoryNoStr);
		
		try {
			subsectionlist = dao.selectList("search.subsectionlist_category", categoryNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return subsectionlist;
	}

	@Override
	public List<MainCategory> subsectionlist() {
		List<MainCategory> subsectionlist = null;
		try {
			subsectionlist = dao.selectList("search.subsectionlist");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return subsectionlist;
	}

	@Override
	public List<String> wordSearchShow(Map<String, Object> map) {
		List<String> wordSearchShow = null;
		try {
			wordSearchShow = dao.selectList("search.wordSearchShow", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return wordSearchShow;
	}


}
