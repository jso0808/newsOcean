package com.sp.app.admin.perform;

import java.text.SimpleDateFormat;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.MyUtil;

@Controller("admin.perform.performController")
@RequestMapping("/admin/perform/*")
public class PerformController {
	@Autowired
	private PerformService service;
	@Autowired
	private MyUtil myUtil;
	
	
	@RequestMapping(value = "main_content")
	public String main_content(Model model) throws Exception {
		
		
		
		return ".admin.perform.main_content";
	}
	
	
	//매출
	@RequestMapping(value = "main_sales")
	public String main_sales(Model model) throws Exception {
	
		Perform dto = null;
		dto = service.year_target();
		
		model.addAttribute("dto", dto);
		
		//올해 날짜
		Date date = new Date();
		SimpleDateFormat sdf_year = new SimpleDateFormat("yyyy");
		String year = sdf_year.format(date);
		
		model.addAttribute("year", year);
		
		return ".admin.perform.main_sales";
	}
	
	
	
	//차트 - 1
	@RequestMapping(value="line1")
	@ResponseBody
	public Map<String, Object> line1() throws Exception {
		
		//통계 차트 - 매출 영역 - 전체 가져오기
		List<Perform> chart_sales = service.chart_sales();
		
		Map<String, Object> model = new HashMap<>();
		
		//7일전 데이터 
		List<String> weekList = new ArrayList<>();
		
		int[] gg = new int[31]; //매출 금액 들어갈 리스트 
				
		for(int i=0; i<31; i++) {
		        Calendar cal = Calendar.getInstance();
		        cal.setTime(new Date()); //현재 일자
		        cal.add(Calendar.DATE, -30+i); //하루씩 빼서 저장
		        gg[i] = 0;	
		        
		        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				 
		        String weekDate = sdf.format(cal.getTime()); //일자 가져와서 weekDate 로 만들기. 
		        weekList.add(weekDate);			//weekList 에 하나씩 저장. 1/2 1/1 ...
		}
		 
		//데이터 가져오기
		
		
		int ii = 0;
		for(int j=0; j< 31; j++) {
				Calendar cal = Calendar.getInstance();
		        cal.setTime(new Date()); //현재 일자
		        cal.add(Calendar.DATE, -30+j); //하루씩 빼서 저장
		        
		        //1번째 : 30일전 날짜
		        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		        String date = sdf.format(cal.getTime()); // 12월3일
		        
		        
		        ii  = j; // j처럼 0부터 시작
		        for(int z=0; z<chart_sales.size(); z++) {	
		        	String subdate = chart_sales.get(z).getSubstart(); //12월 28일 
		        	
		        	int compare = date.compareTo(subdate); 
		        	
		        	//해당 날짜가 chart_sales에 있는지 있다면, 순서 index 가져오기
			        if(compare != 0) {
			        	gg[ii] = 0;
			        	continue;
			        } else {
			        	gg[ii] = chart_sales.get(z).getSum_paid_amount();
			        	
			        }
			        
			        break;

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
		
		map2.put("name", "일별 매출 합계");
		map2.put("type", "line");
		
		Map<String, Object> areaStyle;
		areaStyle = new HashMap<>();
		
		map2.put("areaStyle", areaStyle);	
		map2.put("barWidth", "80%");
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
	

	
	//차트 - 2 가입자 수 !!  + 컨텐츠 영역
	@RequestMapping(value="line2")
	@ResponseBody
	public Map<String, Object> line2() throws Exception {
		
		//통계 차트 - 가입자수 
		List<Perform> chart_member = service.chart_member();
		
		Map<String, Object> model = new HashMap<>();
		
		//날짜 
		List<String> weekList = new ArrayList<>();
		
		
		int[] gg = new int[31]; //매출 금액 들어갈 리스트 
		
		
		for(int i=0; i<31; i++) {
		        Calendar cal = Calendar.getInstance();
		        cal.setTime(new Date()); //현재 일자
		        cal.add(Calendar.DATE, -30+i); //하루씩 빼서 저장
		        gg[i] = 0;	
		        
		        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				 
		        String weekDate = sdf.format(cal.getTime()); //일자 가져와서 weekDate 로 만들기. 
		        weekList.add(weekDate);			//weekList 에 하나씩 저장. 1/2 1/1 ...
		}
		

		int ii = 0;
		for(int j=0; j< 31; j++) {
				Calendar cal = Calendar.getInstance();
		        cal.setTime(new Date()); //현재 일자
		        cal.add(Calendar.DATE, -30+j); //하루씩 빼서 저장
		        
		        //1번째 : 30일전 날짜
		        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		        String date = sdf.format(cal.getTime()); // 12월3일
		        
		        ii  = j; // j처럼 0부터 시작
		        for(int z=0; z<chart_member.size(); z++) {	
		        	String subdate = chart_member.get(z).getJoindate(); //12월 28일 
		        	
		        	int compare = date.compareTo(subdate); 
		        	
		        	//해당 날짜가 chart_sales에 있는지 있다면, 순서 index 가져오기
			        if(compare != 0) {
			        	gg[ii] = 0;
			        	continue;
			        } else {
			        	gg[ii] = chart_member.get(z).getDataMember();
			        	System.out.println(gg[ii]);
			        	
			        }
			        
			        break;

		        }
		}
		
	
		
		//series
		List<Map<String, Object>> list2 = new ArrayList<>();
		Map<String, Object> map2;
		map2 = new HashMap<>();
		
		Map<String, Object> itemStyle;
		itemStyle = new HashMap<>();
		
		itemStyle.put("color", "#7B68EE	 ");
		itemStyle.put("borderRadius", 6);
		
		map2.put("name", "일별 가입자수 합계");
		map2.put("type", "line");
		
		Map<String, Object> areaStyle;
		areaStyle = new HashMap<>();
		
		map2.put("areaStyle", areaStyle);		
		map2.put("barWidth", "80%");
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
	
	
	@RequestMapping(value = "list_member")
	public String list_member(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "") String year,
			HttpServletRequest req,
			Model model) throws Exception {
		
		int size = 30;
		int total_page = 0;
		int dataCount = 0;
		
		//전체 페이지 수 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("year", year);
		
		
		
		
		List<Perform> list = null;
		
		
		
		model.addAttribute("list", list);
		
		
		return "/admin/perform/list_member";
	}
	
	
	@RequestMapping(value = "list_sales")
	public String list_sales(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "") String year,
			HttpServletRequest req,
			Model model) throws Exception {
		
		int size = 30;
		int total_page = 0;
		int dataCount = 0;
		
		//전체 페이지 수 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("year", year);
		

		
		List<Perform> list = null;
		
		
		
		model.addAttribute("list", list);
		
		
		return "/admin/perform/list_sales";
	}
		
	
	@RequestMapping(value = "list_hitcount")
	public String list_hitcount(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "") String year,
			HttpServletRequest req,
			Model model) throws Exception {
		
		int size = 30;
		int total_page = 0;
		int dataCount = 0;
		
		//전체 페이지 수 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("year", year);
		

		
		List<Perform> list = null;
		
		
		
		model.addAttribute("list", list);
		
		
		return "/admin/perform/list_hitcount";
	}
	
	
	
	
	
}
