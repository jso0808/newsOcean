package com.sp.app.main;

import java.util.ArrayList;
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
	public List<Search> listCategory() {
		List<Search> list = null;

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
			throw e;
		}
	}



	@Override
	public List<MainCategory> sectionlist() {
		List<MainCategory> sectionlist = null;
		try {
			 sectionlist = dao.selectList("search.sectionlist");
		} catch (Exception e) {
		}
		return sectionlist;
	}



	@Override
	public List<MainCategory> subsectionlist() {
		List<MainCategory> sectionlist = null;
		try {
			 sectionlist = dao.selectList("search.subsectionlist");
		} catch (Exception e) {
		}
		return sectionlist;
	}

	
	


}
