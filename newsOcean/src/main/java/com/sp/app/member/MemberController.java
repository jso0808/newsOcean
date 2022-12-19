package com.sp.app.member;

import javax.servlet.http.HttpSession;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller("member.memberController")
@RequestMapping(value = "/member/*")
public class MemberController {
	
	@GetMapping(value = "member")
	public String memberForm(Model model) {
		return ".member.member";
	}
	
	/*
	 *  - Redirect 후 즉시 사라짐. 서버로 다시 Submit해도 저장 안됨.
	 */
	@PostMapping(value = "member")
	public String memberSubmit(Member dto, final RedirectAttributes reAttr,
			Model model) {
		
		try {
		

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
		sb.append("반가워요 "+dto.getNinkName() + " 오셔너⛵🌊⛵🌊 ");
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
		
		
		
		return "";
	}
}
