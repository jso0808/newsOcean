package com.sp.app.admin.main;

import org.springframework.data.mongodb.core.mapping.Document;

//컬렉션 이름 - 정민
@Document(collection = "realtime")
public class Realtime {

	private String num;
	private String keyword;
	private String link;
	
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
}
