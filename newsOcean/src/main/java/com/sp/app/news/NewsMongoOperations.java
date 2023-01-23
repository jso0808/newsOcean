package com.sp.app.news;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;


@Service("news.newsMongoOperations")
public class NewsMongoOperations {
	
	@Autowired
	private MongoOperations mongo;
	
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
	
	// 뉴스글 select where 원문링크
	public NewsOriginal readNews(String originLink) {
		NewsOriginal dto = null;
		
		try {
			Query query = new Query();
			query.addCriteria(Criteria.where("crawlUrl").is(originLink));
			dto = mongo.findOne(query, NewsOriginal.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	// 뉴스글 삭제
	public void deleteNews(String originLink) throws Exception {
		try {
			Query query = new Query();
			query.addCriteria(Criteria.where("crawlUrl").is(originLink));
			
			News dto = mongo.findOne(query, News.class);
			mongo.remove(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	// 구독 메일 작성 - 뉴스글 5개 제목,요약내용 리스트 가져오기
	public List<NewsOriginal> listNews(int page, int size) {
		List<NewsOriginal> list = null;
		
		try {
			// page = page >= 1 ? (page - 1) : 0;
			// 업로드일 내림차순으로 뉴스글 가져오기
			Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "_id"));
			Query query = new Query();
			query.with(pageable);
			list = mongo.find(query, NewsOriginal.class);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
}
