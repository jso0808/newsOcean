package com.sp.app.admin.notice;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Qualifier;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.FileManager;
import com.sp.app.common.MyUtil;
import com.sp.app.member.SessionInfo;


@Controller("admin.notice.companyNoticeController")
@RequestMapping("/admin/notice/*")
public class CompanyNoticeController {
	@Autowired
	private CompanyNoticeService service;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value = "main")
	public String main() throws Exception {
		return ".admin.notice.main";
	}
	
	//AJAX - HTML
	@RequestMapping(value = "list")
	public String list(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		int size = 10;
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) { 	//get 방식 불가
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		//전체 페이지 수 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		if(dataCount != 0) {
			total_page = myUtil.pageCount(dataCount, size);
		}
		
		// 전체 페이지수 조정
		if (total_page < current_page) {
			current_page = total_page;
		}
		
		// 1) 공지글 리스트
		List<CompanyNotice> noticeList = null;
		if(current_page == 1) {
			noticeList = service.listNoticeTop();
		}
		
		//리스트에 출력할 데이터 가져오기
		int offset = (current_page - 1) * size;
		if(offset < 0) offset = 0;

		map.put("offset", offset);
		map.put("size", size);
		
		// 2) 글 리스트
		List<CompanyNotice> list = service.listNotice(map);
		
		//최신글 gap 
		Date endDate = new Date();
		long gap;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for(CompanyNotice dto : list) {
			Date beginDate = sdf.parse(dto.getCompanyDate());
			
			//날짜 차이 - 시간
			gap = (endDate.getTime() - beginDate.getTime()) / (60*60*1000);
			dto.setGap(gap);
			
			// 다시 넣어주기
			dto.setCompanyDate(dto.getCompanyDate().substring(0,10));
		}
		
		//AJAX 메소드 이름 ~ ListPage(1) 
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("list", list);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("size", size);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		model.addAttribute("keyword", keyword);
		model.addAttribute("condition", condition);
		
		return "admin/notice/list";
	}
	
	
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String writeForm(Model model,
			HttpServletResponse resp,
			HttpSession session) throws Exception {

		model.addAttribute("mode", "write");
		model.addAttribute("pageNo", "1");
		
		return "admin/notice/write";
	}
	
	//AJAX- JSON
	@RequestMapping(value = "write", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> writeSubmit(CompanyNotice dto,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "false";
		
		try {
			
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" +File.separator + "admin_notice";
			
			dto.setMemberNo(info.getMemberNo());
			service.insertNotice(dto, pathname);
			state = "true";
			
			System.out.println(state);
			
		} catch (Exception e) {
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	// zip 파일 다운로드 - list
	@RequestMapping(value = "zipdownload")
	public void zipdownload(@RequestParam long companyNo,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" +File.separator + "admin_notice";
		
		boolean b = false;
		
		//해당 게시글의 file list 가져오기 
		List<CompanyNotice> listFile = service.listFile(companyNo);
		if(listFile.size() > 0) {
			String[] sources = new String[listFile.size()];
			String[] originals = new String[listFile.size()];
			String zipFilename = companyNo + ".zip";
			
			for (int idx = 0; idx < listFile.size(); idx++) {
				sources[idx] = pathname + File.separator + listFile.get(idx).getSaveFilename();
				originals[idx] = File.separator + listFile.get(idx).getOriginalFilename();
				
			}
			
			b = fileManager.doZipFileDownload(sources, originals, zipFilename, resp);
			
		}
		
		if ( ! b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>");
			} catch (Exception e) {
			}
		}
		
	}
	
	
	
	
	
	
}