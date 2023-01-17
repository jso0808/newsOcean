package com.sp.app.cs.qna;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.MyUtil;
import com.sp.app.member.SessionInfo;

@Controller("cs.qna.QnaController")
@RequestMapping("/cs/qna/*")
public class QnaController {
	@Autowired
	private QnaService service;
	@Autowired
	private MyUtil myUtil;

	@RequestMapping(value = "list")
	public String list(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,		
			HttpServletRequest req,
			Model model) throws Exception {

		int size = 10;
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

		// 리스트에 출력할 데이터를 가져오기
		int offset = (current_page - 1) * size;
		if(offset < 0) offset = 0;

		map.put("offset", offset);
		map.put("size", size);

		// 글 리스트
		List<Qna> list = service.listQna(map);

		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("size", size);
		model.addAttribute("total_page", total_page);

		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);

		return ".cs.qna.list";
	}

	@GetMapping("write")
	public String writeForm(Model model) throws Exception {

		model.addAttribute("mode", "write");

		return ".cs.qna.write";
	}

	@PostMapping("write")
	public String writeSubmit(Qna dto, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "qna";

		try {
			dto.setMemberNo(info.getMemberNo());
			service.insertQna(dto, pathname);
		} catch (Exception e) {
		}

		return "redirect:/cs/qna/list";
	}

	@GetMapping("article")
	public String article(@RequestParam long qnaNo,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpSession session,
			Model model) throws Exception {
		
		String query = "page=" + page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + 
					"&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}

		service.updateQnaHit(qnaNo);

		// 해당 레코드 가져 오기
		Qna dto = service.readQna(qnaNo);
		if (dto == null) {
			return "redirect:/cs/qna/list?" + query;
		}
		
		dto.setQnaContent(myUtil.htmlSymbols(dto.getQnaContent()));

		// 이전 글, 다음 글
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("qnaNo", qnaNo);

		Qna preReadQna = service.preReadQna(map);
		Qna nextReadQna = service.nextReadQna(map);

		model.addAttribute("dto", dto);
		model.addAttribute("preReadQna", preReadQna);
		model.addAttribute("nextReadQna", nextReadQna);
		
		model.addAttribute("page", page);
		model.addAttribute("query", query);

		return ".cs.qna.article";
	}

	@GetMapping("update")
	public String updateForm(@RequestParam long qnaNo,
			@RequestParam String page,
			HttpSession session,
			Model model) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		Qna dto = service.readQna(qnaNo);
		if (dto == null ||  info.getMemberNo() != dto.getMemberNo()) {
			return "redirect:/cs/qna/list?page=" + page;
		}

		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);

		return ".cs.qna.write";
	}

	@PostMapping("update")
	public String updateSubmit(Qna dto,
			@RequestParam String page,
			HttpSession session) throws Exception {

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "qna";

		try {
			service.updateQna(dto, pathname);
		} catch (Exception e) {
		}

		return "redirect:/cs/qna/list?page=" + page;
	}


	@RequestMapping(value = "delete")
	public String delete(@RequestParam long qnaNo,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		keyword = URLDecoder.decode(keyword, "utf-8");
		String query = "page=" + page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "qna";

		service.deleteQna(qnaNo, pathname, info.getMemberNo(), info.getMemberShip());

		return "redirect:/cs/qna/list?" + query;
	}

	// 댓글 리스트 : AJAX-TEXT
	@GetMapping("listAnswer")
	public String listAnswer(@RequestParam long qnaNo, 
			@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			HttpSession session,
			Model model) throws Exception {

		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		int size = 5;
		int total_page = 0;
		int answerCount = 0;

		Map<String, Object> map = new HashMap<>();
		map.put("qnaNo", qnaNo);
		
		map.put("memberShip", info.getMemberShip());
		map.put("memberNo", info.getMemberNo());
		
		map.put("qnaNo", qnaNo);

		answerCount = service.answerCount(map);
		total_page = myUtil.pageCount(answerCount, size);
		if (current_page > total_page) {
			current_page = total_page;
		}

		int offset = (current_page - 1) * size;
		if(offset < 0) offset = 0;

		map.put("offset", offset);
		map.put("size", size);
		
		List<QnaReply> list = service.listAnswer(map);

		for (QnaReply dto : list) {
			dto.setQnaAContent(dto.getQnaAContent().replaceAll("\n", "<br>"));
		}

		// AJAX 용 페이징
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");

		// 포워딩할 jsp로 넘길 데이터
		model.addAttribute("listAnswer", list);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("answerCount", answerCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		return "cs/qna/listAnswer";
	}

	// 댓글 및 댓글의 답글 등록 : AJAX-JSON
	@PostMapping("insertAnswer")
	@ResponseBody
	public Map<String, Object> insertAnswer(QnaReply dto, HttpSession session) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "true";

		try {
			dto.setMemberNo(info.getMemberNo());
			service.insertAnswer(dto);
		} catch (Exception e) {
			state = "false";
		}

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}

	// 댓글 및 댓글의 답글 삭제 : AJAX-JSON
	@PostMapping("deleteAnswer")
	@ResponseBody
	public Map<String, Object> deleteAnswer(@RequestParam Map<String, Object> paramMap) {
		String state = "true";
		
		try {
			service.deleteAnswer(paramMap);
		} catch (Exception e) {
			state = "false";
		}

		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		return map;
	}

	// 댓글의 답글 리스트 : AJAX-TEXT
	@GetMapping("listReply")
	public String listReply(@RequestParam Map<String, Object> paramMap, 
			HttpSession session, Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		paramMap.put("memberShip", info.getMemberShip());
		paramMap.put("memberNo", info.getMemberNo());
		
		List<QnaReply> listReply = service.listReply(paramMap);
		
		for (QnaReply dto : listReply) {
			dto.setQnaAContent(dto.getQnaAContent().replaceAll("\n", "<br>"));
		}

		model.addAttribute("listReply", listReply);
		return "cs/qna/listReply";
	}

	// 댓글의 답글 개수 : AJAX-JSON
	@PostMapping(value = "qnaAReplyCount")
	@ResponseBody
	public Map<String, Object> qnaAReplyCount(@RequestParam Map<String, Object> paramMap,
			HttpSession session) {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		paramMap.put("memberShip", info.getMemberShip());
		paramMap.put("memberNo", info.getMemberNo());
		
		int count = service.qnaAReplyCount(paramMap);

		Map<String, Object> model = new HashMap<>();
		model.put("count", count);
		return model;
	}

}
