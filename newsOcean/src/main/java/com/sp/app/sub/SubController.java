package com.sp.app.sub;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.MyUtil;
import com.sp.app.member.SessionInfo;

@Controller("sub.subController")
@RequestMapping(value = "/sub/*")
public class SubController {
	
	@Autowired
	private SubService service;
	@Autowired
	private MyUtil myUtil;

	@RequestMapping(value = "main")
	public String main(Model model) {
		
		return ".sub.main";
	}
	
	@RequestMapping(value = "complete")
	public String payComplete(Model model) {
		
		return ".sub.complete";
	}
	
	// AJAX-JSON: 카카오페이 결제 내역 insert
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
	
	@RequestMapping(value = "list")
	public String subList(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(value = "selectSubType" , defaultValue = "0") int selectSub,
			HttpServletRequest req,
			Model model, 
			HttpSession session) throws Exception {
		
		int size = 5;
		int total_page = 0;
		int dataCount = 0;
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("selectSub", selectSub);
		map.put("memberNo", info.getMemberNo());
		
		// 조건별 데이터 카운트 
		dataCount = service.dataCount(map);
		if (selectSub == 0) { //X (조건 없을 때)
			dataCount = service.dataCount(map);
		} else { // 1개월 or 12개월 구독권만 
			dataCount = service.dataCountSub(map);
		}
		
		// 전체 페이지 수
		if(dataCount != 0) {
			total_page = myUtil.pageCount(dataCount, size);
		}
		
		// 자료 삭제 등으로 페이지 수 변화된 경우
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
		
		List<Subscript> list = null;
		
		// 검색 조건 판별하기
		if (selectSub == 0) { //X (조건 없을 때)
			list = service.listSubPay(info.getMemberNo());
		} else { // 1개월 or 12개월 구독권만 
			list = service.listSubPaySelectSub(map);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("size", size);
		model.addAttribute("total_page", total_page);
		
		return ".sub.list";
	}
	
	// AJAX - html: 결제내역 상세보기 (modal)
	@PostMapping(value = "subPayInfo")
	@ResponseBody
	public void findBySubPayInfo(String imp_uid, HttpServletResponse resp) throws IOException {
		Subscript sb = null;
		
		try {
			sb =  service.findBysubPayInfo(imp_uid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		JSONObject job = new JSONObject();
		job.put("paid_at", sb.getPaid_at());
		job.put("paid_amount", sb.getPaid_amount());
		job.put("merchant_uid", sb.getMerchant_uid());
		job.put("subType", sb.getSubType());
		job.put("subStart", sb.getSubStart());
		job.put("subEnd", sb.getSubEnd());
		job.put("firstMail", sb.getFirstMail());
		job.put("endOrNot", sb.getEndOrNot());
		
		resp.setContentType("text/html; charset=utf-8"); 
		PrintWriter out = resp.getWriter();
		// json 객체를 문자열로 변환
		out.print(job.toString());
	}
	

	
	
	
}
