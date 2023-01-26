package com.sp.app.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.member.Member;
import com.sp.app.member.MemberService;
import com.sp.app.member.SessionInfo;
import com.sp.app.news.News;

@Controller("mypage.mainController")
@RequestMapping(value = "/mypage/*")
public class MainController {

	@Autowired
	private MypageService service;
	
	@Autowired
	private MemberService mservice;
	
	@Autowired
	private BCryptPasswordEncoder bcrytp;
	
	
	@RequestMapping(value = "main")
	public String main(Model model, HttpSession session) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if(info == null) return ".member.login";
		return ".mypage.main";
	}
	
	@GetMapping("keyword")
	public String keyword(HttpSession session,
			@RequestParam(name="keywordName", required=false) List<String> keywordName,
			Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if(info == null) return ".member.login";
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberNo", info.getMemberNo());
			List<Keyword> keywordList = service.readMyKeyword(map);
			
			model.addAttribute("keywordList", keywordList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ".mypage.keyword";
	}
	
	@RequestMapping("keywordDelete")
	public String keywordDelete(HttpSession session,
			@RequestParam String keywordName,
			Model model) {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if(info == null) return ".member.login";
			System.out.println("멤버번호:  "+ info.getMemberNo());
			map.put("keywordName", keywordName);
			map.put("memberNo", info.getMemberNo());
			service.deleteMyKeyword(map);
			List<Keyword> keywordList = service.readMyKeyword(map);
			
			model.addAttribute("keywordList", keywordList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ".mypage.keyword";
	}
	//키워드추가
	@PostMapping("addkeyword")
	public String addkeyword(HttpSession session,
			@RequestParam(name="keywordName", required=false) String keywordName,
			Model model) {
		
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if(info == null) return ".member.login";
			if(keywordName!=null) {
				Map<String, Object> map2 = new HashMap<String, Object>();
				map2.put("keywordName", keywordName);
				map2.put("memberNo", info.getMemberNo());
				
				service.insertMyKeyword(map2);
			}
			System.out.println("멤버번호:  "+ info.getMemberNo());
			map.put("memberNo", info.getMemberNo());
			List<Keyword> keywordList = service.readMyKeyword(map);
			
			model.addAttribute("keywordList", keywordList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ".mypage.keyword";
	}
	
	
	
	@GetMapping("activity")
	public String activityForm(Model model,HttpSession session) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if(info == null) return ".member.login";
		long memberNo = info.getMemberNo();
		map.put("memberNo", memberNo);
		List<Reply> list = service.readMyReply(map);
		List<QnaReply> QnaReplylist = service.readMyQnaReply(map);
		String Authority ="";
		//not admin
		
		for(Reply s : list) {
			System.out.println(s.getContent());
			News news = new News();
			news.setMemberNo(memberNo);
			System.out.println(news.getTitle());
		}
		if(!service.checkAuthority(memberNo)) {
			Authority ="no";
		}
		model.addAttribute("Authority", Authority);
		model.addAttribute("list", list);
		model.addAttribute("QnaReplylist", QnaReplylist);
		
		return ".mypage.activity";
	}
	
	@RequestMapping("qnaReplyDelete")
	public String qnaReplyDelete(Model model,HttpSession session,
				@RequestParam long qnaAnswer) {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if(info == null) return ".member.login";
			long memberNo = info.getMemberNo();
			map.put("memberNo", memberNo);
			map.put("qnaAnswer", qnaAnswer);
			service.deleteMyQnaReply(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ".mypage.activity";
	}
	@RequestMapping("newsReplyDelete")
	public String newsReplyDelete(Model model,HttpSession session,
				@RequestParam long replyNo) {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if(info == null) return ".member.login";
			long memberNo = info.getMemberNo();
			map.put("memberNo", memberNo);
			map.put("replyNo", replyNo);
			System.out.println(replyNo);
			service.deleteMyReply(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ".mypage.activity";
	}
	
	
	@GetMapping("bookmark")
	public String bookmarkForm(Model model, HttpSession session) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if(info == null) return ".member.login";
		List<Bookmark> bookmark = service.readMyBookmark(info.getMemberNo());
		model.addAttribute("bookmarkList", bookmark);
		for(Bookmark s : bookmark) {
			System.out.println(s.getBookmarkName());
		}
		return ".mypage.bookmark";
	}
	
	@RequestMapping(value = "deleteBookmark")
	public String deleteBookmark(@RequestParam long bookmarkNum,
			Model model, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if(info == null) return ".member.login";
		Map<String, Object> map = new  HashMap<String, Object>();
		
		long memberNo = info.getMemberNo();
		
		map.put("bookmarkNum", bookmarkNum);
		map.put("memberNo", memberNo);
		service.deleteMyBookmark(map);
		List<Bookmark> bookmarkList = service.readMyBookmark(memberNo);
		model.addAttribute("bookmarkList", bookmarkList);
		return ".mypage.bookmark";
	}
	
	@GetMapping(value = "info")
	public String infoForm(HttpSession session,
			Model model) {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if(info == null) return ".member.login";
		
		Member dto = mservice.readMember(info.getEmail());
		
		//이메일 email1@email2 분리
		String email = dto.getEmail();
		String tempEmail[] = email.split("@");
		String email1 = null;
		String email2 = null;
		if (tempEmail != null && tempEmail.length >= 2) {			
		    email1 = tempEmail[0];
		    email2 = tempEmail[1];
		}
		
		dto.setEmail1(email1);
		dto.setEmail2(email2);
		
		// 회원 정보 수정 폼
		model.addAttribute("dto", dto);
		
		return ".mypage.info";
	}
	
	@PostMapping(value = "infoSubmit")
	public String infoSubmit(@RequestParam String birth,
			@RequestParam String gender,
			@RequestParam String name,
			@RequestParam String nickName,
			@RequestParam(name="pwd", required=false) String pwd,
			HttpSession session,
			Model model){
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if(info == null) return ".member.login";
		Member dto = service.readMyInfo(info.getEmail());
		if((pwd.isEmpty() || pwd==null)) {
			pwd="";
		}
		String encPassword = bcrytp.encode(pwd);
		dto.setPwd(encPassword);
		dto.setEmail(info.getEmail());
		dto.setBirth(birth);
		dto.setGender(gender);
		dto.setName(name);
		dto.setNickName(nickName);
		
		// 패스워드 검사
		//수정 데이터 입력
		//패스워드 미수정(미입력)시
		if(pwd.isEmpty() || pwd==null) {
			try {
				service.updateMyInfo(dto);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			try {
				service.updateMyInfoPwd(dto);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return ".mypage.main";
	}
	

	//멤버 nickname, name, birth 개인정보 삭제, enabled 0, membership1로 설정 하여 비활성화
	@PostMapping(value="withDrawal")
	public String  withDrawal(HttpSession session,
			Model model) {
	
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if(info == null) return ".member.login";
		Member dto = mservice.readMember(info.getEmail());
		try {
			service.deleteMyInfo(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 세션 정보 삭제하기
		session.removeAttribute("member");
		session.invalidate();
		
		StringBuilder sb = new StringBuilder();
		sb.append(dto.getNickName() + "오셔너의 탈퇴 처리가 정상적으로 처리되었습니다.");
		model.addAttribute("sb", sb);
		
		return ".mypage.withdrawal";
	}

}
