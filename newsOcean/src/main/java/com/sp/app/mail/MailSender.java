package com.sp.app.mail;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.FileManager;

@Service("mail.myMailSender")
public class MailSender {
	@Autowired
	private FileManager fileManager;
	
	private String mailType; // 메일 타입
	private String encType;
	private String pathname;

	public MailSender() {
		this.encType = "utf-8";
		this.mailType = "text/html; charset=utf-8";
		// this.mailType = "text/plain; charset=utf-8";
		this.pathname = "c:" + File.separator + "temp" + File.separator + "mail";
	}

	public void setPathname(String pathname) {
		this.pathname = pathname;
	}

	// 네이버를 이용하여 메일을 보내는 경우 보내는사람의 이메일이 아래 계정(SMTP 권한 계정)과 다르면 메일 전송이 안된다.
	// gmail은 기본적으로 <a href ...> 태그가 있으면 href를 제거한다.
	// SMTP 권한
	private class SMTPAuthenticator extends javax.mail.Authenticator {
		@Override
		public PasswordAuthentication getPasswordAuthentication() {
			// gmail : 프로필(자기이름) 클릭 => 구글계정관리 버튼 클릭 => 좌측화면 보안 => 2단계인증
			//       패스워드 대신 2단계 인증 웹번호
			//       2022.5.31 부터 지메일은 보안수준이 낮은 앱 사용을 허용허지 않음
			// 네이버 : 메일 아래부분 환경설정 클릭후 POP3등을 허용
            //       POP3/SMTP, IMAP/SMTP 사용함 설정(나머지는 기본 설정)

			String username = "아이디@naver.com"; // 네이버 사용자;
			// String username = "아이디"; // gmail 사용자;
			String password = "패스워드"; // 패스워드;
			return new PasswordAuthentication(username, password);
		}
	}

	// 첨부 파일이 있는 경우 MIME을 MultiMime로 파일을 전송 한다.
	private void makeMessage(Message msg, Mail dto) throws MessagingException {
		if (dto.getSelectFile() == null || dto.getSelectFile().isEmpty()) {
			// 파일을 첨부하지 않은 경우
			// msg.setText(dto.getContent()); // 태그가 태그로 보임
			msg.setContent(dto.getContent(), "text/html; charset=utf-8");
			msg.setHeader("Content-Type", mailType);
		} else {
			// 파일을 첨부하는 경우

			// 메일 내용
			MimeBodyPart mbp1 = new MimeBodyPart();
			// mbp1.setText(dto.getContent());
			mbp1.setContent(dto.getContent(), "text/html; charset=utf-8");
			mbp1.setHeader("Content-Type", mailType);

			Multipart mp = new MimeMultipart();
			mp.addBodyPart(mbp1);

			// 첨부 파일
			for (MultipartFile mf : dto.getSelectFile()) {
				if (mf.isEmpty()) {
					continue;
				}

				try {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if (saveFilename != null) {
						dto.getSavePathname().add(pathname + File.separator + saveFilename);

						String originalFilename = mf.getOriginalFilename();
						MimeBodyPart mbp2 = new MimeBodyPart();
						FileDataSource fds = new FileDataSource(pathname + File.separator + saveFilename);
						mbp2.setDataHandler(new DataHandler(fds));

						if (originalFilename == null || originalFilename.length() == 0) {
							mbp2.setFileName(MimeUtility.encodeWord(fds.getName()));
						} else {
							mbp2.setFileName(MimeUtility.encodeWord(originalFilename));
						}
						
						mp.addBodyPart(mbp2);
					}
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			msg.setContent(mp);
		}
	}

	public boolean mailSend(Mail dto) {
		boolean b = false;

		Properties p = new Properties();

		// SMTP 서버의 계정 설정
		// Naver와 연결할 경우 네이버 아이디
		// Gmail과 연결할 경우 Gmail 아이디
		p.put("mail.smtp.user", "아이디");

		// SMTP 서버 정보 설정
		String host = "smtp.naver.com"; // 네이버
		// String host = "smtp.gmail.com"; // gmail
		
		p.put("mail.smtp.host", host);

		// 네이버와 지메일 동일
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		// p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");

		p.put("mail.smtp.ssl.enable", "true");
		p.put("mail.smtp.ssl.trust", host);
		
		try {
			Authenticator auth = new SMTPAuthenticator();
			Session session = Session.getDefaultInstance(p, auth);
			// 메일 전송시 상세 정보 콘솔에 출력 여부
			session.setDebug(true);

			Message msg = new MimeMessage(session);

			// 보내는 사람
			if (dto.getSenderName() == null || dto.getSenderName().equals("")) {
				msg.setFrom(new InternetAddress(dto.getSenderEmail()));
			} else {
				msg.setFrom(new InternetAddress(dto.getSenderEmail(), dto.getSenderName(), encType));
			}

			// 받는 사람
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(dto.getReceiverEmail()));

			// 제목
			msg.setSubject(dto.getSubject());

			makeMessage(msg, dto);
			msg.setHeader("X-Mailer", dto.getSenderName());

			// 메일 보낸 날짜
			msg.setSentDate(new Date());

			// 메일 전송
			Transport.send(msg);

			// 메일 전송후 서버에 저장된 첨부 파일 삭제
			if (dto.getSavePathname() != null && dto.getSavePathname().size() > 0) {
				for (String filename : dto.getSavePathname()) {
					File file = new File(filename);
					if (file.exists()) {
						file.delete();
					}
				}
			}

			b = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return b;
	}
}
