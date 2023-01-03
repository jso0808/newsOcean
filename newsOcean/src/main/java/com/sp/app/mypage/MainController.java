package com.sp.app.mypage;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("mypage.mainController")
@RequestMapping(value = "/mypage/*")
public class MainController {
	
	@RequestMapping(value = "main")
	public String main(Model model) {
		
		return ".mypage.main";
	}
	
	@RequestMapping("activity")
	public String activity(Model model) {
		
		return ".mypage.activity";
	}
	
	@RequestMapping("bmember")
	public String bmember(Model model) {
		
		return ".mypage.bmember";
	}
	
	@RequestMapping("bookmark")
	public String bookmark(Model model) {
		
		return ".mypage.bookmark";
	}
	
	@RequestMapping("info")
	public String info(Model model) {
		
		return ".mypage.info";
	}
	@RequestMapping("keyword")
	public String keyword(Model model) {
		
		return ".mypage.keyword";
	}

}
