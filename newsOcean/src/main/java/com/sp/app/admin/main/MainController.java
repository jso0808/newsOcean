package com.sp.app.admin.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("admin.mainController")
public class MainController {
	 
	@RequestMapping(value="/admin", method=RequestMethod.GET)
	public String method() {
		return ".adminLayout";
	}
}
