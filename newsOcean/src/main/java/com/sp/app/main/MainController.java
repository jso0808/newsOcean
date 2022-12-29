package com.sp.app.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.member.SessionInfo;


@Controller("main.mainController")
public class MainController {
	@Autowired
	private SearchService service;
	
	@GetMapping("/recent")
	public String recent(@RequestParam(name="categoryNo",required=false) int categoryNo,
			@RequestParam(required=false) Search search, 
			HttpSession session,
			Model model) {
        System.out.println();
        return ".main.recent";
	}
	
	@GetMapping("/section")
	public String section(@RequestParam(name="categoryNo",required=false) int categoryNo,
			@RequestParam(required=false) Search search, 
			HttpSession session,
			Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<MainCategory> list = service.sectionlist();
        return ".main.section";
	}
	
	@GetMapping("/subsection")
	public String subsection(@RequestParam(name="categoryNo",required=false) int categoryNo,
			@RequestParam(required=false) Search search, 
			HttpSession session,
			Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<MainCategory> list = service.subsectionlist();
        return ".main.subsection";
	}
	
	@GetMapping("/search")
	public String search(Search search,
			HttpSession session,Model model) {
		
		//카테고리 리스트
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<Search> list = service.listCategory();
		
		model.addAttribute("categorylist", list);
        return ".main.search";
	}
	//키워드 자동완성
	@PostMapping("/search/searchform")
	public String searchSubmit(HttpSession session,
			@RequestParam Search search, Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
        return ".main.search";
	}
	
	@PostMapping("/searchresult")
	public String searchresult(@RequestParam(name="staDate",required=false) String staDate,
			@RequestParam(name="endDate",required=false) String endDate,  
			@RequestParam(name="categoryName",required=false) String categoryName, 
			@RequestParam(name="searchInfo",required=false) String keyword,
			@RequestParam(name="categoryNo",required=false) List<Integer> categoryNo,
			HttpSession session,
			Model model) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		Search search = new Search();
		long memberNo = info.getMemberNo();
		search.setMemberNo(memberNo);
		search.setKeyword(keyword);
		search.setCategoryName(categoryName);
		search.setCategoryNo(categoryNo);
		
		try {
			service.insertSearchHistory(search);
			
		} catch (Exception e) {
			model.addAttribute("message", "데이터 등록이 실패했습니다.");
			return ".main.searchresult";
		}
		
		model.addAttribute("search", search);
		model.addAttribute("staDate", staDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("categoryNo", categoryNo);
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("keyword", keyword);
		
		
		 return ".main.searchresult";
	}
	
}
