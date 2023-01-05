package com.sp.app.admin.perform;

import java.util.List;

public interface PerformService {
	
	//통계
	public List<Perform> chart_sales();
	public List<Perform> chart_member();
	
	//올해 목표
	public Perform year_target();
	
	
}
