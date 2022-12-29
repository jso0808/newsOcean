package com.sp.app.sub;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.member.SessionInfo;

@Controller("sub.subController")
@RequestMapping(value = "/sub/*")
public class SubController {
	@Autowired
	private SubService service;

	@GetMapping(value = "main")
	public String main(Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		return ".sub.main";
	}
	
	@RequestMapping(value = "complete")
	public String payComplete(Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		return ".sub.complete";
	}
	
	@RequestMapping(value = "paySuccess")
	@ResponseBody
	public String paySuccess(@RequestParam String email,
			@RequestParam String imp_uid,
			@RequestParam String merchant,
			@RequestParam long amount,
			@RequestParam String paid_at,
			@RequestParam String selectSub,
			@RequestParam String dateSubStart,
			@RequestParam String dateSubEnd,
			@RequestParam String dateFirstMail,
			HttpSession session,
			Model model) throws Exception {
		
		System.out.println("kakao pay Post 실행이다.~");
		System.out.println(email);
		System.out.println(imp_uid);
		System.out.println(merchant);
		System.out.println(amount);
		System.out.println(paid_at);
		System.out.println(selectSub);
		System.out.println(dateSubStart);
		System.out.println(dateSubEnd);
		System.out.println(dateFirstMail);
		
		
		return "";
	}

	@PostMapping("/kakaoPay")
	public String kakaoPay(
			@RequestParam String email,
			@RequestParam String imp_uid,
			@RequestParam String merchant,
			@RequestParam long amount,
			@RequestParam String paid_at,
			@RequestParam String selectSub,
			@RequestParam String dateSubStart,
			@RequestParam String dateSubEnd,
			@RequestParam String dateFirstMail,
			HttpSession session,
			Model model
			) {
		System.out.println("kakao pay Post 실행이다.~");
		System.out.println(email);
		System.out.println(imp_uid);
		System.out.println(merchant);
		System.out.println(amount);
		System.out.println(paid_at);
		System.out.println(selectSub);
		System.out.println(dateSubStart);
		System.out.println(dateSubEnd);
		System.out.println(dateFirstMail);
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		
		if(selectSub.equals("monthSub")) {
			selectSub = "1개월 구독권";
		} else if (selectSub.equals("yearSub")) {
			selectSub = "12개월 구독권";
		}
		
		
		return "redirect:";
	}
	
	@GetMapping("/pay_complete")
	public void kakaoPaySuccess(@RequestParam("pg_token") String pg_token,
			Model model) {
		System.out.println("kakaoPaySuccess Get 실행이다");
		System.out.println("kakaoPaySuccess pg_token: " + pg_token);
		
		ApproveResponse approveResponse = service.kakaoPayInfo(pg_token);
		
		model.addAttribute("payInfo", approveResponse);
		
	}

	
	/**
	 * 날짜 더하기 함수
	 * @param strDate 	: 계산할 날짜
	 * @param year		: 더할 년도 수
	 * @param month		: 더할 월 수
	 * @param day		: 더할 일 수
	 * @return
	 * @throws Exception
	 
	private static String addDate(String strDate, int year, int month, int day) throws Exception {
		SimpleDateFormat dtFormat = new SimpleDateFormat("yyyyMMdd");

		Calendar cal = Calendar.getInstance();

		Date dt = dtFormat.parse(strDate);

		cal.setTime(dt);

		cal.add(Calendar.YEAR, year);
		cal.add(Calendar.MONTH, month);
		cal.add(Calendar.DATE, day);

		return dtFormat.format(cal.getTime());
	}
	*/
}
