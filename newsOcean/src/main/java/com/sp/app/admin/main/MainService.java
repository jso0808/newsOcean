package com.sp.app.admin.main;

import java.util.List;

public interface MainService {
	
	//몽고디비
	public List<Realtime> listRealtime();

	
	//오늘 가입 회원 수
	public int todayCount();
	//어제 가입자 수
	public int yesterdayCount();
	
	public List<Main> listSales();
	
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
	public List<Main> rank_newsHit();
	public List<Main> rank_newsLike();
	
	
	//통계
	public List<Main> chart_sales();
	public List<Main> chart_member();

}
