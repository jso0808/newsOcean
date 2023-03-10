package com.sp.app.admin.main;

import java.text.DecimalFormat;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("admin.mainController")
public class MainController {
	
	@Autowired
	private MainService service;
	 
	@RequestMapping(value="/admin", method=RequestMethod.GET)
	public String method(Model model) {
		
		//오늘 가입 회원
		int todayCount = 0;
		int yesterdayCount = 0;
		
		todayCount = service.todayCount();
		yesterdayCount = service.yesterdayCount();
		
		int member_cha = todayCount - yesterdayCount;
		
		model.addAttribute("todayCount", todayCount);
		model.addAttribute("member_cha", member_cha);
		
		//매출내역
		List<Main> listSales = service.listSales();
		
		model.addAttribute("listSales", listSales);
		
		///오늘 날짜 / 연간 날짜 ------------
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		String sysdate = sdf.format(date);
		
		SimpleDateFormat sdf_year = new SimpleDateFormat("yyyy");
		String year = sdf_year.format(date);
		
		SimpleDateFormat sdf_month = new SimpleDateFormat("yyyy.MM");
		String month = sdf_month.format(date);
		
		model.addAttribute("sysdate", sysdate);
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		
		///요약 - 오늘 매출  ------------
		int ts = 0;
		int ys = 0;
		ts = service.toady_sales();
		ys = service.yesterday_sales();
		
		DecimalFormat df = new DecimalFormat("#,###");
		String toady_sales = df.format(ts);
		
		model.addAttribute("toady_sales", toady_sales);

		//요약 - 오늘 매출 - 어제 매출
		int sales_cha = ts - ys;
		model.addAttribute("sales_cha", sales_cha);
		
		
		///요약 - 월 토탈 매출  ------------
		int ms = 0;
		int prems = 0;
		ms = service.month_sales();
		prems = service.premonth_sales();
		
		String month_sales = df.format(ms);
		
		model.addAttribute("month_sales", month_sales);
		
		//요약  - 전월 대비 매출 차이 
		int month_cha = ms - prems;
		model.addAttribute("month_cha", month_cha);
		
		
		//연매출 목표
		int yt = service.year_target();
		String year_target = df.format(yt);
		model.addAttribute("year_target", year_target);
		
		//연매출 퍼센트
		int tot_ys = service.year_sales(); //연 총 매출
		String year_sales = df.format(tot_ys);
		model.addAttribute("year_sales", year_sales);
		
		double yt_d = (double)yt;
		double tot_ys_d = (double)tot_ys;
		
		double y_cha = (double)( 100.0 - ((yt_d - tot_ys_d) / yt_d) * 100.0  ) ;
		double year_cha = Math.round(y_cha);

		model.addAttribute("year_cha", year_cha);
		
		
		//랭킹 1 - 뉴스 조회수
		int rank_num = 1;
		List<Main> ranklist1 = service.rank_newsHit();
		
		model.addAttribute("rank_num", rank_num);
		model.addAttribute("ranklist1", ranklist1);
		
		//랭킹2 - 뉴스 좋아요
		List<Main> ranklist2 = service.rank_newsLike();
		
		model.addAttribute("ranklist2", ranklist2);
		
		//랭킹3 - 몽고디비 실시간 크롤링 (nate)
		List<Realtime> realtime_rank = service.listRealtime();
		
		model.addAttribute("realtime_rank", realtime_rank);
		
		return ".adminLayout";
	}
	
	
	@RequestMapping(value = "/admin/main/update")
	public void update(@RequestParam int new_year_target) throws Exception {
		
		int golamount = new_year_target;
		
		try {
			service.update_sales_goals(golamount);
			
		} catch (Exception e) {
		}
	}
	
	
	//차트 - 1
	@RequestMapping(value="/admin/main/line1")
	@ResponseBody
	public Map<String, Object> line1() throws Exception {
		
		//통계 차트 - 매출 영역 - 7일 전 데이터까지 가져오기
		List<Main> chart_sales = service.chart_sales();
		
		Map<String, Object> model = new HashMap<>();
		
		//7일전 데이터 
		List<String> weekList = new ArrayList<>();
		
		int[] gg = new int[7]; //매출 금액 들어갈 리스트 
				
		for(int i=0; i<7; i++) {
		        Calendar cal = Calendar.getInstance();
		        cal.setTime(new Date()); //현재 일자
		        cal.add(Calendar.DATE, -6+i); //하루씩 빼서 저장
		        gg[i] = 0;	
		        
		        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		 
		        String weekDate = sdf.format(cal.getTime()); //일자 가져와서 weekDate 로 만들기. 
		        weekList.add(weekDate);			//weekList 에 하나씩 저장. 1/2 1/1 ...
		}
		 
		//7일 데이터 가져오기
		for(int j=0; j< chart_sales.size(); j++) {
		        String od = chart_sales.get(j).getSubstart();
		        
		        int idx = weekList.indexOf(od);
		        
		        if(idx == -1) {
		        	idx = j;
		        	gg[idx] = 0;
		        } else {
		        	gg[idx] = chart_sales.get(j).getSum_paid_amount();
		        }
		 
		        
		 
		}
	
		
		//series
		List<Map<String, Object>> list2 = new ArrayList<>();
		Map<String, Object> map2;
		map2 = new HashMap<>();
		
		Map<String, Object> itemStyle;
		itemStyle = new HashMap<>();
		
		itemStyle.put("color", "#EE6666 ");
		itemStyle.put("borderRadius", 6);
		
		map2.put("name", "일 매출 합계");
		map2.put("type", "bar");
		map2.put("barWidth", "40%");
		map2.put("data", gg);
		map2.put("itemStyle", itemStyle);

		
		list2.add(map2);
		
		model.put("series", list2); // 차트를 작성할 연속된 값(시어리즈 값)
		
		
		//xAxis
		List<Map<String, Object>> list3 = new ArrayList<>();
		Map<String, Object> map3;
		map3 = new HashMap<>();
		map3.put("type", "category");
		map3.put("data", weekList);
		
		list3.add(map3);
		
		model.put("xAxis", list3); // 차트를 작성할 연속된 값(시어리즈 값)
		
		return model;
	}
	
	
	//차트 - 2 - 유료 회원 비율
	@RequestMapping(value="/admin/main/line2")
	@ResponseBody
	public Map<String, Object> line2() throws Exception {
		
		//통계 차트 - 매출 영역 - 7일 전 데이터까지 가져오기
		List<Main> chart_member = service.chart_member();
		
		//value 맵 저장할 껍데기
		List<Map<String, Object>> value_list = new ArrayList<>();
		
		//7일 데이터 가져오기
		for(int j=0; j < chart_member.size(); j++) {
	        int subtype = chart_member.get(j).getSubtype();
	        int dataMember = chart_member.get(j).getDataMember();
	        
	        

	        if(subtype== 12) {
	        	//안에 map 형태
	    		Map<String, Object> value1 = new HashMap<>();
	        	value1.put("name", "12개월 구독중");
		        value1.put("value", dataMember);
		        
		        value_list.add(value1);
		        
	        } else if(subtype == 1) {
	        	//안에 map 형태
	    		Map<String, Object> value2 = new HashMap<>();
	    		value2.put("name", "1개월 구독중");
	    		value2.put("value", dataMember);
		        
		        value_list.add(value2);
	        	
	        } else {
	        	//안에 map 형태
	    		Map<String, Object> value3 = new HashMap<>();
	    		value3.put("name", "구독 없음");
	    		value3.put("value", dataMember);
		        
		        value_list.add(value3);
		        
		        
		        Map<String, Object> value4 = new HashMap<>();
	    		value4.put("name", "관리자");
	    		value4.put("value", 1);
		        
		        value_list.add(value4);
	        	
	        }
	               
		}
		
		Map<String, Object> model = new HashMap<>();
		
		//series
		List<Map<String, Object>> list1 = new ArrayList<>(); //큰껍데기
		Map<String, Object> map1;
		map1 = new HashMap<>();

		
		map1.put("name", "구독 타입");
		map1.put("type", "pie");
		
		Map<String, Object> label;
		label = new HashMap<>();
		
		label.put("show", false);
		map1.put("label", label);
		
		
		Map<String, Object> itemStyle;
		itemStyle = new HashMap<>();
		
		itemStyle.put("borderRadius", 6);
		
		map1.put("itemStyle", itemStyle);
		
		String[] rr = new String[2];
		
		rr[0] = "40%";
		rr[1] = "70%";
		
		map1.put("radius", rr);
		map1.put("data", value_list);

		list1.add(map1);  // 큰 껍데기
		
		model.put("series", list1); // 차트를 작성할 연속된 값(시어리즈 값)
		
		
		return model;
	}
	
	
	
}
