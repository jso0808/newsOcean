package com.sp.app.main;

import java.util.List;
import java.util.Map;

public interface PicknewsService {
	public List<Picknews> pick_news(Map<String, Object> map);
	
	public int total_dataCount_pick_news(Map<String, Object> map);
	public int each_dataCount_pick_news(Map<String, Object> map);
	
	
}
