package com.sp.app.news;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.MyUtil;
import com.sp.app.member.SessionInfo;

@Controller("news.newsController")
@RequestMapping("/news/*")
public class NewsController {
	@Autowired
	private NewsService service;
	@Autowired
	private MyUtil myUtil;
	
	// 테스트용 리스트 페이지
	@RequestMapping(value = "list")
	public String list(
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req, 
			Model model) {
		
		List<News> list = service.listNews();
		
		String cp = req.getContextPath();
		String articleUrl = cp + "/news/article?";
		
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("list", list);
		
		return ".news.list";
	}
	
	@RequestMapping(value = "article")
	public String article( 
			News news,
			@RequestParam(value = "crawlNo") long crawlNo,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpSession session,
			Model model) throws Exception{
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		int newsLikeCount = 0;
		
		// 조회수 +1 업데이트
		service.updateHitCount(news.getNewsNo());
		// 뉴스글 내용 가져오기
		news.setMemberNo(info.getMemberNo());
		News dto = service.readNews(news);
		if(dto == null) {
			return "redirect:/";
		}
		
		dto.setCrawlContent(dto.getCrawlContent().replaceAll("\n", "<br>"));
		dto.setCrawlSummary(dto.getCrawlSummary().replace("\n", "<br>"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("newsNo", crawlNo);
		
		map.put("memberNo", info.getMemberNo());
		// 뉴스글 좋아요 여부 가져오기
		boolean userNewsLiked = service.userNewsLiked(map);
		
		// 뉴스글의 좋아요 개수 가져오기
		newsLikeCount = service.newsLikeCount(crawlNo);
		
		model.addAttribute("dto", dto);
		model.addAttribute("userNewsLiked", userNewsLiked);
		model.addAttribute("newsLikeCount", newsLikeCount);

		return ".news.article";
	}
	
	@RequestMapping(value = "delete")
	public String delete() {
		// 몽고DB에서 delete
		return ".news.list";
	}
	
	@RequestMapping(value = "update")
	public String update() {
		// 몽고DB
		// 해당 뉴스글 존재하는지 확인 후 update
		return ".news.list";
	}
	
	// AJAX-JSON: 뉴스글 좋아요 추가/삭제
	@RequestMapping(value = "insertNewsLike")
	@ResponseBody
	public Map<String, Object> insertNewsLike(
			@RequestParam(value = "newsNo") long newsNo,
			@RequestParam boolean userNewsLiked,
			HttpSession session) {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "true";
		int newsLikeCount = 0;
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("newsNo", newsNo);
		paramMap.put("memberNo", info.getMemberNo());
		
		try {
			// 이미 좋아요 한 상태이면 (1)
			if(userNewsLiked) { 
				// 좋아요 데이터 삭제
				service.deleteNewsLike(paramMap);
			} else { 
				// 좋아요 데이터 추가
				service.insertNewsLike(paramMap);
			}
		} catch (DuplicateKeyException e) {
			state = "liked";
		} catch (Exception e) {
			state = "false";
		}
		
		newsLikeCount = service.newsLikeCount(newsNo);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		model.put("userNewsLiked", userNewsLiked);
		model.put("newsLikeCount", newsLikeCount);
		
		return model;
	}
	
	// AJAX-TEXT: 뉴스글 댓글 리스트 가져오기
	@RequestMapping(value = "listReply")
	public String listReply(
			@RequestParam(value = "newsNo") long newsNo,
			@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			HttpSession session,
			Model model) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		int size = 5;
		int total_page = 0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("newsNo", newsNo);
		map.put("memberNo", info.getMemberNo());
		map.put("memberShip", info.getMemberShip());
		
		dataCount = service.replyCount(map);
		total_page = myUtil.pageCount(dataCount, size);
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int offset = (current_page - 1) * size;
		if(offset < 0) {
			offset = 0;
		}
		
		map.put("offset", offset);
		map.put("size", size);
		
		List<Reply> listReply = service.listReply(map);
		
		if(listReply != null) {
			for(Reply dto : listReply) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
				System.out.println(dto.getUserReplyLiked());
			}
		}
		
		// AJAX 페이징 처리
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		// 댓글리스트 JSP로 넘길 데이터
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "news/listReply";
	}
	
	
	// AJAX-JSON : 뉴스 댓글 등록하기
	@RequestMapping(value = "insertReply")
	@ResponseBody
	public Map<String, Object> insertReply(Reply dto, HttpSession session){
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "true";
		
		try {
			System.out.println(dto.getContent());
			dto.setMemberNo(info.getMemberNo());
			service.insertReply(dto);
		} catch (Exception e) {
			state = "false";
		}
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		
		return model;
	}
	
	
	// AJAX-JSON: 뉴스글의 댓글 삭제하기
	@RequestMapping(value = "deleteReply")
	@ResponseBody
	public Map<String, Object> deleteReply(
			@RequestParam(value = "replyNo") long replyNo,
			HttpSession session) {
		String state = "true";
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("replyNo", replyNo);
			paramMap.put("memberNo", info.getMemberNo());
			
			service.deleteReply(paramMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state", state);
		
		return map; 
	}
	
	// AJAX-JSON: 뉴스 댓글에 좋아요 추가/삭제
	@RequestMapping(value = "insertReplyLike")
	@ResponseBody
	public Map<String, Object> insertReplyLike(
			@RequestParam(value = "replyNo") long replyNo,
			@RequestParam boolean userReplyLiked,
			HttpSession session) {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "true";
		int likeCount = 0;
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("replyNo", replyNo);
		paramMap.put("memberNo", info.getMemberNo());
		
		try {
			// 이미 댓글에 좋아요 한 상태이면 (1)
			if(userReplyLiked) { 
				// 댓글 좋아요 데이터 삭제
				service.deleteReplyLike(paramMap);
			} else { 
				// 댓글 좋아요 데이터 추가
				service.insertReplyLike(paramMap);
			}
		} catch (DuplicateKeyException e) {
			state = "liked";
		} catch (Exception e) {
			state = "false";
		}
		
		likeCount = service.replyLikeCount(replyNo);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		model.put("likeCount", likeCount);
		
		return model;
	}
	
	// AJAX1-JSON: 뉴스 댓글 숨김/해제 처리하기
	@RequestMapping(value = "replyShowHide")
	@ResponseBody
	public Map<String, Object> replyShowHide(
			@RequestParam Map<String, Object> paramMap,
			HttpSession session) {
		String state = "true";
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		try {
			paramMap.put("memberNo", info.getMemberNo());
			service.updateReplyShowHide(paramMap);
		} catch (Exception e) {
			state = "false";
		}
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		model.put("state", state);
		
		return model;
	}
	
	
	// AJAX-JSON: 뉴스 댓글 신고하기
	@RequestMapping(value = "replyComplain")
	@ResponseBody
	public void replyComplain(
			@RequestParam(value = "replyNo") long replyNo,
			@RequestParam(value = "complain") String complain,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		
		// 파라미터로 이용할 map
		Map<String, Object> paramMap = new HashMap<String, Object>();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "false";
		// 신고 처리 여부 메시지를 저장할 변수
		String msg = "";
		
		try {
			// 해당 댓글을 이전에 신고한 데이터가 존재하는지 확인
			paramMap.put("memberNo", info.getMemberNo());
			paramMap.put("replyNo", replyNo);
			boolean userReplyComplain = service.userReplyComplain(paramMap);
			
			// 신고 내역이 존재하면
			if(userReplyComplain) {
				msg = "이미 신고한 댓글입니다."; 
			} else { // 신고 내역이 없으면 
				// 신고 데이터 추가하기
				paramMap.put("complain", complain);
				service.insertReplyComplain(paramMap);
				msg = "신고 처리가 완료되었습니다.";
			}
			System.out.println(msg);
			// 해당 댓글의 신고 건 수가 3회 이상이면 댓글 숨김 처리
			int complainCount = service.complainCount(replyNo);
			if(complainCount >= 3) {
				paramMap.put("showHide", -1);
				service.updateReplyShowHide(paramMap);
			}
			state = "true";
		} catch (Exception e) {
		}
		
		JSONObject job = new JSONObject();
		job.put("state", state);
		job.put("msg", msg);
	
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();
		
		out.print(job.toString());
		
	}
	
	// AJAX-JSON: 북마크 추가/삭제
	@RequestMapping(value = "insertBookMark")
	@ResponseBody
	public Map<String, Object> insertBookMark(
			@RequestParam(value = "newsNo") long newsNo,
			@RequestParam boolean bookMarked,
			HttpSession session) {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "true";
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("newsNo", newsNo);
		paramMap.put("memberNo", info.getMemberNo());
		paramMap.put("bookMarkName", "북마크");
		
		try {
			if(bookMarked) { 
				// 해당 뉴스 북마크 데이터 삭제
				service.deleteBookMark(paramMap);
			} else { 
				// 북마크 데이터 추가
				service.insertBookMark(paramMap);
			}
		} catch (DuplicateKeyException e) {
			state = "liked";
		} catch (Exception e) {
			state = "false";
		}
		
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		
		return model;
	}
	
}
