package com.sp.app.admin.notice;

import java.util.List;
import java.util.Map;

public interface CompanyNoticeService {
	public void insertNotice(CompanyNotice dto, String pathname) throws Exception;
	
	//카운트, 리스트 출력
	public int dataCount(Map<String, Object> map);
	public List<CompanyNotice> listNotice(Map<String, Object> map);
	public List<CompanyNotice> listNoticeTop();
	
	//글보기
	public void updateHitCount(long companyNo) throws Exception;
	public CompanyNotice readNotice(long companyNo);
	
	//수정, 삭제
	public void updateNotice(CompanyNotice dto, String pathname) throws Exception;
	public void deleteNotice(long companyNo, String pathname) throws Exception;
	
	//게시판 파일처리
	public void insertFile(CompanyNotice dto) throws Exception;
	public List<CompanyNotice> listFile(long companyNo);
	public CompanyNotice readFile(long fileNo);
	public void deleteFile(Map<String, Object> map) throws Exception;
	
	//이전글, 다음글
	public CompanyNotice preReadNotice(Map<String, Object> map);
	public CompanyNotice nextReadNotice(Map<String, Object> map);
	
	//댓글 리스트 
	public List<CompanyNotice> listReply(Map<String, Object> map);
	public int dataCount_reply(Map<String, Object> map);
	
	//댓글 추가
	public void insertReply(CompanyNotice dto) throws Exception;
	
	
	
}
