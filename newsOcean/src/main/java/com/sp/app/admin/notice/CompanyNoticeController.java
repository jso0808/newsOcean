package com.sp.app.admin.notice;

import java.io.File;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Qualifier;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.FileManager;
import com.sp.app.common.MyUtil;
import com.sp.app.member.SessionInfo;


@Controller("admin.notice.companyNoticeController")
@RequestMapping("/admin/notice/*")
public class CompanyNoticeController {
	@Autowired
	private CompanyNoticeService service;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value = "main")
	public String main() throws Exception {
		return ".admin.notice.main";
	}
	
	//AJAX - HTML
	@RequestMapping(value = "list")
	public String list(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		
		return "admin/notice/list";
		
		
	}
	
	
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String writeForm(Model model,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		
					//세션 처리 해야함
					/*
					SessionInfo info = (SessionInfo) session.getAttribute("member");
					if (info.getMembership() < 51) {
						resp.sendError(402);
						return "redirect:/notice/main";
					}
			
					*/
		
		model.addAttribute("mode", "write");
		model.addAttribute("pageNo", "1");
		
		return "admin/notice/write";
	}
	
	//AJAX- JSON
	@RequestMapping(value = "write", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> writeSubmit(CompanyNotice dto,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "false";
		
		try {
			
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" +File.separator + "admin_notice";
			
			dto.setMemberNo(info.getMemberNo());
			service.insertNotice(dto, pathname);
			state = "true";
			
			System.out.println(state);
			
		} catch (Exception e) {
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	
	
	
	
}
