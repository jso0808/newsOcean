package com.sp.app.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.member.SessionInfo;


@Controller("main.mainController")
public class MainController {
	@Autowired
	private SearchService service;
	
	@GetMapping("/recent")
	public String recent(@PathVariable("categoryNo") String categoryNo2,
			@RequestParam(name="categoryNo",required=false) String categoryNo,
			@RequestParam(required=false) Search search, 
			HttpSession session,
			Model model) {
		
		List<MainCategory> subsectionlist = service.subsectionlist(categoryNo);
		model.addAttribute("subsectionlist", subsectionlist);
        return ".main.recent";
	}
	
	@GetMapping("/section")
	public String section(@PathVariable("categoryNo") String categoryNo2,
			@RequestParam(name="categoryNo",required=false) String categoryNo,
			@RequestParam(required=false) Search search, 
			HttpSession session,
			Model model) {
		
		List<MainCategory> subsectionlist = service.subsectionlist(categoryNo);
		
		model.addAttribute("subsectionlist", subsectionlist);
		
        return ".main.section";
	}
	
	@GetMapping("/subsection")
	public String subsection(@PathVariable("categoryNo") String categoryNo2,
			@RequestParam(name="categoryNo",required=false) String categoryNo,
			HttpSession session,
			Model model) {
		
		List<MainCategory> subsectionlist = service.subsectionlist(categoryNo);
		
		model.addAttribute("subsectionlist", subsectionlist);
		
        return ".main.subsection";
	}
	
	@GetMapping("/search")
	public String search(Search search,
			HttpSession session,Model model) {
		
		//카테고리 리스트
		List<MainCategory> list = service.listCategory();
		
		model.addAttribute("categorylist", list);
        return ".main.search";
	}
	
	//키워드 자동완성
	@ResponseBody
	@GetMapping(value="/searchform")
	public String wordSearchShow(@RequestParam String searchType,
			@RequestParam(value = "searchWord",required = false, defaultValue = "")  String searchWord) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		
		List<String> wordList = service.wordSearchShow(map);
		System.out.println(wordList);
		JSONArray jsonArr = new JSONArray();  
			if(wordList != null) {
				for(String word : wordList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("word", word);			
					jsonArr.put(jsonObj);
				}
			}
		return jsonArr.toString();
	}

	@PostMapping("/searchresult")
	public String searchresult(@RequestParam(name="searchName",required=false) String searchName,
			@RequestParam(name="categoryNo",required=false) String categoryNo,//여러개를 넘겨받을때 string으로 받으면 ,로 구분되어 들어온다.
			@RequestParam String searchType ,
			HttpSession session,
			Model model) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			Search search = new Search();
			long memberNo = info.getMemberNo();
			
			search.setMemberNo(memberNo);
			System.out.println("memberNo:"+memberNo+"searchName:"+searchName+"categoryNo:"+categoryNo);
			search.setSearchName(searchName); 
			search.setCategoryNo(categoryNo);//203, 204, 205
			 
			model.addAttribute("search", search);
			model.addAttribute("memberNo", memberNo);
			model.addAttribute("categoryNo", categoryNo);
			model.addAttribute("searchName", searchName);
			model.addAttribute("searchType", searchType);
			
			service.insertSearchHistory(search);
		} catch (Exception e) {
			model.addAttribute("message", "데이터 등록이 실패했습니다.");
			e.printStackTrace();
			return ".main.searchresult";
		}
		
		 return ".main.searchresult";
	}
	
}
