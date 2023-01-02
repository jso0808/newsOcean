package com.sp.app.admin.perform;

import java.util.List;

public interface PerformService {
	
	public List<Perform> listSales();
	public int toady_sales();
	public int yesterday_sales();
	//월 매출
	public int month_sales();
	public int premonth_sales();
	
	//연매출 목표
	public int year_target();
	//연매출 토탈
	public int year_sales();
	
	//연매출 변경
	public void update_sales_goals(int golamount);
	
	
	//랭킹 - 뉴스 
	public List<Perform> rank_newsHit();
	public List<Perform> rank_newsLike();
	
	
	//통계
	public List<Perform> chart_sales();
	public List<Perform> chart_member();
	
	

}
