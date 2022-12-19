package com.sp.app;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("main.mainController")
@RequestMapping("/main/*")
public class MainController {
	
	@RequestMapping("/main")
	public String login(Locale locale, Model model) {
        System.out.println();
        return "/test/main";
	}
}
