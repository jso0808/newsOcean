package com.sp.app.admin.member;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.MyUtil;

@Controller("admin.member.memberController")
@RequestMapping("/admin/member/*")
public class MemberController {
	@Autowired
	private MemberService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value = "main")
	public String main() throws Exception {
		return ".admin.member.main";
	}
	
	
	@RequestMapping(value = "list")
	public String list(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		int size  = 12;
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) { 	//get 방식 불가
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		//전체 페이지수  -
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		if(dataCount != 0) {
			total_page = myUtil.pageCount(dataCount, size);
		}
		
		//페이지수 전체
		if (total_page < current_page) {
			current_page = total_page;
		}
		
		//전체 리스트 (1)
		int offset = (current_page - 1) * size;
		if(offset < 0) offset = 0;
		
		map.put("offset", offset);
		map.put("size", size);
		
		List<Member> list = service.listMember(map);
		
		
		///오늘 날짜 출력 ------------
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		String sysdate = sdf.format(date);
		
		//오늘 가입한 사람, 유료 회원수 
		int todayCount = 0;
		todayCount = service.todayCount(map);
		
		int todaySubCount = 0;
		todaySubCount = service.todaySubCount(map);
		
		
		//------------------------------
		//ajax 리스트
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("list", list);
		model.addAttribute("sysdate", sysdate);
		
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("todayCount", todayCount);
		model.addAttribute("todaySubCount", todaySubCount);
		
		
		model.addAttribute("size", size);
		model.addAttribute("paging", paging);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("total_page", total_page);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "admin/member/list";
	}
	
	
	
	@RequestMapping(value = "listSub")
	public String listSub(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		int size  = 12;
		int total_page = 0;
		int dataCount_sub = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) { 	//get 방식 불가
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		//전체 페이지수  -
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount_sub = service.dataCount_sub(map);
		if(dataCount_sub != 0) {
			total_page = myUtil.pageCount(dataCount_sub, size);
		}
		
		//페이지수 전체
		if (total_page < current_page) {
			current_page = total_page;
		}
		
		//전체 리스트 (1)
		int offset = (current_page - 1) * size;
		if(offset < 0) offset = 0;
		
		map.put("offset", offset);
		map.put("size", size);
		
		List<Member> list = service.listSub(map);
		
		
		///오늘 날짜 출력 ------------
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		String sysdate = sdf.format(date);
		
		//오늘 가입한 사람, 유료 회원수 
		int todayCount = 0;
		todayCount = service.todayCount(map);
		
		int todaySubCount = 0;
		todaySubCount = service.todaySubCount(map);
		
		
		//------------------------------
		//ajax 리스트
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("list", list);
		model.addAttribute("sysdate", sysdate);
		
		model.addAttribute("dataCount", dataCount_sub);
		model.addAttribute("todayCount", todayCount);
		model.addAttribute("todaySubCount", todaySubCount);
		
		model.addAttribute("size", size);
		model.addAttribute("paging", paging);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("total_page", total_page);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		
		return "admin/member/list";
	}
	
	@RequestMapping(value = "listEn")
	public String listEn(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		int size  = 12;
		int total_page = 0;
		int dataCount_en = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) { 	//get 방식 불가
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		//전체 페이지수  -
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount_en = service.dataCount_en(map);
		if(dataCount_en != 0) {
			total_page = myUtil.pageCount(dataCount_en, size);
		}
		
		//페이지수 전체
		if (total_page < current_page) {
			current_page = total_page;
		}
		
		//전체 리스트 (1)
		int offset = (current_page - 1) * size;
		if(offset < 0) offset = 0;
		
		map.put("offset", offset);
		map.put("size", size);
		
		List<Member> list = service.listEn(map);
		
		
		///오늘 날짜 출력 ------------
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		String sysdate = sdf.format(date);
		
		//오늘 가입한 사람, 유료 회원수 
		int todayCount = 0;
		todayCount = service.todayCount(map);
		
		int todaySubCount = 0;
		todaySubCount = service.todaySubCount(map);
		
		
		//------------------------------
		//ajax 리스트
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("list", list);
		model.addAttribute("sysdate", sysdate);
		
		model.addAttribute("dataCount", dataCount_en);
		model.addAttribute("todayCount", todayCount);
		model.addAttribute("todaySubCount", todaySubCount);
		
		model.addAttribute("size", size);
		model.addAttribute("paging", paging);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("total_page", total_page);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		
		return "admin/member/list";
	}
	
	
	@RequestMapping(value = "article")
	public String article(@RequestParam long memberNo,
			HttpServletResponse resp,
			Model model) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", memberNo);
		
		Member dto = service.readMember(map);
		if(dto == null) {
			resp.sendError(410);
			return "redirect:/admin/member/main";
		}
		
		model.addAttribute("dto", dto);
		
		return "admin/member/article";
	}
	
	//계정 상태 변경
	@RequestMapping(value = "update_en", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateEnabled(@RequestParam long memberNo,
			@RequestParam long enabled) throws Exception {
		
		String state = "false";

		try {
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberNo", memberNo);
			map.put("enabled", enabled);
			
			service.updateEnabled(map);
			
			state = "true";
			
		} catch (Exception e) {
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
}
