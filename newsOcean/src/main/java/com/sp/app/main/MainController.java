package com.sp.app.main;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.MyUtil;
import com.sp.app.member.SessionInfo;


@Controller("main.mainController")
public class MainController {
	@Autowired
	private SearchService service;
	@Autowired
	private MainMongoOperations mainMongo;
	@Autowired
	private MyUtil myUtil;
	
	@GetMapping("/recent")
	public String recent(@RequestParam int categoryNo,
			@RequestParam(required=false) Search search, 
			HttpSession session,
			Model model) {
		List<MainCategory> subsectionlist = service.subsectionlist(categoryNo);
		
		model.addAttribute("categoryNo", categoryNo);
		model.addAttribute("subsectionlist", subsectionlist);//카테고리명, 카테고리번호
		
        return ".main.recent";
	}
	
	@GetMapping("/section")
	public String section(@RequestParam int categoryNo,
			HttpSession session,
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req,
			Model model) {
		int size = 10;
		int total_page = 0;
		int dataCount = 0;

		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		dataCount = (int) mainMongo.dataCount(categoryNo);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(dataCount, size);
		}
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if (total_page < current_page) {
			current_page = total_page;
		}
		
		// 리스트에 출력할 데이터를 가져오기
		int offset = (current_page - 1) * size;
		if(offset < 0) offset = 0;
		
		map.put("offset", offset);
		map.put("size", size);
		//카테고리번호에 해당하는 뉴스리스트
		List<News> subCategoryNews = mainMongo.categoryNews(categoryNo);
		List<MainCategory> subsectionlist = service.subsectionlist(categoryNo);
		
		model.addAttribute("subCategoryNews", subCategoryNews);
		model.addAttribute("categoryNo", categoryNo);
		model.addAttribute("subsectionlist", subsectionlist);//카테고리명, 카테고리번호
        return ".main.section";
	}
	
	@GetMapping("/subsection")
	public String subsection(@RequestParam int categoryNo,
			HttpSession session,
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req,
			Model model) {
		int size = 10;
		int total_page = 0;
		int dataCount = 0;

		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		dataCount = (int) mainMongo.dataCount(categoryNo);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(dataCount, size);
		}
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if (total_page < current_page) {
			current_page = total_page;
		}
		
		// 리스트에 출력할 데이터를 가져오기
		int offset = (current_page - 1) * size;
		if(offset < 0) offset = 0;
		
		map.put("offset", offset);
		map.put("size", size);
		//카테고리번호에 해당하는 뉴스리스트
		List<News> subCategoryNews = mainMongo.categoryNews(categoryNo);
		List<MainCategory> subsectionlist = service.subsectionlist(categoryNo);
		
		model.addAttribute("subCategoryNews", subCategoryNews);//뉴스크롤링정보
		model.addAttribute("categoryNo", categoryNo);//카테고리번호
		model.addAttribute("subsectionlist", subsectionlist);//카테고리명, 카테고리번호
		
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
		map.put("searchType", searchType);// subject,searchName
		map.put("searchWord", searchWord);
		List<String> wordList2 = mainMongo.wordSearchShow(searchType, searchWord);
		//List<String> wordList = service.wordSearchShow(map);
		System.out.println(wordList2);
		JSONArray jsonArr = new JSONArray();  
			if(wordList2 != null) {
				for(String word : wordList2) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("word", word);			
					jsonArr.put(jsonObj);
				}
			}
		return jsonArr.toString();
	}

	@PostMapping("/searchresult")
	public String searchresult(@RequestParam(name="searchName",required=false) String searchName,
			@RequestParam(name="categoryNo",required=false) String categoryNoString,
			//여러개를 넘겨받을때 string으로 받으면 ,로 구분되어 들어온다.
			@RequestParam String searchType,
			HttpSession session,
			Model model) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			Search search = new Search();
			long memberNo = info.getMemberNo();
			
			search.setMemberNo(memberNo);
			if(searchName!=null) {
				search.setSearchName(searchName); 
				search.setSearchType(searchType); 
			}
			if(categoryNoString!=null) {
				search.setCategoryNo(categoryNoString);//203, 204, 205
				//카테고리번호 1개보다 많은경우
				if(categoryNoString.length()>4) {
					List<Integer> categoryNo = new ArrayList<Integer>();
					
					String[] categoryNoArray = categoryNoString.split(",");
					List<String> categoryNoList = new ArrayList<String>(Arrays.asList(categoryNoArray));
					for(String s : categoryNoList) {
						Integer strim = Integer.valueOf(s.trim());
						categoryNo.add(strim);
					}
					System.out.println(categoryNo);
					model.addAttribute("categoryNo", categoryNo);
					//categoryNo가 리스트로 들어감
					//searchNews = mainMongo.searchlistNews(searchType,searchName, categoryNo);
				}else {
					categoryNoString = categoryNoString.trim();
					int categoryNo = Integer.parseInt(categoryNoString);
					model.addAttribute("categoryNo", categoryNo);
					//categoryNo가 int 하나
					//mainMongo.searchNews(searchType,searchName, categoryNo);
				}
			}
			//검색기록저장
			service.insertSearchHistory(search);
			//통합검색 mongodb에서 가져오기
			model.addAttribute("memberNo", memberNo);
			model.addAttribute("searchName", searchName);
			model.addAttribute("searchType", searchType);
			//model.addAttribute("searchNews", searchNews);
		} catch (Exception e) {
			model.addAttribute("message", "데이터 등록이 실패했습니다.");
			e.printStackTrace();
			return ".main.searchresult";
		}
		 return ".main.searchresult";
	}

	
}
