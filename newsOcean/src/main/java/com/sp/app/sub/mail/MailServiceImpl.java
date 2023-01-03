package com.sp.app.sub.mail;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;
import com.sp.app.member.Member;
import com.sp.app.sub.Subscript;

@Service("mail.mailService")
public class MailServiceImpl implements MailService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Subscript> listSubscripter() {
		List<Subscript> list = null;
		try {
			list = dao.selectList("subscript.listSubscripter");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Member> listAllMember() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertSubMail(Mail mail) {
		try {
			dao.insertData("subscript.insertSubMail", mail);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
