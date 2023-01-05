package com.sp.app.admin.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

@Service("admin.main.realtimeMongoOperations")
public class RealtimeMongoOperations {
	@Autowired
	private MongoOperations mongo;
	
	//갯수
	public long dataCount() {
		long result = 0;
		
		try {
			result = mongo.count(new Query(), Realtime.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
		
	}
	
	//리스트
	public List<Realtime> listRealtime(){
		List<Realtime> list = null;
		
		try {
			
			list = mongo.find(new Query(), Realtime.class);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
		
	}
	
	
}
