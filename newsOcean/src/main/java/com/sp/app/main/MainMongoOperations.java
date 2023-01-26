package com.sp.app.main;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

@Service("main.mainMongoOperations")
public class MainMongoOperations {
	@Autowired
	private MongoOperations mongo;
	//전체페이지 카테고리개수
	public long dataCount() {
		long result = 0;
		
		try {
			Query query = new Query();
			result = mongo.count(query, News.class); // 조건, entityClass
			// result = mongo.count(query, "컬렉션명");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	//전체페이지 뉴스하나(각 카테고리별로 뉴스1개씩 가져오기)
	public List<News> AllNews() {
		List<News> list = new ArrayList<News>();
		try {
			for(int i=200;i<=612;i++) {
				Query query = new Query();
				query.with(Sort.by(Sort.Direction.DESC, "crawlDate"));
				query.addCriteria(Criteria.where("category").is(Integer.toString(i)));		
				News news1 = new News();
				news1 = mongo.findOne(query, News.class);
				if(news1 ==null) continue;
				list.add(news1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	//페이징의 데이터개수
	public long dataCount(int categoryNo) {
		long result = 0;
		String categoryNo2 = Integer.toString(categoryNo);
		try {
			Query query = new Query();
			query.addCriteria(Criteria.where("category").is(categoryNo2));
			result = mongo.count(query, News.class); // 조건, entityClass
			// result = mongo.count(query, "컬렉션명");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	//카테고리번호에 해당하는 뉴스리스트
	public List<News> categoryNews(int categoryNo,int page,int size) {
		List<News> list = null;
		
		try {
			page = page >= 1 ? (page - 1) : 0;
			Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "crawlDate")); // page, size
			String categoryNo2 = Integer.toString(categoryNo);
			System.out.println(categoryNo2);
			Query query = new Query();
			query.with(pageable);
			query.addCriteria(Criteria.where("category").is(categoryNo2));
			list = mongo.find(query, News.class);
			System.out.println(list.size());
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	//최신카테고리의 전체 뉴스리스트
	public List<News> recentlist(int page,int size) {
		List<News> list = null;

		try {
			page = page >= 1 ? (page - 1) : 0;
			Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "crawlDate")); // page, size
			Query query = new Query();
			query.with(pageable);
			list = mongo.find(query, News.class);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//최신카테고리의 카테고리번호별 뉴스리스트
	public List<News> recentlist(String categoryNoStr, int page,int size) {
		List<News> list = null;

		try {
			page = page >= 1 ? (page - 1) : 0;
			Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "crawlDate")); // page, size
			Query query = new Query();
			query.addCriteria(Criteria.where("category").is(categoryNoStr));
			query.with(pageable);
			list = mongo.find(query, News.class);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	//검색자동완성
	public List<String>  wordSearchShow(String searchType, String searchWord) {
		List<String>  wordlist = new ArrayList<String>();
		
		if(searchType.equals("subject")) {
			//BasicQuery query = new BasicQuery("{kor : {$gte : 80}}");
			BasicQuery query = new BasicQuery("{'crawlTitle': { $regex: '"+searchWord+"' }}");
			//? 변수 정규식로 넣으려고 하는데 어떻게
			List<News> list = mongo.find(query, News.class);
			System.out.println("subject");
			for(News dto : list) {
				wordlist.add(dto.getCrawlTitle());
			}
		} else if(searchType.equals("keyword")) {
			BasicQuery query = new BasicQuery("{'crawlContent': { $regex: '"+searchWord+"' }}");
			List<News> list = mongo.find(query, News.class);
			System.out.println("keyword");
			for(News dto : list) {
				wordlist.add(dto.getCrawlContent());
			}
		}
		return wordlist;
	}
	//검색기록저장
	public void insertSearchHistory(Search search) throws Exception {
		try {
			// mongo.save(dto, "News"); // 없으면 추가, 있으면 수정
			mongo.save(search);
		}catch(Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}
	//뉴스검색결과(뉴스리스트) categoryNo여러개 type: list<Integer>
	//categoryNo별 뉴스리스트 for문 후 합쳐서 출력
	public Map<String, Object>  searchlistNews(String searchType,String searchName,List<String> categoryNo, int page, int size) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<News>  list = null;
		List<News>  list2 = null;
		long count=0;
		try {
			// 페이징 처리 
			page = page >= 1 ? (page - 1) : 0;
			Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "crawlDate")); // page, size
			//검색타입 제목
			if(searchType.equals("subject")) {	
				
				if(categoryNo==null || categoryNo.isEmpty()) {
					String bq = "{'crawlTitle': { $regex: '"+searchName+"' }}";
					BasicQuery query = new BasicQuery(bq);
					list2 = mongo.find(query, News.class);
					count = list2.size();
					
					//페이징 리스트 반환
					BasicQuery querypage = new BasicQuery(bq);
					querypage.with(pageable);
					list = mongo.find(querypage, News.class);
				}else {
					String category = "[";
					for(String s : categoryNo) {
						category += "'" + s + "',";
					}	
					category = category.substring(0, category.length()-1) + "]";
					String bq = "{$and : [{'crawlTitle': { $regex: '"+searchName+"'}},{'category' : {$in : "+category+"} }]}";
					//전체 리스트개수
					BasicQuery query = new BasicQuery(bq);
					list2 = mongo.find(query, News.class);
					count = list2.size();
					
					//페이징 리스트 반환
					BasicQuery querypage = new BasicQuery(bq);
					querypage.with(pageable);
					list = mongo.find(querypage, News.class);
				}
			//검색타입 keyword
			} else if(searchType.equals("keyword")) {
				if(categoryNo==null || categoryNo.isEmpty()) {
					String bq = "{'crawlContent': { $regex: '"+searchName+"' }}";
					BasicQuery query = new BasicQuery(bq);
					list2 = mongo.find(query, News.class);
					count = list2.size();
					
					//페이징 리스트 반환
					BasicQuery querypage = new BasicQuery(bq);
					querypage.with(pageable);
					list = mongo.find(querypage, News.class);
				}else {
					String category = "[";
					for(String s : categoryNo) {
						category += "'" + s + "',";
					}
					category = category.substring(0, category.length()-1) + "]";
					
					String bq = "{$and : [{'crawlContent': { $regex: '"+searchName+"'}},{'category' : {$in : "+category+"} }]}";
					BasicQuery query = new BasicQuery(bq);
					list2 = mongo.find(query, News.class);
					count = list2.size();
					
					//페이징 리스트 반환
					BasicQuery querypage = new BasicQuery(bq);
					querypage.with(pageable);
					list = mongo.find(querypage, News.class);
				}
			}
			System.out.println(list);
			resultMap.put("list", list);
			resultMap.put("count", count);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	//뉴스검색결과(뉴스리스트)
	//categoryNo 하나
	public Map<String, Object>  searchNews(String searchType,String searchName,String categoryNo, int page, int size) {
		List<News>  list = new ArrayList<News>();
		List<News>  list2 = null;
		Map<String, Object> resultMap = new HashMap<String, Object>();
		long count=0;
		
		try {
			page = page >= 1 ? (page - 1) : 0;
			Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "crawlDate")); // page, size
			
			if(searchType.equals("subject")) {
				
				//검색어없는경우
				if(searchName.isEmpty()) {
					BasicQuery query = new BasicQuery("{'category' :'"+categoryNo+"' }");
					list2 = mongo.find(query, News.class);
					count = list2.size();
					System.out.println(searchName + "   " + categoryNo+ "count"+count);
					//페이징 리스트 반환
					BasicQuery querypage = new BasicQuery("{'category' :'"+categoryNo+"' }");
					querypage.with(pageable);
					list = mongo.find(querypage, News.class);
				}
				//검색어 있는경우
				else {
					BasicQuery query = new BasicQuery("{$and : [{'crawlTitle': { $regex: '"+searchName+"' },'category' :'"+categoryNo+"' }]");
					list2 = mongo.find(query, News.class);
					count = list2.size();
					
					//페이징 리스트 반환
					BasicQuery querypage = new BasicQuery("{$and : [{'crawlTitle': { $regex: '"+searchName+"' },'category' :'"+categoryNo+"' }]");
					querypage.with(pageable);
					list = mongo.find(querypage, News.class);
				}
			} else if(searchType.equals("keyword")) {
				
				//키워드없는 경우
				if(searchName.isEmpty()){
					BasicQuery query = new BasicQuery("{'category' :'"+categoryNo+"' }");
					list2 = mongo.find(query, News.class);
					count = list2.size();
					
					//페이징 리스트 반환
					BasicQuery querypage = new BasicQuery("{'category' :'"+categoryNo+"' }");
					querypage.with(pageable);
					list = mongo.find(querypage, News.class);
					
				//키워드있는경우
				}else {
					BasicQuery query = new BasicQuery("{$and : [{'crawlContent': { $regex: '"+searchName+"' },'category' :'"+categoryNo+"' }]");
					list2 = mongo.find(query, News.class);
					count = list2.size();
					
					//페이징 리스트 반환
					BasicQuery querypage = new BasicQuery("{$and : [{'crawlContent': { $regex: '"+searchName+"' },'category' :'"+categoryNo+"' }]");
					querypage.with(pageable);
					list = mongo.find(querypage, News.class);
				}
			}
			System.out.println("-------------------------");
			System.out.println("list:"+list);
			resultMap.put("list", list);
			resultMap.put("count", count);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return resultMap;	
	}

}