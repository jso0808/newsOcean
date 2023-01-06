package com.sp.app.news;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.stereotype.Service;

@Service("news.newsMongoOperations")
public class NewsMongoOperations {
	@Autowired
	// private MongoTemplate mongo;
	private MongoOperations mongo;
	
	
}
