package com.sp.app.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller("member.memberController")
@RequestMapping(value = "/member/*")
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@GetMapping(value = "member")
	public String memberForm(Model model) {
		model.addAttribute("mode", "member");
		return ".member.member";
	}
	
	@PostMapping(value = "member")
	public String memberSubmit(Member dto, final RedirectAttributes reAttr,
			Model model) {
		
		try {
			service.insertMember(dto);

		} catch (DuplicateKeyException e) {
			model.addAttribute("mode", "member");
			model.addAttribute("msg", "이미 가입된 이메일입니다.");
			return ".member.member";
		} catch (DataIntegrityViolationException e) {
			// 제약조건 위배
			model.addAttribute("mode", "member");
			model.addAttribute("msg", "제약 조건 위반으로 회원 가입 실패");
			return ".member.member";
		} catch (Exception e) {
			model.addAttribute("mode", "member");
			model.addAttribute("msg", "회원 가입에 실패했습니다.");
			return ".member.member";
		}
		
		StringBuffer sb = new StringBuffer();
		sb.append("반가워요 "+dto.getNickName() + " 오셔너⛵🌊⛵🌊 ");
		sb.append("메인화면에서 로그인 해주세요.");
		
		// 리다이렉트된 페이지에 데이터 넘기기
		reAttr.addFlashAttribute("msg", sb.toString());
		reAttr.addFlashAttribute("title", "회원 가입");
		
		return "redirect:/member/complete";
	}
	
	@RequestMapping(value = "complete") 
	public String complete(@ModelAttribute("msg") String msg) throws Exception {
		
		// 새로 고침 시 null 
		if(msg == null || msg.length()==0) {
			return "redirect:/";
		}
		return ".member.complete";
	}
	
	// 로그인 폼
	@RequestMapping(value = "login")
	public String loginForm() {
		return ".member.login";
	}
	
	// 접근 권한 없는 경우
	@GetMapping("noAuthorized")
	public String noAuthorized() {
		return ".member.noAuthorized";
	}
	
	// 세션이 만료된 경우
	@GetMapping("expried")
	public String expried() {
		return ".member.expired";
	}
	
	// 패스워드 확인
	@GetMapping(value = "pwd")
	public String pwdForm(String dropout, Model model) {
		if(dropout == null) {
			model.addAttribute("mode", "update");
		} else {
			model.addAttribute("mode", "dropout");
		}
		
		return ".member.pwd";
	}
	
	@PostMapping(value = "pwd")
	public String pwdSubmit(@RequestParam String userPwd, 
			@RequestParam String mode,
			final RedirectAttributes reAttr,
			HttpSession session,
			Model model) {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Member dto = service.readMember(info.getEmail());
		if(dto == null) {
			session.invalidate();
			return "redirect:/";
		}
		
		// 패스워드 검사
		boolean bPwd = service.isPasswordCheck(info.getEmail(), userPwd);
		
		if( ! bPwd ) {
			if (mode.equals("update")) {
				model.addAttribute("mode", "update");
			} else {
				model.addAttribute("mode", "dropout");
			}
			model.addAttribute("msg", "패스워드가 일치하지 않습니다.");
			return ".member.pwd";
		}
		
		// 회원 정보 수정 폼
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		
		return ".member.member";
	}
	
	// 패스워드 찾기
	@RequestMapping(value = "pwdFind", method = RequestMethod.GET)
	public String pwdFindForm(HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info != null) {
			return "redirect:/";
		}
		
		return ".member.pwdFind";
	}
	
	@RequestMapping(value = "pwdFind", method = RequestMethod.POST)
	public String pwdFindSubmit(@RequestParam String email,
			RedirectAttributes reAttr,
			Model model) throws Exception {
		
		Member dto = service.readMember(email);
		if(dto == null || dto.getEmail() == null || dto.getEnabled() == 0) {
			model.addAttribute("message", "등록된 이메일이 아닙니다.");
			return ".member.pwdFind";
		}
		
		try {
			service.generatePwd(dto);
		} catch (Exception e) {
			model.addAttribute("message", "이메일 전송이 실패했습니다.");
			return ".member.pwdFind";
		}
		
		StringBuilder sb=new StringBuilder();
		sb.append("회원님의 이메일로 임시패스워드를 전송했습니다. 💌<br>");
		sb.append("로그인 후 패스워드를 변경해주세요! <br>");
		
		reAttr.addFlashAttribute("title", "임시 패스워드 발급");
		reAttr.addFlashAttribute("msg", sb.toString());
		
		return "redirect:/member/complete";
	}

	// AJAX - JSON : 회원가입 이메일 중복 체크 
	@RequestMapping(value = "emailCheck", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> emailCheck(@RequestParam String email) throws Exception {
		String p = "true";
		Member dto = service.readMember(email);
		if(dto != null) {
			p = "false";
		}
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("passed", p);
		
		return model;
	}
	
	// AJAX - JSON : 회원가입 닉네임 중복 체크 
	@RequestMapping(value = "nickNameCheck", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> nickNameCheck(@RequestParam String nickName) throws Exception {
		String p = "true";
		Member dto = service.readNickNameMember(nickName);
		if(dto != null) {
			p = "false";
		}
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("passed", p);
		
		return model;
	}
	
}
