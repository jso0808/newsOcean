package com.sp.app.sub;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("sub.subController")
@RequestMapping(value = "/sub/*")
public class SubController {
	@Autowired
	private SubService service;
	
	@GetMapping(value = "main")
	public String main(Model model) {
		return ".sub.main";
	}
}
