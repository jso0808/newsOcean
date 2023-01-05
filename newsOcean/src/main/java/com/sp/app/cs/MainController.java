package com.sp.app.cs;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("cs.mainController")
@RequestMapping(value = "/cs/*")
public class MainController {
	
	@RequestMapping(value = "main")
	public String main(Model model) {
		
		return ".cs.main";
	}
}
