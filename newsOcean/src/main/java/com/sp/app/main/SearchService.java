package com.sp.app.main;

import java.util.List;
import java.util.Map;

public interface SearchService {
	public List<MainCategory> listCategory();
	public List<MainCategory> sectionlist();
	public List<MainCategory> subsectionlist(int categoryNo);
	public List<MainCategory> subsectionlist();
	public void insertSearchHistory(Search search) throws Exception;
	public List<String> wordSearchShow(Map<String, Object> map);
	public MainCategory categoryName(int categoryNo);
}
