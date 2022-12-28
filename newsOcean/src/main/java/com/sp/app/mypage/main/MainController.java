package com.sp.app.mypage.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("mypage.mainController")
@RequestMapping(value = "/mypage/*")
public class MainController {
	@RequestMapping(value = "main")
	public String main() {
		return ".mypage.main";
	}
}
