package com.sp.app.main;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("main.mainController")
public class MainController {
	
	@RequestMapping("/recent")
	public String recent(Locale locale, Model model) {
        System.out.println();
        return ".main.recent";
	}
	
	@RequestMapping("/politics")
	public String politics(Locale locale, Model model) {
        System.out.println();
        return ".main.politics";
	}
	
	@RequestMapping("/economy")
	public String economy(Locale locale, Model model) {
        System.out.println();
        return ".main.economy";
	}
	
	@RequestMapping("/social")
	public String social(Locale locale, Model model) {
        System.out.println();
        return ".main.social";
	}
	
	@RequestMapping("/world")
	public String world(Locale locale, Model model) {
        System.out.println();
        return ".main.world";
	}
	
	@RequestMapping("/science")
	public String science(Locale locale, Model model) {
        System.out.println();
        return ".main.science";
	}
	
	@RequestMapping("/search")
	public String search(Locale locale, Model model) {
        System.out.println();
        return ".main.search";
	}
	
	@RequestMapping("/searchresult")
	public String searchresult(Locale locale, Model model) {
        System.out.println();
        return ".main.searchresult";
	}
	
}
