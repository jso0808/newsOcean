package com.sp.app.cs.notice;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
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

@Controller("cs.notice.noticeController")
@RequestMapping("/cs/notice/*")
public class NoticeController {
	@Autowired
	private NoticeService service;
	@Autowired
	private MyUtil myUtil;

	@RequestMapping(value = "main")
	public String main() throws Exception {
		return ".cs.notice.main";
	}

	// AJAX - HTML
	@RequestMapping(value = "list")
	public String list(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {

		int size = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}

		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);

		dataCount = service.dataCount(map);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(dataCount, size);
		}

		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if (total_page < current_page) {
			current_page = total_page;
		}

		// 1페이지인 경우 공지리스트 가져오기
		List<Notice> noticeList = null;
		if (current_page == 1) {
			noticeList = service.listNoticeTop();
		}

		// 리스트에 출력할 데이터를 가져오기
		int start = (current_page - 1) * size + 1;
		int end = current_page * size;
		map.put("start", start);
		map.put("end", end);

		// 글 리스트
		List<Notice> list = service.listNotice(map);

		Date endDate = new Date();
		long gap;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (Notice dto : list) {
			Date beginDate = formatter.parse(dto.getNoticeRegdate());
			/*
			 // 날짜차이(일)
			 gap=(endDate.getTime() - beginDate.getTime()) / (24 * 60 * 60 * 1000);
			 dto.setGap(gap);
			 */
			// 날짜차이(시간)
			gap = (endDate.getTime() - beginDate.getTime()) / (60 * 60 * 1000);
			dto.setGap(gap);

			dto.setNoticeRegdate(dto.getNoticeRegdate().substring(0, 10));
		}

		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");

		model.addAttribute("noticeList", noticeList);
		model.addAttribute("list", list);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("size", size);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);

		return "cs/notice/list";
	}

	// AJAX - HTML
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String writeForm(Model model, 
			HttpServletResponse resp,
			HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info.getMemberShip() < 51) {
			resp.sendError(402);
			return "redirect:/cs/notice/main";
		}

		model.addAttribute("mode", "write");
		model.addAttribute("pageNo", "1");

		return "/csnotice/write";
	}

	// AJAX - JSON
	@RequestMapping(value = "write", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> writeSubmit(Notice dto, 
			HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "false";
		
		try {
			if (info.getMemberShip() > 50) {
				String root = session.getServletContext().getRealPath("/");
				String pathname = root + "uploads" + "notice";
	
				dto.setMemberNo(info.getMemberNo());
				service.insertNotice(dto, pathname);
				state = "true";
			}
		} catch (Exception e) {
		}

		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}

	// AJAX - HTML
	@RequestMapping(value = "article")
	public String article(@RequestParam long noticeNo,
			@RequestParam String pageNo,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletResponse resp,
			Model model) throws Exception {

		keyword = URLDecoder.decode(keyword, "utf-8");

		Notice dto = service.readNotice(noticeNo);
		if (dto == null) {
			resp.sendError(410);
			return "redirect:/cs/notice/main";
		}

		dto.setNoticeContent(dto.getNoticeContent().replaceAll("\n", "<br>"));

		// 이전 글, 다음 글
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("noticeNo", noticeNo);

		Notice preReadDto = service.preReadNotice(map);
		Notice nextReadDto = service.nextReadNotice(map);


		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("pageNo", pageNo);

		return "cs/notice/article";
	}

	// AJAX - HTML
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(@RequestParam long noticeNo,
			@RequestParam String pageNo,
			HttpSession session,
			HttpServletResponse resp,
			Model model) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		Notice dto = service.readNotice(noticeNo);
		if (dto == null ||  info.getMemberNo() != dto.getMemberNo()) {
			resp.sendError(402);
			return "redirect:/cs/notice/main";
		}

		model.addAttribute("mode", "update");
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("dto", dto);

		return "cs/notice/write";
	}

	// AJAX - JSON
	@RequestMapping(value = "update", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateSubmit(Notice dto,
			HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "false";
		
		try {
			if (info.getMemberShip() > 50) {
				String root = session.getServletContext().getRealPath("/");
				String pathname = root + "uploads" + "notice";
	
				dto.setMemberNo(info.getMemberNo());
				service.updateNotice(dto, pathname);
				
				state = "true";
			}
		} catch (Exception e) {
		}

		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}

	// AJAX-JSON
	@RequestMapping(value = "delete")
	@ResponseBody
	public Map<String, Object> delete(@RequestParam long noticeNo,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String state = "false";
		try {
			if(info.getMemberShip() > 50) {
				String root = session.getServletContext().getRealPath("/");
				String pathname = root + "uploads" + "notice";
				service.deleteNotice(noticeNo, pathname);
				
				state = "true";
			}
		} catch (Exception e) {
		}

		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}

}
