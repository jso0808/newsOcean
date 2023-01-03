package com.sp.app.sub.mail;

import java.util.List;

import com.sp.app.member.Member;
import com.sp.app.sub.Subscript;

public interface MailService {
	public List<Subscript> listSubscripter();
	public List<Member> listAllMember();
	
	public void insertSubMail(Mail mail);
	
}
