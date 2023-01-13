package com.sp.app.main;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
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
	
	
	@GetMapping("/")
	public String main(HttpSession session,
			HttpServletRequest req,
			Model model) {
		//카테고리별 뉴스 1개씩 가져온 리스트
		List<com.sp.app.main.News> subCategoryNews = mainMongo.AllNews();
		
		model.addAttribute("subCategoryNews", subCategoryNews);
        return ".mainLayout";
        
	}
	@GetMapping("/recent")
	public String recent(@RequestParam int categoryNo,
			HttpSession session,
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req,
			Model model) {
		int size = 9;
		int total_page = 0;
		int dataCount = 0;

		// 전체 페이지 수
		dataCount = (int) mainMongo.dataCount(categoryNo);
		System.out.println("dataCount:"+dataCount);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(dataCount, size);
		}
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		//카테고리번호에 해당하는 뉴스리스트
		List<News> subCategoryNews = mainMongo.categoryNews(categoryNo, current_page, size);
		List<MainCategory> subsectionlist = service.subsectionlist(categoryNo);
		String cp = req.getContextPath();
		String listUrl = cp + "/recent";
		String paging = myUtil.pagingUrl(current_page, total_page, listUrl);
		
		//페이징
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("size", size);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		model.addAttribute("subCategoryNews", subCategoryNews);
		model.addAttribute("categoryNo", categoryNo);
		model.addAttribute("subsectionlist", subsectionlist);//카테고리명, 카테고리번호
        return ".main.section";
	}
	
	@GetMapping("/section")
	public String section(@RequestParam int categoryNo,
			HttpSession session,
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req,
			Model model) {
		int size = 9;
		int total_page = 0;
		int dataCount = 0;

		// 전체 페이지 수
		dataCount = (int) mainMongo.dataCount(categoryNo);
		System.out.println("dataCount:"+dataCount);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(dataCount, size);
		}
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		//카테고리번호에 해당하는 뉴스리스트
		List<News> subCategoryNews = mainMongo.categoryNews(categoryNo, current_page, size);
		List<MainCategory> subsectionlist = service.subsectionlist(categoryNo);
		String cp = req.getContextPath();
		String listUrl = cp + "/section?"+"categoryNo="+categoryNo;
		String paging = myUtil.pagingUrl(current_page, total_page, listUrl);
		
		//페이징
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("size", size);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
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
		int size = 9;
		int total_page = 0;
		int dataCount = 0;

		// 전체 페이지 수
		System.out.println(":--------------------");
		System.out.println("categoryNo:"+categoryNo);
		dataCount = (int) mainMongo.dataCount(categoryNo);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(dataCount, size);
		}
		System.out.println(":--------------------");
		System.out.println("dataCount:"+dataCount);
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if(current_page > total_page) {
			current_page = total_page;
		}
		System.out.println("total_page:"+total_page);
		

	
		//카테고리번호에 해당하는 뉴스리스트
		List<News> subCategoryNews = mainMongo.categoryNews(categoryNo, current_page, size);
		List<MainCategory> subsectionlist = service.subsectionlist(categoryNo);
		String cp = req.getContextPath();
		String listUrl = cp + "/subsection?"+"categoryNo="+categoryNo;
		String paging = myUtil.pagingUrl(current_page, total_page, listUrl);
		System.out.println("paging:"+paging);
		

		
		//페이징
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("size", size);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);	
		
		model.addAttribute("subCategoryNews", subCategoryNews);//뉴스크롤링정보
		model.addAttribute("categoryNo", categoryNo);//카테고리번호
		model.addAttribute("subsectionlist", subsectionlist);//카테고리명, 카테고리번호
		
         return ".main.subsection";
	}
	
	@GetMapping("/search")
	public String search(Search search,
			HttpSession session,Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if(info == null) return ".member.login";
		//카테고리 리스트
		List<MainCategory> list = service.listCategory();
		
		model.addAttribute("categorylist", list);
        return ".main.search";
	}
	
	//키워드 자동완성
	@ResponseBody
	@GetMapping(value="/searchform")
	public String wordSearchShow(@RequestParam String searchType,
			HttpServletRequest req, HttpSession session,
			@RequestParam(value = "searchWord",required = false, defaultValue = "")  String searchWord) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if(info == null) return ".member.login";
		try {
			if (req.getMethod().equalsIgnoreCase("GET"))  // GET 방식인 경우
				searchWord = URLDecoder.decode(searchWord, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
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
					if(word.length()>=20) {
						word = word.substring(0, 20);
						word += "...";
					}
					jsonObj.put("word", word);			
					jsonArr.put(jsonObj);
				}
			}
		return jsonArr.toString();
	}

	@GetMapping("/searchresult")
	public String searchresult(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(name="searchName",required=false) String searchName,
			@RequestParam(name="categoryNo",required=false) String categoryNoString,
			//여러개를 넘겨받을때 string으로 받으면 ,로 구분되어 들어온다.
			@RequestParam String searchType,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception {
		int size = 10;
		int total_page = 0;
		int count=0;
		
		try {
			//로그인정보
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if(info == null) return ".member.login";
			Search search = new Search();
			long memberNo = info.getMemberNo();
			//페이징 map선언
			Map<String, Object> map = new HashMap<String, Object>();
			
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
					//categoryNoList2에 값을 trim해서 categoryNoList에 넣어줌
					String[] categoryNoArray = categoryNoString.split(",");
					List<String> categoryNoList2 = new ArrayList<String>(Arrays.asList(categoryNoArray));
					List<String> categoryNoList = new ArrayList<String>();
					for(String s : categoryNoList2) {
						String strim = s.trim();
						categoryNoList.add(strim);
					}
				//뉴스리스트
					//return: List<News> list(뉴스리스트), long count(뉴스리스트총개수)
					map = mainMongo.searchlistNews(searchType, searchName, categoryNoList, current_page, size);
					
					@SuppressWarnings("unchecked")
					List<News> list = (List<News>)map.get("list");
					count = Integer.parseInt(String.valueOf(map.get("count")));
					System.out.println("---------------------");
					System.out.println("count: "+count);
					System.out.println(list);
					model.addAttribute("list", list);
				//카테고리번호  1개인경우(categoryNo가 int 하나)	
				}else {
					categoryNoString = categoryNoString.trim();
					int categoryNo = Integer.parseInt(categoryNoString);
					model.addAttribute("categoryNo", categoryNo);
					//map -return list, count
					map = mainMongo.searchNews(searchType,searchName, categoryNoString, current_page, size);
					@SuppressWarnings("unchecked")
					List<News> list = (List<News>)map.get("list");
					count = Integer.parseInt(String.valueOf(map.get("count")));
					System.out.println("---------------------");
					System.out.println("count: "+count);
					System.out.println(list);
					model.addAttribute("list", list);
					
				}
			}
			
			if (count != 0) {
				total_page = myUtil.pageCount(count, size);
				System.out.println("total_page:" + total_page);
			}
			// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			//검색기록저장
			service.insertSearchHistory(search);
			
			String cp = req.getContextPath();
			String listUrl = cp + "/main/searchresult";
			String paging = myUtil.pagingUrl(current_page, total_page, listUrl);
			
			
			//페이징
			model.addAttribute("page", current_page);
			model.addAttribute("dataCount", count);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			
			//paging으로 다시 가져올 파라미터
			model.addAttribute("searchName", searchName);
			model.addAttribute("searchType", searchType);
			model.addAttribute("categoryNo", categoryNoString);
		} catch (Exception e) {
			model.addAttribute("message", "데이터 등록이 실패했습니다.");
			e.printStackTrace();
			return ".main.searchresult";
		}
		 return ".main.searchresult";
	}

	
}
