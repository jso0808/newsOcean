package com.sp.app.sub.mail;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.common.MyUtil;
import com.sp.app.sub.Subscript;

@Controller("mail.mailController")
@RequestMapping("/sub/mail/*")
public class MailController {
	@Autowired
	private MailService service;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private MailSender mailSender;
	
	@RequestMapping(value="send", method=RequestMethod.GET)
	public String sendForm(Model model) throws Exception {
		return ".sub.mail.send";
	}
	
	@GetMapping(value="guideForm")
	public String guideForm(Model model) throws Exception {
		return "sub/mail/guideForm";
	}
	
	@RequestMapping(value="listSendMail")
	public String listSendMail(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(value = "condition", defaultValue = "all") String condition,
			@RequestParam(value = "keyword", defaultValue = "") String keyword,
			@RequestParam(value = "size", defaultValue = "5") int size,
			HttpServletRequest req,
			Model model, 
			HttpSession session) throws Exception {
		
		System.out.println("*******************");
		System.out.println(condition);
		System.out.println(keyword);
		System.out.println("*******************");
		
		int total_page = 0;
		int dataCount = 0;
		
		// GET 방식인 경우
		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "UTF-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		
		// 전체 페이지 수 카운트
		if(dataCount != 0) {
			total_page = myUtil.pageCount(dataCount, size);
		}
		
		// 페이지 수가 변화된 경우
		if(total_page < current_page) {
			current_page = total_page;
		}
		
		// 리스트에 출력할 데이터 가져오기
		int offset = (current_page - 1) * size;
		if(offset < 0) {
			offset = 0;
		}
		
		map.put("offset", offset);
		map.put("size", size);
		
		List<Mail> list = service.listSendMail(map);
		
		String cp = req.getContextPath();
		String query = "size="+size;
		String listUrl = cp + "/sub/mail/listSendMail";
		String articleUrl = cp + "/sub/mail/article?page="+current_page;
		
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}
		
		if (query.length() != 0) {
			listUrl += "&" + query;
			articleUrl += "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("size", size);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		
		return ".sub.mail.listSendMail";
	}

	@RequestMapping(value="send", method=RequestMethod.POST)
	public String sendSubmit(Mail dto, 
			@RequestParam(value = "receiverGroup", defaultValue = "subscriber") String receiverGroup, 
			final RedirectAttributes reAttr) throws Exception {
		
		boolean b = false;
		String msg = "";
		long seq = 0;
		
		// 현재 날짜 기준, 구독중인  구독자의 이메일 리스트 가져오기
		List<Subscript> list = service.listSubscripter();
		// 수신인 카운트
		int cnt = 0;
		
		// 시퀀스 현재값 가져오기
		seq = service.sequenceSubMail();
		dto.setMailNo(seq);
		
		// 메일번호에 대한 메일 상세 정보 저장하기
		service.insertSubMailInfo(dto);
		
		// 구독자들에게 메일 전송하기. 구독자 수 만큼 반복.
		for (int i = 0; i < list.size(); i++) {
			// 구독자리스트의 이메일로 메일 전송. 전송 성공 여부 변수 b에 저장. 
			b = mailSender.mailSendSubscripter(dto, list.get(i).getEmail());
			
			// 메일번호, 구독자번호 저장하기
			dto.setSubNo(list.get(i).getSubNo());
			service.insertSubMail(dto);
			cnt++;
		}
		
		if(b) {
			msg+="메일을 성공적으로 전송 했습니다.";
		} else {
			msg+="메일을 전송하는데 실패했습니다.";
		}
		
		reAttr.addFlashAttribute("message", msg);
		reAttr.addFlashAttribute("cnt", cnt);
		
		return "redirect:/sub/mail/sendComplete";
	}
	
	@RequestMapping(value="sendComplete")
	public String complete(@ModelAttribute("message") String message) throws Exception{
		
		// 컴플릿 페이지(complete.jsp)의 출력되는 message와 title는 RedirectAttributes 값이다. 
		// F5를 눌러 새로 고침을 하면 null이 된다.
		
		if(message==null || message.length()==0) // F5를 누른 경우
			return "redirect:/";
		
		return ".sub.mail.sendComplete";
	}
	
	@RequestMapping(value="article")
	public String article(
			@RequestParam(value="mailNo") long mailNo,
			Model model) throws Exception {
		
		Mail mail = service.findByMailInfo(mailNo);
		
		Mail preMail = service.preFindByMailInfo(mailNo);
		Mail nextMail = service.nextFindByMailInfo(mailNo);
		
		model.addAttribute("dto", mail);
		model.addAttribute("preDto", preMail);
		model.addAttribute("nextDto", nextMail);
		
		return ".sub.mail.article";
	}
}
