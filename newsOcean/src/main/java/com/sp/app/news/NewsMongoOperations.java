package com.sp.app.news;

import java.util.List;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

@Service("news.newsMongoOperations")
public class NewsMongoOperations {
	@Autowired
	// private MongoTemplate mongo;
	private MongoOperations mongo;
	
	
	/*
	public News preReadNews(News news);
	public News nextReadNews(News news);
	public void updateNews(News news);
	public void deleteNews(long newsNo, String memeberNo, String memberShip);
	*/
	
	
	// 뉴스글 list (메인 연결 전 테스트용(
	public List<News> listNews() {
		List<News> list = null;
		try {
			
			Query query = new Query();
			query.with(Sort.by(Sort.Direction.DESC, "_id"));
			list = mongo.findAll(News.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	// 뉴스글 select where 뉴스글번호
	public News readNews(ObjectId crawlNo) {
		News dto = null;
		
		try {
			Query query = new Query();
			query.addCriteria(Criteria.where("_id").is(crawlNo));
			dto = mongo.findOne(query, News.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	// 뉴스글 삭제
	public void deleteNews(ObjectId crawlNo) throws Exception {
		try {
			Query query = new Query();
			query.addCriteria(Criteria.where("_id").is(crawlNo));
			
			News dto = mongo.findOne(query, News.class);
			mongo.remove(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
}
