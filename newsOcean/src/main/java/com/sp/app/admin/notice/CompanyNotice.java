package com.sp.app.admin.notice;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class CompanyNotice {
	private long companyNo;
	private long memberNo; //작성자 번호
	private String companySubject; //제목
	private String companyContent; //내용
	private String companyDate; //작성일
	private int companyHitcount; //조회수
	private int notice; //처음 = 0
	
	//작성자 이름
	private String name;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	private long fileNo;
	private String saveFilename;
	private String originalFilename;
	private long fileSize;
	private int fileCount; //파일 갯수
	
	//파일 받기
	private List<MultipartFile> selectFile; // <input type="file" name="selectFile"
	private long gap;
	
	
	public long getCompanyNo() {
		return companyNo;
	}
	public void setCompanyNo(long companyNo) {
		this.companyNo = companyNo;
	}
	public long getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(long memberNo) {
		this.memberNo = memberNo;
	}
	public String getCompanySubject() {
		return companySubject;
	}
	public void setCompanySubject(String companySubject) {
		this.companySubject = companySubject;
	}
	public String getCompanyContent() {
		return companyContent;
	}
	public void setCompanyContent(String companyContent) {
		this.companyContent = companyContent;
	}
	public String getCompanyDate() {
		return companyDate;
	}
	public void setCompanyDate(String companyDate) {
		this.companyDate = companyDate;
	}
	public int getCompanyHitcount() {
		return companyHitcount;
	}
	public void setCompanyHitcount(int companyHitcount) {
		this.companyHitcount = companyHitcount;
	}
	public int getNotice() {
		return notice;
	}
	public void setNotice(int notice) {
		this.notice = notice;
	}
	public long getFileNo() {
		return fileNo;
	}
	public void setFileNo(long fileNo) {
		this.fileNo = fileNo;
	}
	public String getSaveFilename() {
		return saveFilename;
	}
	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}
	public String getOriginalFilename() {
		return originalFilename;
	}
	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	public int getFileCount() {
		return fileCount;
	}
	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
	}
	public List<MultipartFile> getSelectFile() {
		return selectFile;
	}
	public void setSelectFile(List<MultipartFile> selectFile) {
		this.selectFile = selectFile;
	}
	public long getGap() {
		return gap;
	}
	public void setGap(long gap) {
		this.gap = gap;
	}
	
	
	
	
	
	
	
}
