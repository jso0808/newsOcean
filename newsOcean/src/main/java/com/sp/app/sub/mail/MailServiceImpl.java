package com.sp.app.sub.mail;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;
import com.sp.app.sub.Subscript;

@Service("mail.mailService")
public class MailServiceImpl implements MailService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Mail> listSendMail() {
		List<Mail> list = null;
		
		try {
			list = dao.selectList("mail.listSendMail");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public List<Subscript> listSubscripter() {
		List<Subscript> list = null;
		try {
			list = dao.selectList("mail.listSubscripter");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	@Override
	public void insertSubMail(Mail mail) {
		try {
			dao.insertData("mail.insertSubMail", mail);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void insertSubMailInfo(Mail mail) {
		try {
			dao.insertData("mail.insertSubMailInfo", mail);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public long sequenceSubMail() {
		long seq = 0;
		
		try {
			seq = dao.selectOne("mail.sequenceSubMail");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return seq;
	}

	@Override
	public Mail findByMailInfo(long mailNo) {
		Mail mail = null;
		
		try {
			mail = dao.selectOne("mail.findByMailInfo", mailNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mail;
	}

	@Override
	public int findBySubMailCount(long mailNo) {
		int cnt = 0;
		
		try {
			cnt = dao.selectOne("mail.findBySubMailCount", mailNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}

	
	
}
