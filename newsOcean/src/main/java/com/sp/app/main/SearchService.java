package com.sp.app.main;

import java.util.List;

public interface SearchService {
	public List<Search> listCategory();
	public List<MainCategory> sectionlist();
	public List<MainCategory> subsectionlist();
	public void insertSearchHistory(Search search) throws Exception;
	
}
