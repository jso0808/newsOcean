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
	
	/*
	 *  - Redirect 후 즉시 사라짐. 서버로 다시 Submit해도 저장 안됨.
	 */
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
		sb.append("반가워요 "+dto.getUserNickName() + " 오셔너⛵🌊⛵🌊 ");
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
		
		Member dto = service.readMember(info.getUserEmail());
		if(dto == null) {
			session.invalidate();
			return "redirect:/;";
		}
		
		// 패스워드 검사
		boolean bPwd = service.isPasswordCheck(info.getUserEmail(), userPwd);
		
		if( ! bPwd ) {
			if (mode.equals("update")) {
				model.addAttribute("mode", "update");
			} else {
				model.addAttribute("mode", "dropout");
			}
			model.addAttribute("msg", "패스워드가 일치하지 않습니다.");
			return ".member.pwd";
		}
		
		if(mode.equals("dropout")) {
			// 회원 탈퇴
			/*
			 * Map<String, Object> map = new HashMap<>();
			 * map.put("memberIdx", info.getMemberIdx());
			 * map.put("userId", info.getUserId());
			 */
			
			// 세션 정보 삭제하기
			session.removeAttribute("member");
			session.invalidate();
			
			StringBuilder sb = new StringBuilder();
			sb.append(dto.getUserNickName() + "오셔너의 탈퇴 처리가 정상적으로 처리되었습니다. <br>");
			
			reAttr.addFlashAttribute("title", "회원 탈퇴");
			reAttr.addFlashAttribute("msg", sb.toString());
			
			return "redirect:/member/complete";
		}
		
		// 회원 정보 수정 폼
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		
		return ".member.member";
	}
	
	// AJAX - JSON : 이메일 중복 체크 
	@PostMapping(value = "userEmailCheck")
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
	
	// ninkNameCheck
	
}
