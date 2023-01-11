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
	// private MongoTemplate mongo;
	private MongoOperations mongo;
	
	//페이징의 데이터개수
	public long dataCount(int categoryNo) {
		long result = 0;
		
		try {
			Query query = new Query();
			query.addCriteria(Criteria.where("category").is(categoryNo));
			result = mongo.count(query, News.class); // 조건, entityClass
			// result = mongo.count(query, "컬렉션명");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	//카테고리번호에 해당하는 뉴스리스트
	public List<News> categoryNews(int categoryNo) {
		
		List<News> list = null;
		
		try {
			// list = mongo.findAll(News.class);
			String categoryNo2 = Integer.toString(categoryNo);
			System.out.println(categoryNo2);
			Query query = new Query();
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
	//최신카테고리 뉴스리스트
	public List<News> recentlist(int categoryNo) {
		List<News> list = null;
		
		try {
			// list = mongo.findAll(News.class);
			String categoryNo2 = Integer.toString(categoryNo);
			System.out.println(categoryNo2);
			Query query = new Query();
			query.addCriteria(Criteria.where("category").is(categoryNo2));
			//query.addCriteria(Criteria.where("category").is(categoryNo));
			//query.with(Sort.by(Sort.Direction.DESC, "tot"));
			list = mongo.find(query, News.class);
			System.out.println(list);
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
			BasicQuery query = new BasicQuery("{crawlTitle: { $regex: '(searchWord)' }}");
			//? 변수 정규식로 넣으려고 하는데 어떻게
			List<News> list = mongo.find(query, News.class);
			 
			for(News dto : list) {
				wordlist.add(dto.getCrawlTitle());
			}
		} else if(searchType.equals("searchName")) {
			BasicQuery query = new BasicQuery("{name: { $regex: '(searchWord)' }}");
			List<News> list = mongo.find(query, News.class);
			 
			for(News dto : list) {
				wordlist.add(dto.getCrawlTitle());
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
	//
	/*
	public List<News>  searchlistNews(String searchType,String searchName,List<Integer> categoryNo) {
		try {
			// list = mongo.findAll(News.class);
			
			String categoryNo2 = Integer.toString(categoryNo);
			System.out.println(categoryNo2);
			Query query = new Query();
			query.addCriteria(Criteria.where("category").is(categoryNo2));
			//query.addCriteria(Criteria.where("category").is(categoryNo));
			//query.with(Sort.by(Sort.Direction.DESC, "tot"));
			  Query q = new Query(new Criteria().alike(example));
			list = mongo.find(query, News.class);
			System.out.println(list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
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