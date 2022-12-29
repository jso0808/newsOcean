package com.sp.app.sub;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("sub.subController")
@RequestMapping(value = "/sub/*")
public class SubController {
	@Autowired
	private SubService service;

	@RequestMapping(value = "main")
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
	public void paySuccess(
			@RequestParam String memberNo,
			@RequestParam String imp_uid,
			@RequestParam String merchant_uid,
			@RequestParam long paid_amount,
			@RequestParam String paid_at,
			@RequestParam String pg_tid,
			@RequestParam String subStart,
			@RequestParam String subEnd,
			@RequestParam String firstMail,
			@RequestParam int selectNum, 
			Subscript sb,
			Model model,
			HttpServletResponse resp
			) throws Exception {
		
		sb.setMemberNo(Long.parseLong(memberNo));
		sb.setImp_uid(imp_uid);
		sb.setMerchant_uid(merchant_uid);
		sb.setPaid_amount(paid_amount);
		sb.setPg_tid(pg_tid);
		sb.setSubStart(subStart);
		sb.setSubEnd(subEnd);
		sb.setFirstMail(firstMail);
		sb.setSubType(selectNum);
		
		// 유닉스 타임스태프를 문자열로 변환
		long timestamp = Long.parseLong(paid_at);
		Date date = new Date(timestamp*1000L);
		
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		sdf.setTimeZone(TimeZone.getTimeZone("GMT+9")); 
	
		String time = sdf.format(date);
		System.out.println(time);
		sb.setPaid_at(time);
		
		String state = "false";

		try {
			service.insertSubPay(sb);
			
			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		JSONObject job = new JSONObject();
		job.put("state", state);
		
		resp.setContentType("text/html; charset=utf-8"); 
		PrintWriter out = resp.getWriter();
		// json 객체를 문자열로 변환
		out.print(job.toString());
		
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
