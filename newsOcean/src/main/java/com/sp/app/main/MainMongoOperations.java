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
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
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
		News news = new News();
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
			
			// list = mongo.findAll(News.class);
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
	//최신카테고리 뉴스리스트
	public List<News> recentlist(int categoryNo,int page,int size) {
		List<News> list = null;
		
		try {
			page = page >= 1 ? (page - 1) : 0;
			Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "crawlDate")); // page, size
			
			// list = mongo.findAll(News.class);
			String categoryNo2 = Integer.toString(categoryNo);
			System.out.println(categoryNo2);
			Query query = new Query();
			query.with(pageable);
			query.addCriteria(Criteria.where("category").is(categoryNo2));
			//query.addCriteria(Criteria.where("category").is(categoryNo));
			//query.with(Sort.by(Sort.Direction.DESC, "tot"));
			list = mongo.find(query, News.class);
			System.out.println(list.size());
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
		long count=0;
		try {
			
			// 페이징 처리 
			page = page >= 1 ? (page - 1) : 0;
			Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "crawlDate")); // page, size
			
			// list = mongo.findAll(News.class);
			if(searchType.equals("subject")) {	
				//BasicQuery query = new BasicQuery("{kor : {$gte : 80}}");
				// {$and : [{'crawlTitle': { $regex: '박용진'}},{'category' : {$in : ['200', '201']} }]}
				
				String a = "[";
				for(String s : categoryNo) {
					a += "'" + s + "',";
				}
				a = a.substring(0, a.length()-1) + "]";
				
				String bq = "{$and : [{'crawlTitle': { $regex: '"+searchName+"'}},{'category' : {$in : "+a+"} }]}";
				
				BasicQuery query = new BasicQuery(bq);
				query.with(pageable);
				list = mongo.find(query, News.class);
				count = list.size();
			} else if(searchType.equals("searchName")) {
				for(String dto : categoryNo) {
				BasicQuery query = new BasicQuery("{$and : [{'crawlSummary': { $regex: '"+searchName+"' },'category' :'"+dto+"' }]}");
				query.with(pageable);
				list = mongo.find(query, News.class);
				count += mongo.count(query, News.class);
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
		Map<String, Object> resultMap = new HashMap<String, Object>();
		long count=0;
		try {
			page = page >= 1 ? (page - 1) : 0;
			Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "crawlDate")); // page, size
			
			if(searchType.equals("subject")) {
				BasicQuery query = new BasicQuery("{$and : [{'crawlTitle': { $regex: '"+searchName+"' },'category' :'"+categoryNo+"' }]");
				query.with(pageable);
				list = mongo.find(query, News.class);
				count += mongo.count(query, News.class);
			} else if(searchType.equals("searchName")) {
				BasicQuery query = new BasicQuery("{$and : [{'crawlSummary': { $regex: '"+searchName+"' },'category' :'"+categoryNo+"' }]");
				query.with(pageable);
				list = mongo.find(query, News.class);
				count += mongo.count(query, News.class);
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
	/*
	public long dataListCount(List<String> categoryNoList, String searchType, String searchName) {
		long result=0;
		try {
			// list = mongo.findAll(News.class);
			if(searchType.equals("subject")) {
				//BasicQuery query = new BasicQuery("{kor : {$gte : 80}}");
				for(String dto : categoryNoList) {
					BasicQuery query = new BasicQuery("{$and : [{'crawlTitle': { $regex: 'searchName' },{'category' :'dto' }]");
					result += mongo.count(query, News.class);
				}
			} else if(searchType.equals("searchName")) {
				for(String dto : categoryNoList) {
				BasicQuery query = new BasicQuery("{$and : [{'crawlSummary': { $regex: 'searchName' },{'category' :'dto' }]");
				result += mongo.count(query, News.class);
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public long dataCount(List<String> categoryNoList, String searchType, String searchName) {
		long result=0;
		try {
			// list = mongo.findAll(News.class);
			if(searchType.equals("subject")) {
				//BasicQuery query = new BasicQuery("{kor : {$gte : 80}}");
				for(String dto : categoryNoList) {
					BasicQuery query = new BasicQuery("{$and : [{'crawlTitle': { $regex: 'searchName' },{'category' :'dto' }]");
					result += mongo.count(query, News.class);
				}
			} else if(searchType.equals("searchName")) {
				for(String dto : categoryNoList) {
				BasicQuery query = new BasicQuery("{$and : [{'crawlSummary': { $regex: 'searchName' },{'category' :'dto' }]");
				result += mongo.count(query, News.class);
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	*/
	//--------------------------------------------------
	
	public List<News> listNews(int page, int size) {
		List<News> list = null;
		
		try {
			page = page >= 1 ? (page - 1) : 0;

			/*
			// 페이징 처리 1
			Pageable pageable = new PageRequest(0, 10); // page, size
			Query query = new Query();
			query.with(pageable);
			list = mongo.find(query, News.class);
			*/
			
			// Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "tot"));
			Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "hakbeon"));
			Query query = new Query();
			query.with(pageable);
			list = mongo.find(query, News.class);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public News readNews(String hakbeon) {
		News dto=null;
		
		try {
			Query query = new Query();
			query.addCriteria(Criteria.where("hakbeon").is(hakbeon));
			dto = mongo.findOne(query, News.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	public void updateNews(News dto) throws Exception {
		try {
			Query  query = new Query();
			//query.addCriteria(Criteria.where("hakbeon").is(dto.getHakbeon()));
			Update update = new Update();
			/*  바꿀것만 set하면됨
			update.set("name", dto.getName());
			update.set("birth", dto.getBirth());
			update.set("kor", dto.getKor());
			update.set("eng", dto.getEng());
			update.set("mat", dto.getMat());
			update.set("tot", dto.getTot());
			update.set("ave", dto.getAve());
			*/
			mongo.updateFirst(query, update, News.class);
			
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	public void deleteNews(String hakbeon) throws Exception {
		try {
			Query  query = new Query();
			query.addCriteria(Criteria.where("hakbeon").is(hakbeon));
			
			News dto = mongo.findOne(query, News.class);
			mongo.remove(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	public Map<String, Object> search(String kwd) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if(kwd.equals("logical")) {
			//BasicQuery query = new BasicQuery("{kor : {$gte : 80}}");
			BasicQuery query = new BasicQuery("{$and : [{tot : {'$gte' : 250}}, {tot : {$lte : 300}}] }");
			List<News> list = mongo.find(query, News.class);
			 
			String result = "";
			for(News dto : list) {
				//result += "<p>"+dto.getName() + ":" + dto.getTot()+"</p>";
			}
			resultMap.put("result", result);
		} else if(kwd.equals("regex")) {
			BasicQuery query = new BasicQuery("{name: { $regex: '^이' }}");
			List<News> list = mongo.find(query, News.class);
			 
			String result = "";
			for(News dto : list) {
				//result += dto.getName() + " ";
			}
			resultMap.put("result", result);
		} else if(kwd.equals("aggregate")) {
			/*
			Aggregation agg = Aggregation.newAggregation(
					Aggregation.match(Criteria.where("dept").is("컴퓨터")),
					Aggregation.group("null").count().as("result"),
					Aggregation.sort(Sort.Direction.DESC, "result")
				);
			*/
			Aggregation agg = Aggregation.newAggregation(
					Aggregation.group("dept").count().as("result"),
					Aggregation.sort(Sort.Direction.DESC, "result")
				);
			
			AggregationResults<News> groupResults = mongo.aggregate(agg, News.class, News.class);
			List<News> list = groupResults.getMappedResults();			
			String result = "";
			for(News dto : list) {
				//result += "<p>" + dto.get_id() + ":" + dto.getResult() + "</p>";
			}
			
			resultMap.put("result", result);
		}
		
		return resultMap;
	}

}