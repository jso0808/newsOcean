package com.sp.app.admin.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.sp.app.common.MyUtil;
import com.sp.app.member.SessionInfo;

@Controller("admin.mypage.mypageController")
@RequestMapping("/admin/mypage/*")
public class MypageController {
	@Autowired
	private MypageService service;
	@Autowired
	private MyUtil myUtil;
	
	//메인
	@RequestMapping(value = "main")
	public String main() throws Exception {
		return ".admin.mypage.main";
	}
	
	//메인 리스트 
	@RequestMapping(value = "list")
	public String list(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			HttpSession session, Model model) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(info.getMemberNo());
		map.put("memberNo", info.getMemberNo());
		
		List<Mypage> list = service.listMypage(map);
		
		model.addAttribute("list", list);
		
		return "admin/mypage/list";
	}
	
	//메인 리스트  - info
	@RequestMapping(value = "info")
	public String info(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			HttpSession session, Model model) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", info.getMemberNo());
		
		List<Mypage> list = service.listMypage(map);
		
		model.addAttribute("list", list);
		
		return "admin/mypage/info";
	}
	
	//관리자 리스트
	@RequestMapping(value = "listad")
	public String listad(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			HttpSession session, Model model) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", info.getMemberNo());
		
		List<Mypage> list = service.listAdmin(map);
		
		model.addAttribute("list", list);
		
		return "admin/mypage/listad";
	}
	
	
	
	//정보 변경
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(@RequestParam long memberNo,
			HttpSession session,
			HttpServletResponse resp,
			Model model) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Mypage dto = service.readMypage(info.getMemberNo());
		
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		
		return "admin/mypage/write";
		
	}
	
	// AJAX - JSON
	@RequestMapping(value = "update", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateSubmit(Mypage dto,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "false";
		
		try {
			
			dto.setMemberNo(info.getMemberNo());
			service.updateMypage(dto);
			
			state = "true";
			
		} catch (Exception e) {
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	//유효성 검사
	@RequestMapping(value = "findNickname")
	@ResponseBody
	public Map<String, Object> findNickname(@RequestParam String nickName) throws Exception {
		
		int result = 0;
		String state = "false";
		
		try {
			
			Mypage dto = new Mypage();
			dto.setNickName(nickName);
			result = service.findNickname(dto);
			
			
			if (result == 0) {
				state = "true";
			} else {
				state = "false";
			}
			
		} catch (Exception e) {
		}
		
		System.out.println(state);
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	
	//AJAX - HTML : LIST : qna 게시글
	@RequestMapping(value = "myqna")
	public String listQna(@RequestParam(value = "pageNo" , defaultValue = "1") int current_page,
			HttpServletRequest req, Model model) throws Exception {
		
		int size = 6;
		int total_page = 0;
		int dataCount = 0;
		
		//전체 페이지 수  - qna
		Map<String, Object> map =new HashMap<String, Object>();
		map.put("table", "qnareply");
		
		dataCount = service.dataCount(map);
		if(dataCount != 0) {
			total_page = myUtil.pageCount(dataCount, size);
		}
		
		if (total_page < current_page) {
			current_page = total_page;
		}
		
		//리스트
		int offset = (current_page - 1) * size;
		if(offset < 0) offset = 0;

		map.put("offset", offset);
		map.put("size", size);
		
		List<Mypage> list = service.listMyqna(map);
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listQna");
		
		model.addAttribute("list", list);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("size", size);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "admin/mypage/myqna";
	}
	
	//AJAX - HTML : LIST : faq 게시글
	@RequestMapping(value = "myfaq")
	public String listFaq(@RequestParam(value = "pageNo" , defaultValue = "1") int current_page,
			HttpServletRequest req, Model model) throws Exception {
		
		int size = 6;
		int total_page = 0;
		int dataCount = 0;
		
		//전체 페이지 수  - qna
		Map<String, Object> map =new HashMap<String, Object>();
		map.put("table", "faq");
		
		dataCount = service.dataCount(map);
		if(dataCount != 0) {
			total_page = myUtil.pageCount(dataCount, size);
		}
		
		if (total_page < current_page) {
			current_page = total_page;
		}
		
		//리스트
		int offset = (current_page - 1) * size;
		if(offset < 0) offset = 0;

		map.put("offset", offset);
		map.put("size", size);
		
		List<Mypage> list = service.listMyfaq(map);
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listFaq");
		
		model.addAttribute("list", list);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("size", size);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "admin/mypage/myfaq";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
