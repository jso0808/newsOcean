package com.sp.app.sub.mail;

import java.util.List;
import java.util.Map;

import com.sp.app.sub.Subscript;

public interface MailService {
	public List<Mail> listSendMail();
	public List<Subscript> listSubscripter();
	
	public int dataCount(Map<String, Object> map);
	
	// 보낸 메일의 상세 내용 가져오기
	public Mail findByMailInfo(long mailNo);
	// 메일을 받은 구독자 수 카운트
	public int findBySubMailCount(long mailNo);
	
	public long sequenceSubMail();
	public void insertSubMail(Mail mail);
	public void insertSubMailInfo(Mail mail);
	
}
