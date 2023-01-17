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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.MyUtil;
import com.sp.app.member.SessionInfo;
import com.sp.app.mypage.Keyword;
import com.sp.app.mypage.MypageService;


@Controller("main.mainController")
public class MainController {
	@Autowired
	private SearchService service;
	@Autowired
	private MypageService mpservice;
	@Autowired
	private PicknewsService pickservice;
	@Autowired
	private MainMongoOperations mainMongo;
	@Autowired
	private MyUtil myUtil;
	
	
	@GetMapping("/")
	public String main(@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpSession session,
			HttpServletRequest req,
			Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberNo", info.getMemberNo());
			List<Keyword> keywordList = mpservice.readMyKeyword(map);
			
			model.addAttribute("keywordList", keywordList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		//카테고리별 뉴스 1개씩 가져온 리스트
		List<com.sp.app.main.News> subCategoryNews = mainMongo.AllNews();
		
		model.addAttribute("subCategoryNews", subCategoryNews);
        return ".mainLayout";
        
	}
	
	
	@RequestMapping(value = "news_pick")
	public String news_pick(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			HttpSession session,
			HttpServletRequest req,
			Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		try {
			
			main(current_page, session, req, model);
			
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberNo", info.getMemberNo());
			
			List<Keyword> keywordList = mpservice.readMyKeyword(map);
			
			model.addAttribute("keywordList", keywordList);
			
			//뉴스 페이징 처리
			int size = 10; // 한 화면에 보여주는 게시물 수
			int total_page = 0;
			int dataCount = 0;

			dataCount = pickservice.total_dataCount_pick_news(map);
			if (dataCount != 0) {
				total_page = myUtil.pageCount(dataCount, size);
			}
			
			if (total_page < current_page) {
				current_page = total_page;
			}
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<Picknews> pick_news = pickservice.pick_news(map);
			
			String paging = myUtil.paging(current_page, total_page, "news_pick");
				
			model.addAttribute("pick_news", pick_news);
			model.addAttribute("paging", paging);
			model.addAttribute("pageNo", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("total_page", total_page);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}

        return "main/news_pick";
        
	}
	
	
	
	//101->201, 102->301 카테고리번호변경
	public static int cChange(int categoryNo) {
		int cChange;
		cChange = (categoryNo%10+1)*100+1;
		return cChange;
	}
	
	@GetMapping("/recent")
	public String recent(@RequestParam int categoryNo,
			HttpSession session,
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req,
			Model model) {
		int size = 12;	
		int total_page = 0;
		int dataCount = 0;
		List<MainCategory> subsectionlist = new ArrayList<MainCategory>();
		
		// 전체 페이지 수
		
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		
		List<News> subCategoryNews = new ArrayList<News>();
		//최신뉴스전체리스트=100, 최신뉴스 각카테고리 201, 301, 401,501, 601
		//<!-- 100번대면 최신뉴스대카테고리,(최신뉴스 소카테고리) 201,301,401,501,601은 나머지 -->
		
		try {
			if(categoryNo==100) {
				dataCount = (int) mainMongo.dataCount();
				if (dataCount != 0) {
					total_page = myUtil.pageCount(dataCount, size);
				}
				subCategoryNews = mainMongo.recentlist(current_page, size);
			}else if(categoryNo<200) {
				//101->
				int categoryNo2=cChange(categoryNo);
				dataCount = (int) mainMongo.dataCount(categoryNo2);
				if (dataCount != 0) {
					total_page = myUtil.pageCount(dataCount, size);
				}
				String cChangeStr=Integer.toString(categoryNo2);
				subCategoryNews = mainMongo.recentlist(cChangeStr, current_page, size);
			}else if(categoryNo%100 == 1) {
				//최신뉴스소카테고리
				dataCount = (int) mainMongo.dataCount(categoryNo);
				if (dataCount != 0) {
					total_page = myUtil.pageCount(dataCount, size);
				}
				String categoryNoStr = Integer.toString(categoryNo);
				subCategoryNews = mainMongo.recentlist(categoryNoStr,current_page, size);
			}else {
				Exception e = new Exception("적절하지 않은 카테고리번호");
				throw e;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(current_page > total_page) {
			current_page = total_page;
		}
		String cp = req.getContextPath();
		String listUrl = cp + "/recent?"+"categoryNo="+categoryNo;;
		String paging = myUtil.pagingUrl(current_page, total_page, listUrl);
		//최신카테고리 의 소카테고리 리스트에 전체추가
		if(categoryNo<200) {
			subsectionlist = service.sectionlist();
			MainCategory mc = new MainCategory();
			mc.setCategoryNo(100);
			mc.setCategoryName("전체");
			subsectionlist.add(0,mc);
		}else {
			//categoryNo >200이상이면
			subsectionlist = service.subsectionlist(categoryNo);
		}
		for(MainCategory n:subsectionlist) {
			System.out.println(n.getCategoryName());
			System.out.println(n.getCategoryNo());
		}
		//페이징
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("size", size);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		//subcategory nav목록
		model.addAttribute("subsectionlist", subsectionlist);
		model.addAttribute("categoryNo", categoryNo);
		
		model.addAttribute("subCategoryNews", subCategoryNews);
        return ".main.recent";
	}
	
	@GetMapping("/section")
	public String section(@RequestParam int categoryNo,
			HttpSession session,
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req,
			Model model) {
		int size = 12;
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
		int size = 12;
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
			@RequestParam(value = "searchName",required = false, defaultValue = "")  String searchName) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if(info == null) return ".member.login";
		try {
			if (req.getMethod().equalsIgnoreCase("GET"))  // GET 방식인 경우
				searchName = URLDecoder.decode(searchName, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		Map<String, Object> map = new HashMap<>();
		map.put("searchType", searchType);// subject,searchName
		map.put("searchWord", searchName);
		List<String> wordList2 = mainMongo.wordSearchShow(searchType, searchName);
		//List<String> wordList = service.wordSearchShow(map);
		System.out.println(wordList2);
		JSONArray jsonArr = new JSONArray();  
			if(wordList2 != null) {
				for(String word : wordList2) {
					JSONObject jsonObj = new JSONObject();
					if(word.length()>=40) {
						word = word.trim().substring(0, 40);
						word += "...";
					}
					jsonObj.put("word", word);			
					jsonArr.put(jsonObj);
				}
			}
		return jsonArr.toString();
	}

	@RequestMapping("/searchresult")
	public String searchresult(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(value="searchName",required=false) String searchName,
			@RequestParam(value="categoryNo",required=false) String categoryNoString,
			//여러개를 넘겨받을때 string으로 받으면 ,로 구분되어 들어온다.
			@RequestParam String searchType,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception {
		int size = 12;
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
			search.setCategoryNo(categoryNoString);//203, 204, 205
			System.out.println("---------------------");
			//검색어o, 카테고리x
			if(searchName !=null && categoryNoString == null) {
				categoryNoString="200,300,400,500,600";
				search.setCategoryNo(categoryNoString);
				search.setSearchName(searchName); 
				search.setSearchType(searchType); 
				//카테고리 여러개
				List<Integer> categoryNo = new ArrayList<Integer>();
				//categoryNoList2에 값을 trim해서 categoryNoList에 넣어줌
				String[] categoryNoArray = categoryNoString.split(",");
				List<String> categoryNoList2 = new ArrayList<String>(Arrays.asList(categoryNoArray));
				List<String> categoryNoList = new ArrayList<String>();
				for(String s : categoryNoList2) {
					String strim = s.trim();
					categoryNoList.add(strim);
					System.out.print(strim+",");
					categoryNo.add(Integer.parseInt(strim));
				}
				model.addAttribute("categoryNo", categoryNo);
				//뉴스리스트
				//return: List<News> list(뉴스리스트), long count(뉴스리스트총개수)
				map = mainMongo.searchlistNews(searchType, searchName, categoryNoList, current_page, size);
				@SuppressWarnings("unchecked")
				List<News> list = (List<News>)map.get("list");
				count = Integer.parseInt(String.valueOf(map.get("count")));
				System.out.println("count: "+count);
				System.out.println(list);
				model.addAttribute("list", list);
				System.out.println("검색어o, 카테고리x");
			}
			
			//검색어있거나 없거나, 카테고리o
			if(categoryNoString != null) {
				
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
						categoryNo.add(Integer.parseInt(strim));
					}
					model.addAttribute("categoryNo", categoryNo);
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
					search.setCategoryNo(categoryNoString);
					System.out.println("검색어있거나 없거나, 카테고리여러개");
				//카테고리번호  1개인경우(categoryNo가 int 하나)	
				}else if(categoryNoString.length()<=4 && categoryNoString.length()>0) {
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
					System.out.println("검색어있거나 없거나, 카테고리하나");
				}
			}
			//카테고리 선택안한경우(searchName있으면 카테고리전체, 	
			search.setSearchName(searchName); 
			search.setSearchType(searchType); 
			
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
			String listUrl = cp + "/searchresult?searchType="+searchType+"&searchName="+searchName+"&categoryNo="+categoryNoString;
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
		} catch (Exception e) {
			model.addAttribute("message", "데이터 등록이 실패했습니다.");
			e.printStackTrace();
			return ".main.searchresult";
		}
		 return ".main.searchresult";
	}

	
}
