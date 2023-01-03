package com.sp.app.sub.mail;

import java.util.List;

import com.sp.app.sub.Subscript;

public interface MailService {
	public List<Mail> listSendMail();
	public List<Subscript> listSubscripter();
	
	public long sequenceSubMail();
	public void insertSubMail(Mail mail);
	public void insertSubMailInfo(Mail mail);
	
}
