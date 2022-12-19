package com.sp.app.mail;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Mail {
	private String receiverEmail;  // 받는 사람  이메일
	private String senderEmail; // 보내는 사람  이메일
	private String senderName; // 보내는 사람  이름
	private String subject; // 메일 제목
	private String content; // 메일 내용

	// 스프링에서 파일 받기
	private List<MultipartFile> selectFile; // <input type="file" name="selectFile"
	private List<String> savePathname = new ArrayList<>();
	
	public String getReceiverEmail() {
		return receiverEmail;
	}
	public void setReceiverEmail(String receiverEmail) {
		this.receiverEmail = receiverEmail;
	}
	public String getSenderEmail() {
		return senderEmail;
	}
	public void setSenderEmail(String senderEmail) {
		this.senderEmail = senderEmail;
	}
	public String getSenderName() {
		return senderName;
	}
	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public List<MultipartFile> getSelectFile() {
		return selectFile;
	}
	public void setSelectFile(List<MultipartFile> selectFile) {
		this.selectFile = selectFile;
	}
	public List<String> getSavePathname() {
		return savePathname;
	}
	public void setSavePathname(List<String> savePathname) {
		this.savePathname = savePathname;
	}
}
